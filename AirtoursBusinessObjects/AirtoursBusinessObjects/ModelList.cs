using System;
using System.Collections.Generic;

using System.Reflection;
using System.Diagnostics;

using System.Data;
using System.Data.SqlClient;

namespace AirtoursBusinessObjects {
    using Builder;
    using Schema;

    public abstract partial class ModelList<T> where T : Model, new() {
        protected readonly string table;
        protected readonly string pkColumn;

        protected SqlConnection connection;

        protected List<T> list;
        protected DataTable dataTable;
        protected TableSchema schema;

        protected PropertyInfo[] modelProperties;
        protected Dictionary<string, int> columnsOrdinals;

        protected string[] nonUpdateableColumns = new string[2];

        public ModelList() {
            var tableAttribute = typeof(T).GetCustomAttribute<TableAttribute>();

            this.table = tableAttribute.Name;
            this.pkColumn = tableAttribute.PkColumn;

            this.connection = new SqlConnection(Properties.Settings.Default.AirtoursConnectionString);

            this.list = new List<T>();
            this.dataTable = new DataTable(table);

            this.modelProperties = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly);
            this.columnsOrdinals = new Dictionary<string, int>();

            this.nonUpdateableColumns[0] = this.pkColumn;

            this.setDataTableColumns();
            this.fetchTableSchema();
        }

        /// <summary>
        /// Table name used in this data list.
        /// </summary>
        public string Table => this.table;

        /// <summary>
        /// List of current fetched records.
        /// </summary>
        public List<T> List => this.list;

        /// <summary>
        /// DataTable containing the current rows.
        /// </summary>
        public DataTable DataTable => this.dataTable;

        /// <summary>
        /// The table schema specification.
        /// </summary>
        public TableSchema TableSchema => this.schema;

        /// <summary>
        /// Id column of this data list table.
        /// </summary>
        public string PkColumn => this.pkColumn;

        /// <summary>
        /// Create new model which type is associated with this list.
        /// </summary>
        public T NewModel => new T();

        /// <summary>
        /// Create new WhereClause passing the current schema.
        /// </summary>
        public WhereClause WhereClause => new WhereClause(this.schema);

        /// <summary>
        /// Open the connection if it is closed.
        /// <exception cref="InvalidOperationException"></exception>
        /// <exception cref="SqlException"></exception>
        /// </summary>
        protected void openConnection() {
            if (this.connection.State.HasFlag(ConnectionState.Closed)) {
                this.connection.Open();
            }
        }

        /// <summary>
        /// Close the connection if it is opened.
        /// <exception cref="SqlException"></exception>
        /// </summary>
        protected void closeConnection() {
            if (this.connection.State.HasFlag(ConnectionState.Open)) {
                this.connection.Close();
            }
        }
    }

    partial class ModelList<T> {
        /// <summary>
        /// Construct the where clause for given model by the primary key
        /// </summary>
        /// <param name="command">Current SqlCommand instance</param>
        /// <param name="model">Model to be used for the value</param>
        /// <returns>Where clause string for the query</returns>
        protected virtual string whereModelClause(SqlCommand command, T model) {
            command.Parameters.AddWithValue(this.pkColumn, model.GetId());

            return $"WHERE [{this.pkColumn}] = @{this.pkColumn}";
        }

        /// <summary>
        /// Re-fill the supplied model details from the database.
        /// </summary>
        /// <param name="model">Model with valid primary key</param>
        public virtual void Fill(T model) {
            using (var command = this.connection.CreateCommand()) {
                var whereClause = this.whereModelClause(command, model);

                command.CommandText = $"SELECT * FROM [{this.table}] {whereClause};";

                try {
                    this.openConnection();

                    using (var reader = command.ExecuteReader()) {
                        this.setColumnsOrdinals(reader);

                        if (reader.Read()) {
                            this.setValues(model, reader);
                        }
                    }
                } catch (SqlException) {

                } finally {
                    this.closeConnection();
                }
            }
        }

        /// <summary>
        /// Add new model to the database.
        /// </summary>
        /// <param name="model">Model instance</param>
        public virtual void Add(T model) {
            using (var command = this.connection.CreateCommand())
            using (var insert = new InsertClause(this.schema)) {
                insert.Add(model, modelProperties);

                if (insert.HasAny) {
                    string insertFields = insert.InsertFields;
                    string insertValues = insert.InsertValues;

                    command.Parameters.AddRange(insert.Parameters);
                    command.CommandText = $"INSERT INTO [{this.table}] ({insertFields}) OUTPUT INSERTED.{this.pkColumn} VALUES ({insertValues});";

                    try {
                        this.openConnection();

                        object inserted_id = command.ExecuteScalar();

                        if (inserted_id is null == false && inserted_id is DBNull == false) {
                            model.SetId(inserted_id);
                        }

                        model.Inserted = true;

                        model.SetError(null);
                    } catch (SqlException ex) {
                        model.SetError(ex.Message);
                        Debug.WriteLine(ex, "ModelList.Add");
                    } finally {
                        this.closeConnection();
                    }
                }
            }
        }

        /// <summary>
        /// Update an existing model in the database.
        /// </summary>
        /// <param name="model">Model instance, with valid primary key. Data will be pulled from this model and updated into the database, where the primary key is equal to the saved one</param>
        /// <returns>Whether the row was updated or not</returns>
        public virtual bool Update(T model) {
            using (var command = this.connection.CreateCommand())
            using (var set = new SetClause(this.schema)) {
                int affectedRows = 0;

                set.Add(model, modelProperties, this.nonUpdateableColumns);

                if (set.HasAny) {
                    string setClause = set.ToString();
                    var whereClause = this.whereModelClause(command, model);

                    command.Parameters.AddRange(set.Parameters);
                    command.CommandText = $"UPDATE [{this.table}] {setClause} {whereClause};";

                    try {
                        this.openConnection();

                        affectedRows = command.ExecuteNonQuery();

                        model.SetError(null);
                    } catch (SqlException ex) {
                        model.SetError(ex.Message);
                        Debug.WriteLine(ex, "ModelList.Update");
                    } finally {
                        this.closeConnection();
                    }
                }

                return affectedRows > 0;
            }
        }

        /// <summary>
        /// Delete an existing model in the database.
        /// </summary>
        /// <param name="model">Model instance, with valid primary key. The equivalent row will be deleted permanently from the database.</param>
        /// <returns>Whether the row was deleted or not</returns>
        public virtual bool Delete(T model) {
            using (var command = this.connection.CreateCommand()) {
                int affectedRows = 0;
                var whereClause = this.whereModelClause(command, model);

                command.CommandText = $"DELETE FROM [{this.table}] {whereClause};";



                try {
                    this.openConnection();

                    affectedRows = command.ExecuteNonQuery();

                    model.SetError(null);
                } catch (SqlException ex) {
                    model.SetError(ex.Message);
                    Debug.WriteLine(ex, "ModelList.Delete");
                } finally {
                    this.closeConnection();
                }

                return affectedRows > 0;
            }
        }
    }

    partial class ModelList<T> {
        /// <summary>
        /// Populate the list (SELECT *)
        /// </summary>
        public bool Populate() {
            return this.Populate(null);
        }

        public bool Populate(string field, object value) {
            using (var whereClause = new WhereClause()) {
                whereClause.AndWhere(field, value);

                return this.Populate(whereClause);
            }
        }

        public bool Populate(WhereClause whereClause) {
            using (var command = this.connection.CreateCommand()) {
                bool hasRows = false;

                SqlParameter[] sqlParameters = whereClause?.Parameters;
                string suffix = $" {whereClause?.ToString()}" ?? "";

                command.CommandText = $"SELECT * FROM [{this.table}]{suffix};";
                if (sqlParameters is null == false) {
                    command.Parameters.AddRange(sqlParameters);
                }

                try {
                    this.openConnection();

                    using (var reader = command.ExecuteReader()) {
                        hasRows = reader.HasRows;

                        this.setColumnsOrdinals(reader);
                        this.generateList(reader);
                    }
                } catch (SqlException) {

                } finally {
                    this.closeConnection();
                }

                return hasRows;
            }
        }
    }

    partial class ModelList<T> {
        /// <summary>
        /// Recreate the current list with the values from the reader. It does empty the list at start.
        /// </summary>
        protected virtual void generateList(SqlDataReader reader) {
            this.list.Clear();
            this.dataTable.Rows.Clear();

            while (reader.Read()) {
                T model = new T();

                this.setValues(model, reader);
                model.Inserted = true;

                this.list.Add(model);
                this.addDataTableRow(model);
            }
        }

        /// <summary>
        /// Set values of given model from the current reader.
        /// </summary>
        /// <param name="model">Model to set properties value from the current reader.</param>
        protected void setValues(T model, SqlDataReader reader) {
            foreach (var property in modelProperties) {
                try {
                    int ordinal = columnsOrdinals[property.Name]; // Find value by matching property name
                    object value = reader.GetValue(ordinal);

                    if (value is DBNull) {
                        value = null; // Set value to null if matched with db type NULL
                    }

                    property.SetValue(model, value);
                } catch (KeyNotFoundException ex) { // Dictionary throws if key not found
                    Debug.WriteLine(ex, "ModelList.setValues");
                } catch (InvalidOperationException ex) {
                    Debug.WriteLine(ex, "ModelList.setValues");
                } catch (ArgumentException ex) { // PropertyInfo.SetValue throws
                    Debug.WriteLine(ex, "ModelList.setValues");
                } catch (TargetException ex) {
                    Debug.WriteLine(ex, "ModelList.setValues");
                } catch (MethodAccessException ex) {
                    Debug.WriteLine(ex, "ModelList.setValues");
                } catch (TargetInvocationException ex) {
                    Debug.WriteLine(ex, "ModelList.setValues");
                }
            }
        }

        /// <summary>
        /// Set columns ordinals (integer order of each column by name). It is inefficient to call within loop, so it being called once after each query and cached for usage.
        /// </summary>
        /// <param name="reader">Data reader to read ordinal from</param>
        protected void setColumnsOrdinals(SqlDataReader reader) {
            this.columnsOrdinals.Clear();

            foreach (var property in this.modelProperties) {
                try {
                    string propertyName = property.Name;
                    int columnOrdinal = reader.GetOrdinal(propertyName); // throws IndexOutOfRangeException

                    this.columnsOrdinals.Add(propertyName, columnOrdinal);
                } catch (IndexOutOfRangeException ex) { // No column with the specified name was found.
                    Debug.WriteLine(ex, "ModelList.setColumnsOrdinals");
                } catch (ArgumentNullException ex) {
                    Debug.WriteLine(ex, "ModelList.setColumnsOrdinals");
                } catch (ArgumentException ex) {
                    Debug.WriteLine(ex, "ModelList.setColumnsOrdinals");
                }
            }
        }

        protected void fetchTableSchema() {
            using (var command = this.connection.CreateCommand()) {
                command.CommandText = $"SELECT * FROM [{this.table}] WHERE 1 = 0;";

                try {
                    this.openConnection();

                    using (var reader = command.ExecuteReader(CommandBehavior.SchemaOnly)) {
                        var schemaTable = reader.GetSchemaTable();

                        this.schema = new TableSchema(schemaTable);
                    }
                } catch (SqlException) {

                } finally {
                    this.closeConnection();
                }
            }
        }

        protected void setDataTableColumns() {
            this.dataTable.Clear();
            this.dataTable.Rows.Clear();
            this.dataTable.Columns.Clear();

            DataColumn column;

            foreach (var property in this.modelProperties) {
                column = new DataColumn();

                column.DataType = Nullable.GetUnderlyingType(property.PropertyType) ?? property.PropertyType; // https://forums.asp.net/t/1796259.aspx?how+to+solve+this+DataSet+does+not+support+System+Nullable+
                column.ColumnName = property.Name;

                this.dataTable.Columns.Add(column);
            }
        }

        protected void addDataTableRow(T model) {
            DataRow row = this.dataTable.NewRow();

            foreach (var property in this.modelProperties) {
                row[property.Name] = property.GetValue(model) ?? DBNull.Value; // https://forums.asp.net/t/1796259.aspx?how+to+solve+this+DataSet+does+not+support+System+Nullable+
            }

            this.dataTable.Rows.Add(row);
        }
    }

    partial class ModelList<T> {
        public List<string> UniqueValues(string column, bool ascending = true) => this.UniqueValues<string>(column, ascending);
        public List<U> UniqueValues<U>(string column, bool ascending = true) {
            List<U> values = new List<U>();

            var whereClause = new WhereClause().AndWhereIsNull(column, true);
            var orderBy = ascending ? "ASC" : "DESC";

            using (var command = this.connection.CreateCommand()) {
                command.CommandText = $"SELECT DISTINCT[{column}] FROM [{this.table}] {whereClause.ToString()} ORDER BY [{column}] {orderBy};";

                try {
                    this.openConnection();

                    using (var reader = command.ExecuteReader()) {
                        while (reader.Read()) {
                            var value = reader.GetValue(0);

                            if (value is DBNull) {
                                continue;
                            }

                            if (typeof(U) != value.GetType()) {
                                value = Convert.ChangeType(value, typeof(U));
                            }

                            values.Add((U) value);
                        }
                    }
                } catch (SqlException) {
                } finally {
                    this.closeConnection();
                }
            }

            return values;
        }

        /// <summary>
        /// Filter list based on model being the foreign key with additional filtering. (Design Document Requirement #8)
        /// </summary>
        /// <param name="model">Model to be considered the foreign key</param>
        /// <param name="where">Optional where clause for additional filters</param>
        /// <returns>Whether there were any matching results</returns>
        public bool FilterPlus(Model model, WhereClause where = null) {
            using (var whereClause = (WhereClause) where?.Clone() ?? new WhereClause()) {
                var tableAttribute = model.GetType().GetCustomAttribute<TableAttribute>();

                string fkColumn = tableAttribute.PkColumn;
                object fkValue = model.GetId();

                whereClause.AndWhere(fkColumn, fkValue);

                return this.Populate(whereClause);
            }
        }

        /// <summary>
        /// Filter list based on model being the foreign key with additional filtering. (Design Document Requirement #8)
        /// </summary>
        /// <param name="fkColumn">Foreign key column name</param>
        /// <param name="fkValue">Foreign key value</param>
        /// <param name="where">Optional where clause for additional filters</param>
        /// <returns>Whether there were any matching results</returns>
        public bool FilterPlus(string fkColumn, object fkValue, WhereClause where = null) {
            using (var whereClause = (WhereClause) where?.Clone() ?? new WhereClause()) {
                whereClause.AndWhere(fkColumn, fkValue);

                return this.Populate(whereClause);
            }
        }

        /// <summary>
        /// Checks if there are any records meet these conditions. (Design Document Requirement #9)
        /// </summary>
        /// <param name="where">Where clause instance</param>
        /// <returns>Whether there is any records matching the provided filters</returns>
        public bool CheckChildRecords(WhereClause where) {
            return this.TotalCount(where) > 0;
        }
    }

    partial class ModelList<T> {
        protected enum AggregateFunctions {
            AVG, COUNT, MAX, MIN, SUM
        }

        public double TotalValue(string column, WhereClause whereClause = null) => this.aggregateValue<double>(AggregateFunctions.SUM, column, whereClause);
        public U TotalValue<U>(string column, WhereClause whereClause = null) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.aggregateValue<U>(AggregateFunctions.SUM, column, whereClause);
        }

        public int TotalCount() => this.aggregateValue<int>(AggregateFunctions.COUNT, this.pkColumn);
        public int TotalCount(WhereClause whereClause) {
            return this.aggregateValue<int>(AggregateFunctions.COUNT, this.pkColumn, whereClause);
        }

        public int MinValue(string column, WhereClause whereClause = null) => this.aggregateValue<int>(AggregateFunctions.MIN, column, whereClause);
        public U MinValue<U>(string column, WhereClause whereClause = null) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.aggregateValue<U>(AggregateFunctions.MIN, column, whereClause);
        }

        public int MaxValue(string column, WhereClause whereClause = null) => this.aggregateValue<int>(AggregateFunctions.MAX, column, whereClause);
        public U MaxValue<U>(string column, WhereClause whereClause = null) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.aggregateValue<U>(AggregateFunctions.MAX, column, whereClause);
        }

        public double AvgValue(string column, WhereClause whereClause = null) => this.aggregateValue<double>(AggregateFunctions.AVG, column, whereClause);
        public U AvgValue<U>(string column, WhereClause whereClause = null) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.aggregateValue<U>(AggregateFunctions.AVG, column, whereClause);
        }

        protected U aggregateValue<U>(AggregateFunctions aggregateFunction, string column, WhereClause whereClause = null) {
            U value = default(U);

            string aggregate = aggregateFunction.ToString();

            SqlParameter[] sqlParameters = whereClause?.Parameters;
            string suffix = whereClause?.ToString() ?? "";

            if (!this.schema.HasColumn(column)) {
                throw new ArgumentException($"{column} does not exists in this table schema.");
            }

            try {
                value = this.scalarQuery<U>($"SELECT {aggregate}([{column}]) FROM [{this.table}]{suffix};", sqlParameters);
            } catch (InvalidCastException ex) {
                Debug.WriteLine(ex, "ModelList.aggregateValue");
            }

            return value;
        }

        /// <summary>
        /// Query the maximum primary key value.
        /// </summary>
        /// <returns>Maximum id value</returns>
        public virtual int GetMaxID() => this.aggregateValue<int>(AggregateFunctions.MAX, this.pkColumn);

        protected object scalarQuery(string query, SqlParameter[] parameters = null) => this.scalarQuery<object>(query, parameters);

        /// <summary>
        /// Execute scalar query and convert to appropriate type.
        /// </summary>
        /// <typeparam name="U">Result data type</typeparam>
        /// <param name="query">The query to execute</param>
        /// <param name="parameters">Array of SqlParameter for this query (optional)</param>
        /// <returns></returns>
        protected U scalarQuery<U>(string query, SqlParameter[] parameters = null) {
            U value = default(U);

            try {
                using (var command = this.connection.CreateCommand()) {
                    command.CommandText = query;

                    if (parameters != null) {
                        command.Parameters.AddRange(parameters);
                    }

                    this.openConnection();
                    object result = command.ExecuteScalar();
                    if (typeof(U) == result.GetType()) {
                        value = (U) result;
                    } else {
                        value = (U) Convert.ChangeType(result, typeof(U));
                    }
                }
            } catch (InvalidCastException ex) {
                Debug.WriteLine(ex, "ModelList.scalarQuery");
            } catch (SqlException ex) {
                Debug.WriteLine(ex, "ModelList.scalarQuery");
            } catch (InvalidOperationException ex) {
                Debug.WriteLine(ex, "ModelList.scalarQuery");
            } catch (System.IO.IOException ex) {
                Debug.WriteLine(ex, "ModelList.scalarQuery");
            } catch (FormatException ex) {
                Debug.WriteLine(ex, "ModelList.scalarQuery");
            } catch (OverflowException ex) {
                Debug.WriteLine(ex, "ModelList.scalarQuery");
            } catch (ArgumentNullException ex) {
                Debug.WriteLine(ex, "ModelList.scalarQuery");
            } finally {
                this.closeConnection();
            }

            return value;
        }
    }

    partial class ModelList<T> {
        public virtual int UpdateMany(SetClause setClause, WhereClause whereClause) {
            using (var command = this.connection.CreateCommand()) {
                int affectedRows = 0;

                if (setClause.HasAny) {
                    command.Parameters.AddRange(setClause.Parameters);
                    command.CommandText = $"UPDATE [{this.table}] {setClause.ToString()} {whereClause.ToString()};";

                    try {
                        this.openConnection();

                        affectedRows = command.ExecuteNonQuery();
                    } catch (SqlException ex) {
                        Debug.WriteLine(ex, "ModelList.UpdateMany");
                    } finally {
                        this.closeConnection();
                    }
                }

                return affectedRows;
            }
        }

        /// <summary>
        /// Delete many records from the databases matching the provided where criteria.
        /// </summary>
        /// <param name="whereClause"></param>
        /// <returns></returns>
        public virtual int Delete(WhereClause whereClause) {
            if (whereClause is null || !whereClause.HasAny) {
                throw new ArgumentNullException("WhereClause cannot be null or empty. Dangerous operation.");
            }

            using (var command = this.connection.CreateCommand()) {
                int affectedRows = 0;

                command.CommandText = $"DELETE FROM [{this.table}] {whereClause.ToString()};";

                try {
                    this.openConnection();

                    affectedRows = command.ExecuteNonQuery();
                } catch (SqlException ex) {
                    Debug.WriteLine(ex, "ModelList.DeleteMany");
                } finally {
                    this.closeConnection();
                }

                return affectedRows;
            }
        }
    }
}

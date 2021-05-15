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
            var tableAttribute = typeof(T).GetCustomAttribute<TableAttribute>(); // Get the table attribute linked to the model type

            this.table = tableAttribute.Name; // Extract the table name from the table attribute
            this.pkColumn = tableAttribute.PkColumn; // Extract the table pk from the table attribute

            this.connection = new SqlConnection(Properties.Settings.Default.AirtoursConnectionString); // Create new SQL connection from the connection string in the settings

            this.list = new List<T>(); // Create new list of type T where T is the model passed 
            this.dataTable = new DataTable(table); // Create new data table by the name of the current table

            this.modelProperties = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly); // Get the specific model T properties, for later usage
            this.columnsOrdinals = new Dictionary<string, int>(); // Create dictionary to hold column ordinals (sorting order from the database table)

            this.nonUpdateableColumns[0] = this.pkColumn;

            this.SetDataTableColumns(); // Prepare data table column from the model properties
            this.FetchTableSchema(); // Fetch table schema for later usage
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
        protected void OpenConnection() {
            if (this.connection.State.HasFlag(ConnectionState.Closed)) {
                this.connection.Open();
            }
        }

        /// <summary>
        /// Close the connection if it is opened.
        /// <exception cref="SqlException"></exception>
        /// </summary>
        protected void CloseConnection() {
            if (this.connection.State.HasFlag(ConnectionState.Open)) {
                this.connection.Close();
            }
        }
    }

    partial class ModelList<T> {
        /// <summary>
        /// Construct the where clause for given model by the primary key
        /// </summary>
        /// <param name="model"></param>
        /// <returns>Where clause matching the model by primary key</returns>
        protected virtual WhereClause ModelWhereClause(T model) => this.WhereClause.Where(this.pkColumn, model.GetId());

        /// <summary>
        /// Re-fill the supplied model details from the database.
        /// </summary>
        /// <param name="model">Model with valid primary key</param>
        /// <returns></returns>
        public virtual bool Fill(T model) {
            bool found = false;

            using (var command = this.connection.CreateCommand())
            using (var where = this.ModelWhereClause(model)) {
                string whereClause = where.HasAny ? $" WHERE {where.ToString()}" : "";

                command.CommandText = $"SELECT * FROM [{this.table}]{whereClause};";
                if (where?.Parameters is null == false) {
                    command.Parameters.AddRange(where?.Parameters);
                }

                try {
                    this.OpenConnection();

                    using (var reader = command.ExecuteReader()) {
                        this.SetColumnsOrdinals(reader);
                        found = reader.HasRows;

                        if (reader.Read()) {
                            this.SetValues(model, reader);
                            model.SetError(null);
                        }
                    }
                } catch (Exception ex) {
                    model.SetError(ex.Message);

                    Debug.WriteLine(ex.Message, "ModelList.Fill");
                } finally {
                    this.CloseConnection();
                }
            }

            return found;
        }

        public virtual T FindOne(WhereClause where) {
            T model = null;

            if (where is null || !where.HasAny) {
                throw new ArgumentNullException("WhereClause cannot be null or empty. Dangerous operation.");
            }

            using (var command = this.connection.CreateCommand()) {
                SqlParameter[] sqlParameters = where?.Parameters;
                string whereClause = where.HasAny ? $" WHERE {where.ToString()}" : "";

                command.CommandText = $"SELECT TOP 1 * FROM [{this.table}]{whereClause};";
                if (sqlParameters is null == false) {
                    command.Parameters.AddRange(sqlParameters);
                }

                try {
                    this.OpenConnection();

                    using (var reader = command.ExecuteReader()) {
                        this.SetColumnsOrdinals(reader);

                        if (reader.Read()) {
                            model = new T {
                                Inserted = true
                            };

                            this.SetValues(model, reader);
                        }
                    }
                } catch (Exception ex) {
                    Debug.WriteLine(ex.Message, "ModelList.FindOne");
                } finally {
                    this.CloseConnection();
                }
            }

            return model;
        }

        /// <summary>
        /// Add new model to the database.
        /// </summary>
        /// <param name="model">Model instance</param>
        /// <returns></returns>
        public virtual bool Add(T model) {
            bool added = false;

            using (var command = this.connection.CreateCommand())
            using (var insert = new InsertClause(this.schema)) {
                insert.Add(model, modelProperties);

                if (insert.HasAny) {
                    string insertFields = insert.InsertFields;
                    string insertValues = insert.InsertValues;

                    command.Parameters.AddRange(insert.Parameters);
                    command.CommandText = $"INSERT INTO [{this.table}] ({insertFields}) OUTPUT INSERTED.{this.pkColumn} VALUES ({insertValues});";

                    try {
                        this.OpenConnection();

                        object inserted_id = command.ExecuteScalar();
                        added = true;

                        if (inserted_id is null == false && inserted_id is DBNull == false) {
                            model.SetId(inserted_id);
                        }

                        model.Inserted = true;

                        model.SetError(null);
                    } catch (Exception ex) {
                        model.SetError(ex.Message);
                        Debug.WriteLine(ex.Message, "ModelList.Add");
                    } finally {
                        this.CloseConnection();
                    }
                }
            }

            return added;
        }

        /// <summary>
        /// Update an existing model in the database.
        /// </summary>
        /// <param name="model">Model instance, with valid primary key. Data will be pulled from this model and updated into the database, where the primary key is equal to the saved one</param>
        /// <returns>Whether the row was updated or not</returns>
        public virtual bool Update(T model) {
            using (var command = this.connection.CreateCommand())
            using (var set = new SetClause(this.schema))
            using (var where = this.ModelWhereClause(model)) {
                int affectedRows = 0;

                set.Add(model, modelProperties, this.nonUpdateableColumns);

                if (set.HasAny) {
                    string setClause = set.ToString();
                    string whereClause = where.HasAny ? $" WHERE {where.ToString()}" : "";

                    command.CommandText = $"UPDATE [{this.table}] {setClause}{whereClause};";

                    if (set?.Parameters is null == false) {
                        command.Parameters.AddRange(set.Parameters);
                    }

                    if (where?.Parameters is null == false) {
                        command.Parameters.AddRange(where.Parameters);
                    }

                    try {
                        this.OpenConnection();

                        affectedRows = command.ExecuteNonQuery();

                        model.SetError(null);
                    } catch (Exception ex) {
                        model.SetError(ex.Message);
                        Debug.WriteLine(ex.Message, "ModelList.Update");
                    } finally {
                        this.CloseConnection();
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
            using (var command = this.connection.CreateCommand())
            using (var where = this.ModelWhereClause(model)) {
                int affectedRows = 0;

                string whereClause = where.HasAny ? $" WHERE {where.ToString()}" : "";

                command.CommandText = $"DELETE FROM [{this.table}]{whereClause};";
                if (where?.Parameters is null == false) {
                    command.Parameters.AddRange(where.Parameters);
                }

                try {
                    this.OpenConnection();

                    affectedRows = command.ExecuteNonQuery();

                    model.SetError(null);
                } catch (Exception ex) {
                    model.SetError(ex.Message);
                    Debug.WriteLine(ex.Message, "ModelList.Delete");
                } finally {
                    this.CloseConnection();
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
            using (var whereClause = this.WhereClause) {
                whereClause.Where(field, value);

                return this.Populate(whereClause);
            }
        }

        /// <summary>
        /// Filter list based on model being the foreign key with additional filtering. (Design Document Requirement #8)
        /// </summary>
        /// <param name="model">Model to be considered the foreign key</param>
        /// <param name="where">Optional where clause for additional filters</param>
        /// <returns>Whether there were any matching results</returns>
        public bool FilterPlus(Model model, WhereClause where = null) {
            using (var whereClause = where?.Clone() ?? this.WhereClause) {
                var tableAttribute = model.GetType().GetCustomAttribute<TableAttribute>();

                string fkColumn = tableAttribute.PkColumn;
                object fkValue = model.GetId();

                whereClause.Where(fkColumn, fkValue);

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
            using (var whereClause = where?.Clone() ?? this.WhereClause) {
                whereClause.Where(fkColumn, fkValue);

                return this.Populate(whereClause);
            }
        }

        /// <summary>
        /// Filter the current list based on filters and being joined to another table.
        /// </summary>
        /// <param name="where">Where clause filters</param>
        /// <param name="joinTable">Table name to join with</param>
        /// <param name="joinColumn">Join column between two tables</param>
        /// <returns>Whether there were any matching results</returns>
        public bool FilterJoin(WhereClause where, string joinTable, string joinColumn) => this.FilterJoin(where, null, joinTable, joinColumn);

        /// <summary>
        /// Filter the current list based on filters and being joined to another table.
        /// </summary>
        /// <param name="where">Where clause filters</param>
        /// <param name="on">On clause filters</param>
        /// <param name="joinTable">Table name to join with</param>
        /// <param name="joinColumn">Join column between two tables</param>
        /// <returns>Whether there were any matching results</returns>
        public bool FilterJoin(WhereClause where, WhereClause on, string joinTable, string joinColumn) {
            using (var command = this.connection.CreateCommand()) {
                string whereClause = (where?.HasAny ?? false) ? $" WHERE {where?.ToString("T")}" : "";
                string onClause = (on?.HasAny ?? false) ? $" AND {on?.ToString("J")}" : "";

                command.CommandText = $@"SELECT T.* FROM [{this.table}] T
                                         INNER JOIN [{joinTable}] J
                                            ON T.[{joinColumn}] = J.[{joinColumn}]{onClause}
                                         {whereClause};";

                if (where?.Parameters is null == false) {
                    command.Parameters.AddRange(where?.Parameters);
                }

                if (on?.Parameters is null == false) {
                    command.Parameters.AddRange(on?.Parameters);
                }

                return this.PopulateWithQuery(command);
            }
        }

        /// <summary>
        /// Populate the current list based on provided filters
        /// </summary>
        /// <param name="whereClause">Where clause filters (Optional)</param>
        /// <returns>Whether there were any matching results</returns>
        public bool Populate(WhereClause where) {
            using (var command = this.connection.CreateCommand()) {
                SqlParameter[] sqlParameters = where?.Parameters;
                string whereClause = (where?.HasAny ?? false) ? $" WHERE {where?.ToString()}" : "";

                command.CommandText = $"SELECT * FROM [{this.table}]{whereClause};";
                if (sqlParameters is null == false) {
                    command.Parameters.AddRange(sqlParameters);
                }

                return this.PopulateWithQuery(command);
            }
        }
    }

    partial class ModelList<T> {
        protected bool PopulateWithQuery(SqlCommand command) {
            bool hasRows = false;

            try {
                this.OpenConnection();

                using (var reader = command.ExecuteReader()) {
                    hasRows = reader.HasRows;

                    this.SetColumnsOrdinals(reader);
                    this.RepopulateList(reader);
                }
            } catch (Exception ex) {
                Debug.WriteLine(ex.Message, "ModelList.populateWithQuery");
            } finally {
                this.CloseConnection();
            }

            return hasRows;
        }

        /// <summary>
        /// Recreate the current list with the values from the reader. It does empty the list at start.
        /// </summary>
        protected virtual void RepopulateList(SqlDataReader reader) {
            this.list.Clear();
            this.dataTable.Rows.Clear();

            while (reader.Read()) {
                T model = new T();

                this.SetValues(model, reader);
                model.Inserted = true;

                this.list.Add(model);
                this.AddDataTableRow(model);
            }
        }

        /// <summary>
        /// Set values of given model from the current reader.
        /// </summary>
        /// <param name="model">Model to set properties value from the current reader.</param>
        protected void SetValues(T model, SqlDataReader reader) {
            foreach (var property in modelProperties) {
                try {
                    int ordinal = columnsOrdinals[property.Name]; // Find value by matching property name
                    object value = reader.GetValue(ordinal);

                    if (value is DBNull) {
                        value = null; // Set value to null if matched with db type NULL
                    }

                    property.SetValue(model, value);
                } catch (Exception ex) { // Dictionary throws if key not found
                    Debug.WriteLine(ex.Message, "ModelList.setValues");
                }
            }
        }

        /// <summary>
        /// Set columns ordinals (integer order of each column by name). It is inefficient to call within loop, so it being called once after each query and cached for usage.
        /// </summary>
        /// <param name="reader">Data reader to read ordinal from</param>
        protected void SetColumnsOrdinals(SqlDataReader reader) {
            this.columnsOrdinals.Clear();

            foreach (var property in this.modelProperties) {
                try {
                    string propertyName = property.Name;
                    int columnOrdinal = reader.GetOrdinal(propertyName); // throws IndexOutOfRangeException

                    this.columnsOrdinals.Add(propertyName, columnOrdinal);
                } catch (Exception ex) { // No column with the specified name was found.
                    Debug.WriteLine(ex.Message, "ModelList.setColumnsOrdinals");
                }
            }
        }

        protected void FetchTableSchema() {
            using (var command = this.connection.CreateCommand()) {
                command.CommandText = $"SELECT * FROM [{this.table}] WHERE 1 = 0;";

                try {
                    this.OpenConnection();

                    using (var reader = command.ExecuteReader(CommandBehavior.SchemaOnly)) {
                        var schemaTable = reader.GetSchemaTable();

                        this.schema = new TableSchema(schemaTable);
                    }
                } catch (Exception ex) {
                    Debug.WriteLine(ex.Message, "ModelList.fetchTableSchema");
                } finally {
                    this.CloseConnection();
                }
            }
        }

        protected void SetDataTableColumns() {
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

        protected void AddDataTableRow(T model) {
            DataRow row = this.dataTable.NewRow();

            foreach (var property in this.modelProperties) {
                row[property.Name] = property.GetValue(model) ?? DBNull.Value; // https://forums.asp.net/t/1796259.aspx?how+to+solve+this+DataSet+does+not+support+System+Nullable+
            }

            this.dataTable.Rows.Add(row);
        }
    }

    partial class ModelList<T> {
        public List<string> UniqueValues(string column, bool ascending = true) => this.UniqueValues<string>(column, null, ascending);
        public List<U> UniqueValues<U>(string column, bool ascending = true) => this.UniqueValues<U>(column, null, ascending);

        public List<string> UniqueValues(string column, WhereClause where = null, bool ascending = true) => this.UniqueValues<string>(column, where, ascending);
        public List<U> UniqueValues<U>(string column, WhereClause where = null, bool ascending = true) {
            List<U> values = new List<U>();

            using (var command = this.connection.CreateCommand())
            using (var whereClause = where?.Clone() ?? this.WhereClause) {
                whereClause.WhereIs(column, null, false);

                string whereString = (whereClause?.HasAny ?? false) ? $" WHERE {whereClause?.ToString()}" : "";
                string orderBy = ascending ? "ASC" : "DESC";

                command.CommandText = $"SELECT DISTINCT [{column}] FROM [{this.table}]{whereString} ORDER BY [{column}] {orderBy};";
                command.Parameters.AddRange(whereClause.Parameters);

                try {
                    this.OpenConnection();

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
                } catch (Exception ex) {
                    Debug.WriteLine(ex.Message, "ModelList.UniqueValues");
                } finally {
                    this.CloseConnection();
                }
            }

            return values;
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

        public double TotalValue(string column, WhereClause whereClause = null) => this.AggregateValue<double>(AggregateFunctions.SUM, column, whereClause);
        public U TotalValue<U>(string column, WhereClause whereClause = null) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.AggregateValue<U>(AggregateFunctions.SUM, column, whereClause);
        }

        public int TotalCount(WhereClause whereClause = null) {
            return this.AggregateValue<int>(AggregateFunctions.COUNT, this.pkColumn, whereClause);
        }

        public int MinValue(string column, WhereClause whereClause = null) => this.AggregateValue<int>(AggregateFunctions.MIN, column, whereClause);
        public U MinValue<U>(string column, WhereClause whereClause = null) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.AggregateValue<U>(AggregateFunctions.MIN, column, whereClause);
        }

        public int MaxValue(string column, WhereClause whereClause = null) => this.AggregateValue<int>(AggregateFunctions.MAX, column, whereClause);
        public U MaxValue<U>(string column, WhereClause whereClause = null) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.AggregateValue<U>(AggregateFunctions.MAX, column, whereClause);
        }

        public double AvgValue(string column, WhereClause whereClause = null) => this.AggregateValue<double>(AggregateFunctions.AVG, column, whereClause);
        public U AvgValue<U>(string column, WhereClause whereClause = null) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.AggregateValue<U>(AggregateFunctions.AVG, column, whereClause);
        }

        protected U AggregateValue<U>(AggregateFunctions aggregateFunction, string column, WhereClause where = null) {
            U value = default(U);

            string aggregate = aggregateFunction.ToString();

            SqlParameter[] sqlParameters = where?.Parameters;
            string whereClause = (where?.HasAny ?? false) ? $" WHERE {where?.ToString()}" : "";

            if (!this.schema.HasColumn(column)) {
                throw new ArgumentException($"{column} does not exists in this table schema.");
            }

            try {
                value = this.ScalarQuery<U>($"SELECT {aggregate}([{column}]) FROM [{this.table}]{whereClause};", sqlParameters);
            } catch (Exception ex) {
                Debug.WriteLine(ex.Message, "ModelList.aggregateValue");
            }

            return value;
        }

        /// <summary>
        /// Query the maximum primary key value.
        /// </summary>
        /// <returns>Maximum id value</returns>
        public virtual int GetMaxID() => this.AggregateValue<int>(AggregateFunctions.MAX, this.pkColumn);

        protected object ScalarQuery(string query, SqlParameter[] parameters = null) => this.ScalarQuery<object>(query, parameters);

        /// <summary>
        /// Execute scalar query and convert to appropriate type.
        /// </summary>
        /// <typeparam name="U">Result data type</typeparam>
        /// <param name="query">The query to execute</param>
        /// <param name="parameters">Array of SqlParameter for this query (optional)</param>
        /// <returns></returns>
        protected U ScalarQuery<U>(string query, SqlParameter[] parameters = null) {
            U value = default(U);

            try {
                using (var command = this.connection.CreateCommand()) {
                    command.CommandText = query;

                    if (parameters != null) {
                        command.Parameters.AddRange(parameters);
                    }

                    this.OpenConnection();
                    object result = command.ExecuteScalar();
                    if (typeof(U) == result.GetType()) {
                        value = (U) result;
                    } else {
                        value = (U) Convert.ChangeType(result, typeof(U));
                    }
                }
            } catch (Exception ex) {
                Debug.WriteLine(ex.Message, "ModelList.scalarQuery");
            } finally {
                this.CloseConnection();
            }

            return value;
        }
    }

    partial class ModelList<T> {
        /// <summary>
        /// Update many records from the database.
        /// </summary>
        /// <param name="set">Set clause to update all matching records</param>
        /// <param name="where">Where clause to filter which records will be updated</param>
        /// <returns>Number of affected rows</returns>
        public virtual int Update(SetClause set, WhereClause where) {
            if (set is null || !set.HasAny) {
                throw new ArgumentNullException("SetClause cannot be null or empty. Dangerous operation.");
            }

            if (where is null || !where.HasAny) {
                throw new ArgumentNullException("WhereClause cannot be null or empty. Dangerous operation.");
            }

            using (var command = this.connection.CreateCommand()) {
                int affectedRows = 0;

                if (set.HasAny) {
                    string setClause = set.ToString();
                    command.Parameters.AddRange(set.Parameters);

                    string whereClause = $" WHERE {where.ToString()}";
                    command.Parameters.AddRange(where.Parameters);

                    command.CommandText = $"UPDATE [{this.table}] {setClause}{whereClause};";

                    try {
                        this.OpenConnection();

                        affectedRows = command.ExecuteNonQuery();
                    } catch (Exception ex) {
                        Debug.WriteLine(ex.Message, "ModelList.UpdateMany");
                    } finally {
                        this.CloseConnection();
                    }
                }

                return affectedRows;
            }
        }

        /// <summary>
        /// Delete many records from the databases matching the provided where criteria.
        /// </summary>
        /// <param name="where">Where clause to filter which records will be updated</param>
        /// <returns>Number of affected rows</returns>
        public virtual int Delete(WhereClause where) {
            if (where is null || !where.HasAny) {
                throw new ArgumentNullException("WhereClause cannot be null or empty. Dangerous operation.");
            }

            using (var command = this.connection.CreateCommand()) {
                int affectedRows = 0;

                string whereClause = $" WHERE {where.ToString()}";
                command.Parameters.AddRange(where.Parameters);

                command.CommandText = $"DELETE FROM [{this.table}]{whereClause};";

                try {
                    this.OpenConnection();

                    affectedRows = command.ExecuteNonQuery();
                } catch (Exception ex) {
                    Debug.WriteLine(ex.Message, "ModelList.DeleteMany");
                } finally {
                    this.CloseConnection();
                }

                return affectedRows;
            }
        }

        public virtual int Delete(WhereClause where, string joinTable, string joinColumn) {
            if (where is null || !where.HasAny) {
                throw new ArgumentNullException("WhereClause cannot be null or empty. Dangerous operation.");
            }

            if (joinTable is null || joinColumn is null) {
                throw new ArgumentNullException("Join table and column cannot be null.");
            }

            using (var command = this.connection.CreateCommand()) {
                int affectedRows = 0;

                string whereClause = $" WHERE {where.ToString()}";
                command.Parameters.AddRange(where.Parameters);

                string[] commandsText = new[] {
                    // 1st query, delete the joined rows
                    $@"DELETE J
                        FROM [{this.table}] T
                        INNER JOIN [{joinTable}] J
	                        ON T.[{joinColumn}] = J.[{joinColumn}]
                        {whereClause};",
                    // 2nd query, delete the original row
                    $"DELETE FROM [{this.table}] {whereClause};"
                };

                try {
                    this.OpenConnection();
                    foreach (var commandText in commandsText) {
                        command.CommandText = commandText;

                        affectedRows += command.ExecuteNonQuery();
                    }
                } catch (Exception ex) {
                    Debug.WriteLine(ex.Message, "ModelList.DeleteMany");
                } finally {
                    this.CloseConnection();
                }

                return affectedRows;
            }
        }
    }
}

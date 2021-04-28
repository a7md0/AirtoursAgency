using System;
using System.Collections.Generic;

using System.Reflection;
using System.Diagnostics;

using System.Data;
using System.Data.SqlClient;

namespace AirtoursBusinessObjects {
    using Builder;
    using Schema;

    public abstract partial class DataList<T> where T : Item, new() {
        protected readonly string table;
        protected readonly string pkColumn;

        protected SqlConnection connection; // TODO: Move connection to Database class that implement singleton, and handle opening/closing the connection.

        protected List<T> list;
        protected DataTable dataTable;
        protected TableSchema schema;

        protected PropertyInfo[] itemProperties;
        protected Dictionary<string, int> columnsOrdinals;

        public DataList() {
            var tableAttribute = typeof(T).GetCustomAttribute<TableAttribute>();

            this.table = tableAttribute.Name;
            this.pkColumn = tableAttribute.PkColumn;

            this.connection = new SqlConnection(Properties.Settings.Default.AirtoursConnectionString);

            this.list = new List<T>();
            this.dataTable = new DataTable(table);

            this.itemProperties = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly);
            this.columnsOrdinals = new Dictionary<string, int>();

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
        /// 
        /// </summary>
        public DataTable DataTable => this.dataTable;

        /// <summary>
        /// Id column of this data list table.
        /// </summary>
        public string PkColumn => this.pkColumn;

        public T NewItem => new T();
    }

    partial class DataList<T> {
        protected virtual string whereItemClause(SqlCommand command, T item) {
            command.Parameters.AddWithValue(this.pkColumn, item.GetId());

            return $"WHERE [{this.pkColumn}] = @{this.pkColumn}";
        }

        public virtual void Fill(T item) {
            using (var command = this.connection.CreateCommand()) {
                var whereClause = this.whereItemClause(command, item);

                command.CommandText = $"SELECT * FROM [{this.table}] {whereClause};";
                this.connection.Open();

                using (var reader = command.ExecuteReader()) {
                    this.setColumnsOrdinals(reader);

                    if (reader.Read()) {
                        this.setValues(item, reader);
                    }
                }

                this.connection.Close();
            }
        }

        public virtual void Add(T item) {
            using (var command = this.connection.CreateCommand())
            using (var insert = new InsertClause(this.schema)) {
                insert.Add(item, itemProperties);

                if (insert.HasAny) {
                    string insertFields = insert.InsertFields;
                    string insertValues = insert.InsertValues;

                    command.Parameters.AddRange(insert.Parameters);
                    command.CommandText = $"INSERT INTO [{this.table}] ({insertFields}) OUTPUT INSERTED.{this.pkColumn} VALUES ({insertValues});";

                    this.connection.Open();

                    try {
                        object inserted_id = command.ExecuteScalar();

                        if (inserted_id is null == false && inserted_id is DBNull == false) {
                            item.SetId(inserted_id);
                        }

                        item.Inserted = true;

                        item.SetError(null);
                    } catch (SqlException ex) {
                        item.SetError(ex.Message);
                    }

                    this.connection.Close();
                }
            }
        }

        public virtual void Update(T item) {
            using (var command = this.connection.CreateCommand())
            using (var set = new SetClause(this.schema)) {
                set.Add(item, itemProperties, new[] { this.pkColumn });

                if (set.HasAny) {
                    this.Update(item, command, set);
                }
            }
        }

        protected void Update(T item, SqlCommand command, SetClause set) {
            string setClause = set.ToString();
            var whereClause = this.whereItemClause(command, item);

            command.Parameters.AddRange(set.Parameters);
            command.CommandText = $"UPDATE [{this.table}] {setClause} {whereClause};";

            this.connection.Open();

            try {
                command.ExecuteNonQuery();

                item.SetError(null);
            } catch (SqlException ex) {
                item.SetError(ex.Message);
            }

            this.connection.Close();
        }

        public virtual void Delete(T item) {
            using (var command = this.connection.CreateCommand()) {
                var whereClause = this.whereItemClause(command, item);

                command.CommandText = $"DELETE FROM [{this.table}] {whereClause};";

                this.connection.Open();

                try {
                    command.ExecuteNonQuery();

                    item.SetError(null);
                } catch (SqlException ex) {
                    item.SetError(ex.Message);
                }

                this.connection.Close();
            }
        }
    }

    partial class DataList<T> {
        /// <summary>
        /// Populate the list (SELECT *)
        /// </summary>
        public bool Populate() {
            return this.Populate(null);
        }

        public bool Populate(string field, dynamic value) {
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

                this.connection.Open();

                using (var reader = command.ExecuteReader()) {
                    hasRows = reader.HasRows;

                    this.setColumnsOrdinals(reader);
                    this.generateList(reader);
                }

                this.connection.Close();

                return hasRows;
            }
        }
    }

    partial class DataList<T> {
        /// <summary>
        /// Recreate the current list with the values from the reader. It does empty the list at start.
        /// </summary>
        protected virtual void generateList(SqlDataReader reader) {
            this.list.Clear();
            this.dataTable.Rows.Clear();

            while (reader.Read()) {
                T item = new T();

                this.setValues(item, reader);
                item.Inserted = true;

                this.list.Add(item);
                this.addDataTableRow(item);
            }
        }

        /// <summary>
        /// Set values of given item from the current reader.
        /// </summary>
        /// <param name="item">Item to set properties value from the current reader.</param>
        protected void setValues(T item, SqlDataReader reader) {
            foreach (var property in itemProperties) {
                try {
                    int ordinal = columnsOrdinals[property.Name]; // Find value by matching property name
                    object value = reader.GetValue(ordinal);

                    if (value is DBNull) {
                        value = null; // Set value to null if matched with db type NULL
                    }

                    property.SetValue(item, value);
                } catch (KeyNotFoundException ex) { // Dictionary throws if key not found
                    Debug.WriteLine(ex, "DataList.setValues");
                } catch (InvalidOperationException ex) {
                    Debug.WriteLine(ex, "DataList.setValues");
                } catch (ArgumentException ex) { // PropertyInfo.SetValue throws
                    Debug.WriteLine(ex, "DataList.setValues");
                } catch (TargetException ex) {
                    Debug.WriteLine(ex, "DataList.setValues");
                } catch (MethodAccessException ex) {
                    Debug.WriteLine(ex, "DataList.setValues");
                } catch (TargetInvocationException ex) {
                    Debug.WriteLine(ex, "DataList.setValues");
                }
            }
        }

        /// <summary>
        /// Set columns ordinals (integer order of each column by name). It is inefficient to call within loop, so it being called once after each query and cached for usage.
        /// </summary>
        /// <param name="reader">Data reader to read ordinal from</param>
        protected void setColumnsOrdinals(SqlDataReader reader) {
            this.columnsOrdinals.Clear();

            foreach (var property in this.itemProperties) {
                try {
                    string propertyName = property.Name;
                    int columnOrdinal = reader.GetOrdinal(propertyName); // throws IndexOutOfRangeException

                    this.columnsOrdinals.Add(propertyName, columnOrdinal);
                } catch (IndexOutOfRangeException ex) { // No column with the specified name was found.
                    Debug.WriteLine(ex, "DataList.setColumnsOrdinals");
                } catch (ArgumentNullException ex) {
                    Debug.WriteLine(ex, "DataList.setColumnsOrdinals");
                } catch (ArgumentException ex) {
                    Debug.WriteLine(ex, "DataList.setColumnsOrdinals");
                }
            }
        }

        protected void fetchTableSchema() {
            using (var command = this.connection.CreateCommand()) {
                command.CommandText = $"SELECT * FROM [{this.table}] WHERE 1 = 0;";
                this.connection.Open();

                using (var reader = command.ExecuteReader(CommandBehavior.SchemaOnly)) {
                    var schema = reader.GetSchemaTable();

                    this.schema = new TableSchema(schema);
                }

                this.connection.Close();
            }
        }

        protected void setDataTableColumns() {
            this.dataTable.Clear();
            this.dataTable.Rows.Clear();
            this.dataTable.Columns.Clear();

            DataColumn column;

            foreach (var property in this.itemProperties) {
                column = new DataColumn();

                column.DataType = Nullable.GetUnderlyingType(property.PropertyType) ?? property.PropertyType; // https://forums.asp.net/t/1796259.aspx?how+to+solve+this+DataSet+does+not+support+System+Nullable+
                column.ColumnName = property.Name;

                this.dataTable.Columns.Add(column);
            }
        }

        protected void addDataTableRow(T item) {
            DataRow row = this.dataTable.NewRow();

            foreach (var property in this.itemProperties) {
                row[property.Name] = property.GetValue(item) ?? DBNull.Value; // https://forums.asp.net/t/1796259.aspx?how+to+solve+this+DataSet+does+not+support+System+Nullable+
            }

            this.dataTable.Rows.Add(row);
        }
    }

    partial class DataList<T> {
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
            } catch (InvalidCastException) { }

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
                this.connection.Open();

                try {
                    using (var command = this.connection.CreateCommand()) {
                        command.CommandText = query;

                        if (parameters != null) {
                            command.Parameters.AddRange(parameters);
                        }

                        object result = command.ExecuteScalar();
                        if (typeof(U) == result.GetType()) {
                            value = (U) result;
                        } else {
                            value = (U) Convert.ChangeType(result, typeof(U));
                        }

                    }
                } catch (InvalidCastException ex) {
                    Debug.WriteLine(ex, "DataList.ScalarQuery");
                } catch (SqlException ex) {
                    Debug.WriteLine(ex, "DataList.ScalarQuery");
                } catch (InvalidOperationException ex) {
                    Debug.WriteLine(ex, "DataList.ScalarQuery");
                } catch (System.IO.IOException ex) {
                    Debug.WriteLine(ex, "DataList.ScalarQuery");
                } catch (FormatException ex) {
                    Debug.WriteLine(ex, "DataList.ScalarQuery");
                } catch (OverflowException ex) {
                    Debug.WriteLine(ex, "DataList.ScalarQuery");
                } catch (ArgumentNullException ex) {
                    Debug.WriteLine(ex, "DataList.ScalarQuery");
                } finally {
                    this.connection.Close();
                }
            } catch (InvalidOperationException ex) {
                Debug.WriteLine(ex, "DataList.ScalarQuery");
            } catch (SqlException ex) {
                Debug.WriteLine(ex, "DataList.ScalarQuery");
            }

            return value;
        }
    }
}

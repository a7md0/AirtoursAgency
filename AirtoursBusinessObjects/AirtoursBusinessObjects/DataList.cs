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
        protected readonly PropertyInfo pkColumnProperty;

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
            this.pkColumnProperty = typeof(T).GetProperty(this.pkColumn);

            this.connection = new SqlConnection(Properties.Settings.Default.AirtoursConnectionString);

            this.list = new List<T>();
            this.dataTable = new DataTable(table);

            this.itemProperties = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly);
            this.columnsOrdinals = new Dictionary<string, int>();

            this.setDataTableColumns();
            this.setSchema();
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

        protected virtual string whereItemClause(SqlCommand command, T item) {
            command.Parameters.AddWithValue(this.pkColumn, this.pkColumnProperty.GetValue(item));

            return $"WHERE [{this.pkColumn}] = @{this.pkColumn}";
        }
    }

    partial class DataList<T> {
        /// <summary>
        /// Populate the list (SELECT *)
        /// </summary>
        public void Populate() {
            this.connection.Open();

            using (var command = this.connection.CreateCommand()) {
                command.CommandText = $"SELECT * FROM [{this.table}];";

                using (var reader = command.ExecuteReader()) {
                    this.setColumnsOrdinals(reader);

                    this.GenerateList(reader);
                }
            }

            this.connection.Close();
        }

        public void Populate(T item) {
            this.connection.Open();

            using (var command = this.connection.CreateCommand()) {
                var whereClause = this.whereItemClause(command, item);

                command.CommandText = $"SELECT * FROM [{this.table}] {whereClause};";

                using (var reader = command.ExecuteReader()) {
                    this.setColumnsOrdinals(reader);

                    if (reader.Read()) {
                        this.SetValues(item, reader);
                    }
                }
            }

            this.connection.Close();
        }

        public void PopulateWithFilter(string field, string value) {
            this.connection.Open();

            using (var command = this.connection.CreateCommand()) {
                command.CommandText = $"SELECT * FROM [{this.table}] WHERE [{@field}] = @value;";
                command.Parameters.AddWithValue("field", field);
                command.Parameters.AddWithValue("value", value);

                using (var reader = command.ExecuteReader()) {
                    this.setColumnsOrdinals(reader);

                    this.GenerateList(reader);
                }
            }

            this.connection.Close();
        }

        public void Update(T item) {
            this.connection.Open();

            using (var command = this.connection.CreateCommand())
            using (var set = new SetClause(this.schema)) {
                set.Add(item, itemProperties, new[] { this.pkColumn });

                if (set.HasAny) {
                    string setClause = set.ToString();
                    var whereClause = this.whereItemClause(command, item);

                    command.Parameters.AddRange(set.Parameters);
                    command.CommandText = $"UPDATE [{this.table}] {setClause} {whereClause};";

                    try {
                        command.ExecuteNonQuery();

                        item.Valid = true;
                        item.ErrorMessage = null;
                    } catch (SqlException ex) {
                        item.Valid = false;
                        item.ErrorMessage = ex.Message;
                    }
                }
            }

            this.connection.Close();
        }

        public void Add(T item) {
            using (var command = this.connection.CreateCommand())
            using (var insert = new InsertClause(this.schema, this.pkColumn)) {
                insert.Add(item, itemProperties);

                if (insert.HasAny) {
                    string insertClause = insert.ToString();

                    command.Parameters.AddRange(insert.Parameters);
                    command.CommandText = $"INSERT INTO [{this.table}] {insertClause};";

                    try {
                        this.connection.Open();
                        object inserted_id = command.ExecuteScalar();
                        this.connection.Close();

                        var prop = item.GetType().GetProperty(this.pkColumn);
                        prop.SetValue(item, inserted_id);

                        item.Valid = true;
                        item.ErrorMessage = null;
                    } catch (SqlException ex) {
                        item.Valid = false;
                        item.ErrorMessage = ex.Message;
                    }
                }
            }
        }

        public void Delete(T item) {
            this.connection.Open();

            using (var command = this.connection.CreateCommand()) {
                var whereClause = this.whereItemClause(command, item);

                command.CommandText = $"DELETE FROM [{this.table}] {whereClause};";

                try {
                    command.ExecuteNonQuery();

                    item.Valid = true;
                    item.ErrorMessage = null;
                } catch (SqlException ex) {
                    item.Valid = false;
                    item.ErrorMessage = ex.Message;
                }

            }

            this.connection.Close();
        }

        /// <summary>
        /// Recreate the current list with the values from the reader. It does empty the list at start.
        /// </summary>
        protected virtual void GenerateList(SqlDataReader reader) {
            this.list.Clear();
            this.dataTable.Rows.Clear();

            while (reader.Read()) {
                T item = new T();

                this.SetValues(item, reader);

                this.list.Add(item);
                this.addDataTableRow(item);
            }
        }
    }

    partial class DataList<T> {
        /// <summary>
        /// Set values of given item from the current reader.
        /// </summary>
        /// <param name="item">Item to set properties value from the current reader.</param>
        protected void SetValues(T item, SqlDataReader reader) {
            foreach (var property in itemProperties) {
                try {
                    int ordinal = columnsOrdinals[property.Name]; // Find value by matching property name
                    object value = reader.GetValue(ordinal);

                    if (value is DBNull) {
                        value = null; // Set value to null if matched with db type NULL
                    }

                    property.SetValue(item, value);
                } catch (KeyNotFoundException) { // Dictionary throws if key not found

                } catch (InvalidOperationException) {

                } catch (ArgumentException) { // PropertyInfo.SetValue throws

                } catch (TargetException) {

                } catch (MethodAccessException) {

                } catch (TargetInvocationException) {

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
                } catch (IndexOutOfRangeException) { // No column with the specified name was found.
                } catch (ArgumentNullException) {
                } catch (ArgumentException) {
                }
            }
        }

        protected void setSchema() {
            this.connection.Open();

            using (var command = this.connection.CreateCommand()) {
                command.CommandText = $"SELECT * FROM {this.table} WHERE 1 = 0;";

                using (var reader = command.ExecuteReader(CommandBehavior.SchemaOnly)) {
                    var schema = reader.GetSchemaTable();

                    this.schema = new TableSchema(schema);
                }
            }

            this.connection.Close();
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
        public double TotalValue(string column) => this.AggregateValue<double>(AggregateFunctions.SUM, column, null);
        public U TotalValue<U>(string column) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.AggregateValue<U>(AggregateFunctions.SUM, column, null);
        }

        public double TotalValue(string column, WhereClause whereClause) =>  this.AggregateValue<double>(AggregateFunctions.SUM, column, whereClause);
        public U TotalValue<U>(string column, WhereClause whereClause) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.AggregateValue<U>(AggregateFunctions.SUM, column, whereClause);
        }

        public int TotalCount() => this.AggregateValue<int>(AggregateFunctions.COUNT, this.pkColumn);
        public int TotalCount(WhereClause whereClause) {
            return this.AggregateValue<int>(AggregateFunctions.COUNT, this.pkColumn, whereClause);
        }

        public int AggregateValue(AggregateFunctions aggregateFunction, string column) => this.AggregateValue<int>(aggregateFunction, column, null);
        public U AggregateValue<U>(AggregateFunctions aggregateFunction, string column) => this.AggregateValue<U>(aggregateFunction, column, null);

        public int AggregateValue(AggregateFunctions aggregateFunction, string column, WhereClause whereClause) => this.AggregateValue<int>(aggregateFunction, column, whereClause);
        public U AggregateValue<U>(AggregateFunctions aggregateFunction, string column, WhereClause whereClause) {
            U value = default(U);

            string aggregate = aggregateFunction.ToString();

            SqlParameter[] sqlParameters = whereClause?.Parameters;
            string suffix = whereClause?.ToString() ?? "";

            if (!this.schema.HasColumn(column)) {
                throw new ArgumentException($"{column} does not exists in this table schema.");
            }

            try {
                value = this.ScalarQuery<U>($"SELECT {aggregate}([{column}]) FROM [{this.table}]{suffix};", sqlParameters);
            } catch (InvalidCastException) { }

            return value;
        }

        /// <summary>
        /// Query the maximum primary key value.
        /// </summary>
        /// <returns>Maximum id value</returns>
        public virtual int GetMaxID() => this.AggregateValue<int>(AggregateFunctions.MAX, this.pkColumn);

        protected object ScalarQuery(string query, SqlParameter[] parameters = null) => this.ScalarQuery<object>(query, parameters);

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="U"></typeparam>
        /// <param name="query"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        protected U ScalarQuery<U>(string query, SqlParameter[] parameters = null) {
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

    public enum AggregateFunctions {
        AVG, COUNT, MAX, MIN, SUM
    }
}

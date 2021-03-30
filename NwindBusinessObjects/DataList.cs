using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;

using System.Data.SqlClient;

using NwindBusinessObjects.Builder;

namespace NwindBusinessObjects {
    public abstract partial class DataList<T> where T : Item, new() {
        protected readonly string table;
        protected readonly string pkColumn;

        protected SqlConnection connection; // TODO: Move connection to Database class that implement singleton, and handle opening/closing the connection.

        protected List<T> list;

        protected PropertyInfo[] itemProperties;
        protected Dictionary<string, int> columnsOrdinals;

        public DataList(string table, string pkColumn) {
            this.table = table;
            this.pkColumn = pkColumn;

            this.connection = new SqlConnection(Properties.Settings.Default.NorthwindConnectionString);

            this.list = new List<T>();

            this.itemProperties = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly);
            this.columnsOrdinals = new Dictionary<string, int>();
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
        /// Id column of this data list table.
        /// </summary>
        public string PkColumn => this.pkColumn;
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
                command.CommandText = $"SELECT * FROM [{this.table}] WHERE [{pkColumn}] = @id;";
                command.Parameters.AddWithValue("id", item.Id);

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
            using (var set = new SetClause(new[] { this.pkColumn }, true)) {
                set.Add(item, itemProperties);

                if (set.HasAny) {
                    string setClause = set.ToString();

                    command.Parameters.AddRange(set.Parameters);
                    command.CommandText = $"UPDATE [{this.table}] {setClause} WHERE [{pkColumn}] = @{pkColumn};";
                    command.ExecuteNonQuery();
                }
            }

            this.connection.Close();
        }

        /// <summary>
        /// Recreate the current list with the values from the reader. It does empty the list at start.
        /// </summary>
        protected virtual void GenerateList(SqlDataReader reader) {
            this.list.Clear();

            while (reader.Read()) {
                T item = new T();

                this.SetValues(item, reader);

                this.list.Add(item);
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
        /// Set columns ordinals (integer order of each column by name). It is inefficient to call within loop, so it being called once after each query.
        /// </summary>
        protected void setColumnsOrdinals(SqlDataReader reader) {
            columnsOrdinals.Clear();

            foreach (var property in itemProperties) {
                try {
                    string propertyName = property.Name;
                    int columnOrdinal = reader.GetOrdinal(propertyName); // throws IndexOutOfRangeException

                    columnsOrdinals.Add(propertyName, columnOrdinal);
                } catch (IndexOutOfRangeException) { // No column with the specified name was found.

                }
            }
        }
    }

    partial class DataList<T> {
        protected object ScalarQuery(string query, SqlParameter[] parameters = null) {
            return this.ScalarQuery<object>(query, parameters);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="U"></typeparam>
        /// <param name="query"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        protected U ScalarQuery<U>(string query, SqlParameter[] parameters = null) {
            U value = default(U);

            this.connection.Open();

            using (var command = this.connection.CreateCommand()) {
                command.CommandText = query;

                if (parameters != null) {
                    command.Parameters.AddRange(parameters);
                }

                object result = (U)command.ExecuteScalar();
                value = (U)Convert.ChangeType(result, typeof(U));
            }

            this.connection.Close();

            return value;
        }

        public double TotalValue(string column) {
            return this.AggregateValue<double>(AggregateFunctions.SUM, column, null, null, null);
        }

        public U TotalValue<U>(string column) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.AggregateValue<U>(AggregateFunctions.SUM, column, null, null, null);
        }

        public double TotalValue(
            string column,
            string whereColumn,
            string whereOperator,
            dynamic whereValue
        ) {
            return this.AggregateValue<double>(AggregateFunctions.SUM, column, whereColumn, whereOperator, whereValue);
        }

        public U TotalValue<U>(
            string column,
            string whereColumn,
            string whereOperator,
            dynamic whereValue
        ) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.AggregateValue<U>(AggregateFunctions.SUM, column, whereColumn, whereOperator, whereValue);
        }

        public int TotalCount() => this.AggregateValue<int>(AggregateFunctions.COUNT, this.pkColumn);

        public int TotalCount(
            string whereColumn,
            string whereOperator,
            dynamic whereValue
        ) {
            return this.AggregateValue<int>(AggregateFunctions.COUNT, this.pkColumn, whereColumn, whereOperator, whereValue);
        }

        public int AggregateValue(
            AggregateFunctions aggregateFunction,
            string column
        ) => this.AggregateValue<int>(aggregateFunction, column, null, null, null);

        public U AggregateValue<U>(
            AggregateFunctions aggregateFunction,
            string column
        ) => this.AggregateValue<U>(aggregateFunction, column, null, null, null);

        public int AggregateValue(
            AggregateFunctions aggregateFunction,
            string column,
            string whereColumn,
            string whereOperator,
            dynamic whereValue
        ) => this.AggregateValue<int>(aggregateFunction, column, whereColumn, whereOperator, whereValue);

        public U AggregateValue<U>(AggregateFunctions aggregateFunction, string column, string whereColumn, string whereOperator, dynamic whereValue) {
            U value = default(U);
            SqlParameter[] sqlParameters = null;
            string suffix = "";
            string aggregate = aggregateFunction.ToString();

            if (whereColumn != null && whereOperator != null && whereValue != null) {
                sqlParameters = new SqlParameter[1];
                sqlParameters[0] = new SqlParameter(whereColumn, whereValue);

                suffix = $" WHERE {whereColumn} {whereOperator} @{whereColumn}";
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
        public virtual int GetMaxID() {
            return this.AggregateValue<int>(AggregateFunctions.MAX, this.pkColumn);
        }
    }

    public enum AggregateFunctions {
        AVG, COUNT, MAX, MIN, SUM
    }
}

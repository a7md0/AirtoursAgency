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
        protected SqlCommand command;
        protected SqlDataReader reader;

        protected List<T> list;

        protected PropertyInfo[] itemProperties;
        protected Dictionary<string, int> columnsOrdinals;

        public DataList(string table, string pkColumn) {
            this.table = table;
            this.pkColumn = pkColumn;

            this.connection = new SqlConnection(Properties.Settings.Default.NorthwindConnectionString);
            this.command = null;
            this.reader = null;

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

            using (this.command = this.connection.CreateCommand()) {
                this.command.CommandText = $"SELECT * FROM [{this.table}];";

                using (this.reader = command.ExecuteReader()) {
                    this.setColumnsOrdinals();

                    this.GenerateList();
                }
            }

            this.connection.Close();
        }

        public void Populate(T item) {
            this.connection.Open();

            using (this.command = this.connection.CreateCommand()) {
                this.command.CommandText = $"SELECT * FROM [{this.table}] WHERE [{pkColumn}] = @id;";
                this.command.Parameters.AddWithValue("id", item.Id);

                using (this.reader = command.ExecuteReader()) {
                    this.setColumnsOrdinals();

                    if (this.reader.Read()) {
                        this.SetValues(item);
                    }
                }
            }

            this.connection.Close();
        }

        public void PopulateWithFilter(string field, string value) {
            this.connection.Open();

            using (this.command = this.connection.CreateCommand()) {
                this.command.CommandText = $"SELECT * FROM [{this.table}] WHERE [{@field}] = @value;";
                this.command.Parameters.AddWithValue("field", field);
                this.command.Parameters.AddWithValue("value", value);

                using (this.reader = command.ExecuteReader()) {
                    this.setColumnsOrdinals();

                    this.GenerateList();
                }
            }

            this.connection.Close();
        }

        public void Update(T item) {
            this.connection.Open();

            using (this.command = this.connection.CreateCommand())
            using (var set = new SetClause(new[] { this.pkColumn }, true)) {
                set.Add(item, itemProperties);

                if (set.HasAny) {
                    string setClause = set.ToString();

                    this.command.Parameters.AddRange(set.Parameters);
                    this.command.CommandText = $"UPDATE [{this.table}] {setClause} WHERE [{pkColumn}] = @{pkColumn};";
                    this.command.ExecuteNonQuery();
                }
            }

            this.connection.Close();
        }

        /// <summary>
        /// Recreate the current list with the values from the reader. It does empty the list at start.
        /// </summary>
        protected virtual void GenerateList() {
            this.list.Clear();

            while (reader.Read()) {
                T item = new T();

                this.SetValues(item);

                this.list.Add(item);
            }
        }
    }

    partial class DataList<T> {
        /// <summary>
        /// Set values of given item from the current reader.
        /// </summary>
        /// <param name="item">Item to set properties value from the current reader.</param>
        protected void SetValues(T item) {
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
        protected void setColumnsOrdinals() {
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
            object result = null;

            this.connection.Open();

            using (this.command = this.connection.CreateCommand()) {
                this.command.CommandText = query;

                if (parameters != null) {
                    this.command.Parameters.AddRange(parameters);
                }

                result = command.ExecuteScalar();
            }

            this.connection.Close();

            return result;
        }

        public double TotalValue(string column) {
            return this.TotalValue<double>(column, null, null, null);
        }

        public U TotalValue<U>(string column) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            return this.TotalValue<U>(column, null, null, null);
        }

        public double TotalValue(
            string column,
            string whereColumn,
            string whereOperator,
            dynamic whereValue
        ) {
            return this.TotalValue<double>(column, whereColumn, whereOperator, whereValue);
        }

        public U TotalValue<U>(
            string column,
            string whereColumn,
            string whereOperator,
            dynamic whereValue
        ) where U : struct, IComparable, IFormattable, IConvertible, IComparable<U>, IEquatable<U> {
            U value = default(U);
            SqlParameter[] sqlParameters = null;
            string suffix = "";

            if (whereColumn != null && whereOperator != null && whereValue != null) {
                sqlParameters = new SqlParameter[1];
                sqlParameters[0] = new SqlParameter(whereColumn, whereValue);

                suffix = $" WHERE {whereColumn} {whereOperator} @{whereColumn}";
            }

            try {
                object result = this.ScalarQuery($"SELECT SUM([{column}]) FROM [{this.table}]{suffix};", sqlParameters);
                value = (U)Convert.ChangeType(result, typeof(U));
            } catch (System.InvalidCastException) { }

            return value;
        }

        public int GetMaxID() {
            int value = 0;

            try {
                object result = this.ScalarQuery($"SELECT MAX([{this.pkColumn}]) FROM [{this.table}];");
                value = (int)result;
            } catch (NullReferenceException) { }

            return value;
        }
    }
}

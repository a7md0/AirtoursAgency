using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;

using System.Data.SqlClient;

namespace NwindBusinessObjects {
    public abstract class DataList<T> where T : Item {
        protected readonly string table;
        protected readonly string pkColumn;

        protected SqlConnection connection; // TODO: Move connection to Database class that implement singleton, and handle opening/closing the connection.
        protected SqlCommand command;
        protected SqlDataReader reader;

        protected List<T> list;

        private PropertyInfo[] itemProperties;
        private Dictionary<string, int> columnsOrdinals;

        public DataList(string table, string pkColumn) {
            this.table = table;
            this.pkColumn = pkColumn;

            this.connection = new SqlConnection(Properties.Settings.Default.NorthwindConnectionString);
            this.command = null;
            this.reader = null;

            this.list = new List<T>();

            this.setItemProperties();
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

        public bool Update(T item) {
            this.connection.Open();

            using (this.command = this.connection.CreateCommand()) {
                List<string> fields = new List<string>(); // List of set instructions (e.g. xyz = 1)
                string setFields;

                foreach (var property in itemProperties) {
                    var name = property.Name; // Get field name
                    var value = property.GetValue(item); // Get value

                    if (value == null) { // if value is null we skip
                        continue;
                    }

                    this.command.Parameters.AddWithValue(name, value); // Add to the parameters

                    if (name == pkColumn) {
                        continue;
                    }

                    fields.Add($"[{name}] = @{name}");
                }

                setFields = string.Join(", ", fields); // Join list of instructions by comma (e.g. xyz = @xyz, a = @a)

                this.command.CommandText = $"UPDATE [{this.table}] SET {setFields} WHERE [{pkColumn}] = @{pkColumn};";

                command.ExecuteNonQuery();
            }

            this.connection.Close();
        }

        /// <summary>
        /// Recreate the current list with the values from the reader. It does empty the list at start.
        /// </summary>
        protected virtual void GenerateList() {
            this.list.Clear();

            while (reader.Read()) {
                T item = Activator.CreateInstance<T>(); // https://stackoverflow.com/a/40987945/1738413

                this.SetValues(item);

                this.list.Add(item);
            }
        }

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
        /// Find and set the current item proprieties.
        /// </summary>
        /// <param name="bindingAttr">A bitmask comprised of one or more System.Reflection.BindingFlags that specify how the search is conducted.-or- Zero, to return null.</param>
        private void setItemProperties(BindingFlags bindingAttr = BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly) {
            itemProperties = typeof(T).GetProperties(bindingAttr);
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
}

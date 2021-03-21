using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;

using System.Data.SqlClient;

namespace NwindBusinessObjects {
    public abstract class DataList<T> {
        private readonly string table;

        protected SqlConnection connection;
        protected SqlCommand command;
        protected SqlDataReader reader;

        protected List<T> list;

        private PropertyInfo[] itemProperties;
        private Dictionary<string, int> columnsOrdinals;

        public DataList(string table) {
            this.table = table;

            this.connection = new SqlConnection(Properties.Settings.Default.NorthwindConnectionString);
            this.command = this.connection.CreateCommand();
            this.reader = null;

            this.list = new List<T>();

            this.setItemProperties();
            this.columnsOrdinals = new Dictionary<string, int>();
        }

        public string Table {
            get { return table; }
        }

        public List<T> List {
            get { return list; }
        }

        public void Populate() {
            this.connection.Open();

            this.command.CommandText = $"SELECT * FROM {this.table};";
            this.reader = command.ExecuteReader();
            this.setColumnsOrdinals();

            this.GenerateList();

            this.reader.Close();
            this.command.Dispose();
            this.connection.Close();
        }

        //needed so that it can be overridden in subclasses
        protected virtual void GenerateList() {
            this.list.Clear();

            while (reader.Read()) {
                T item = Activator.CreateInstance<T>(); // https://stackoverflow.com/a/40987945/1738413

                this.SetValues(item);

                this.list.Add(item);
            }
        }

        protected void SetValues(T item) {
            foreach (var property in itemProperties) {
                try {
                    object value = reader.GetValue(columnsOrdinals[property.Name]); // Find value by matching property name against the column name.

                    if (value == null) {
                        continue; // Skip if no matching column for this property
                    }

                    if (value is DBNull) {
                        value = null; // Set value to null if matched with db type NULL
                    }

                    property.SetValue(item, value);
                } catch (KeyNotFoundException) { // Dictionary throws if key not found

                } catch (ArgumentException) { // PropertyInfo.SetValue throws

                } catch (TargetException) {

                } catch (MethodAccessException) {

                } catch (TargetInvocationException) {

                }
            }
        }

        private void setItemProperties(BindingFlags bindingAttr = BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly) {
            itemProperties = typeof(T).GetProperties(bindingAttr);
        }

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

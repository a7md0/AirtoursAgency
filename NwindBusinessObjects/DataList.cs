using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;

using System.Data.SqlClient;

namespace NwindBusinessObjects {
    public abstract class DataList<T> {
        protected string table;
        protected SqlConnection connection;
        protected SqlCommand command;
        protected SqlDataReader reader;
        protected List<T> list;

        public DataList(string table) {
            this.table = table;
            this.connection = new SqlConnection(Properties.Settings.Default.NorthwindConnectionString);
            this.command = connection.CreateCommand();
            this.list = new List<T>();
        }

        public string Table {
            get { return table; }
            set { table = value; }
        }

        public List<T> List {
            get { return list; }
            set { list = value; }
        }

        public void Populate() {
            this.connection.Open();

            command.CommandText = $"SELECT * FROM {table};";
            reader = command.ExecuteReader();

            GenerateList();

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
            Type type = item.GetType();
            PropertyInfo[] properties = type.GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly);

            foreach (var property in properties) {
                object value = reader[property.Name]; // Find value by matching property name against the coulmn name

                if (value == null) {
                    continue; // Skip if no matching column for this property
                }

                if (value is DBNull) {
                    value = null; // Set valute to null if matached with db type NULL
                }

                property.SetValue(item, value);
            }
        }
    }
}

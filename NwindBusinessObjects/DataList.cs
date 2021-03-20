using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;

using System.Data.SqlClient;

namespace NwindBusinessObjects {
    public class DataList<T> {
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
            connection.Open();

            command.CommandText = "SELECT * FROM " + table;
            reader = command.ExecuteReader();

            GenerateList();
        }

        //needed so that it can be overridden in subclasses
        protected virtual void GenerateList() { }

        protected void SetValues(T item) {
            Type type = item.GetType();
            PropertyInfo[] properties = type.GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly);
            
            int fieldCount = 0;
            foreach (var property in properties) {
                property.SetValue(item, reader[property.Name]?.ToString());
                fieldCount++;
            }
        }
    }
}

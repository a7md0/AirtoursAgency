using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data.SqlClient;
using System.Reflection;

namespace NwindBusinessObjects.Builder {
    public class SetClause {
        private List<string> predicates;
        private List<SqlParameter> parameters;

        private string[] skipColumns;
        private bool skipNullValues;

        public SetClause(string[] skipColumns, bool skipNullValues = true) {
            this.predicates = new List<string>();
            this.parameters = new List<SqlParameter>();

            this.skipColumns = skipColumns;
            this.SkipNullValues = skipNullValues;
        }

        public bool SkipNullValues {
            get => this.skipNullValues;
            set => this.skipNullValues = value;
        }

        public bool HasAny => this.predicates.Count > 0;

        public List<SqlParameter> Parameters => this.parameters;

        public void Add(Item item, PropertyInfo[] itemProperties) {
            foreach (var property in itemProperties) {
                var name = property.Name; // Get field name
                var value = property.GetValue(item); // Get value

                this.Add(name, value);
            }
        }

        public void Add(string column, object value) {
            if (value == null && skipNullValues) { // if value is null we skip
                return;
            }

            this.parameters.Add(new SqlParameter(column, value)); // Add to the parameters

            
            if (skipColumns.Any(column.Contains)) {
                return;
            }

            this.predicates.Add($"[{column}] = @{column}");
        }

        public override string ToString() {
            string clause = "";

            if (predicates.Count == 0) {
                return clause;
            }

            clause += "SET ";
            clause += string.Join(", ", predicates);

            return clause;
        }
    }
}

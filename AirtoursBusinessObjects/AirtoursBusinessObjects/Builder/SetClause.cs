using System;
using System.Collections.Generic;
using System.Linq;

using System.Data.SqlClient;
using System.Reflection;

namespace AirtoursBusinessObjects.Builder {
    using Schema;

    public class SetClause : IDisposable {
        private List<string> predicates;
        private List<SqlParameter> parameters;

        private TableSchema schema;

        public SetClause(TableSchema schema) {
            this.predicates = new List<string>();
            this.parameters = new List<SqlParameter>();

            this.schema = schema;
        }

        public bool HasAny => this.predicates.Count > 0;

        public SqlParameter[] Parameters => this.parameters.ToArray();

        public void Add(Model item, PropertyInfo[] itemProperties, string[] skipColumns = null) {
            foreach (var property in itemProperties) {
                var name = property.Name; // Get field name
                var value = property.GetValue(item); // Get value

                if (skipColumns != null && skipColumns.Any(name.Contains)) {
                    continue;
                }

                this.Add(name, value);
            }
        }

        public void Add(string column, object value) {
            object val = value;

            if (!this.schema.HasColumn(column)) {
                throw new ArgumentException($"{column} does not exists in this table schema.");
            }

            var schemaColumn = this.schema[column];

            if (schemaColumn.IsAutoIncrement) {
                return;
            }

            if (val is null) {
                if (!schemaColumn.AllowDBNull) {
                    return;
                }

                val = DBNull.Value;
            }

            SqlParameter sqlParameter;

            if (schemaColumn.DataTypeName == "image") {
                sqlParameter = new SqlParameter(column, System.Data.SqlDbType.Image);
                sqlParameter.Value = val;
            } else {
                sqlParameter = new SqlParameter(column, val);
            }

            this.parameters.Add(sqlParameter); // Add to the parameters

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

        #region IDisposable Support
        private bool disposedValue = false; // To detect redundant calls

        protected virtual void Dispose(bool disposing) {
            if (!disposedValue) {
                if (disposing) {
                    // TODO: dispose managed state (managed objects).
                    this.predicates.Clear();
                    this.parameters.Clear();
                }

                // TODO: free unmanaged resources (unmanaged objects) and override a finalizer below.
                // TODO: set large fields to null.
                this.predicates = null;
                this.parameters = null;

                disposedValue = true;
            }
        }

        // TODO: override a finalizer only if Dispose(bool disposing) above has code to free unmanaged resources.
        // ~SetClause() {
        //   // Do not change this code. Put cleanup code in Dispose(bool disposing) above.
        //   Dispose(false);
        // }

        // This code added to correctly implement the disposable pattern.
        public void Dispose() {
            // Do not change this code. Put cleanup code in Dispose(bool disposing) above.
            Dispose(true);
            // TODO: uncomment the following line if the finalizer is overridden above.
            // GC.SuppressFinalize(this);
        }
        #endregion
    }
}

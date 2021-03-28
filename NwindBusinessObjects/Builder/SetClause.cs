using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data.SqlClient;
using System.Reflection;

namespace NwindBusinessObjects.Builder {
    public class SetClause : IDisposable {
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

        public SqlParameter[] Parameters => this.parameters.ToArray();

        public void Add(Item item, PropertyInfo[] itemProperties) {
            foreach (var property in itemProperties) {
                var name = property.Name; // Get field name
                var value = property.GetValue(item); // Get value

                this.Add(name, value);
            }
        }

        public void Add(string column, object value) {
            object val = value;

            if (val == null && skipNullValues) { // if value is null we skip
                return;
            } else if (val == null && !skipNullValues) {
                val = DBNull.Value;
            }

            this.parameters.Add(new SqlParameter(column, val)); // Add to the parameters

            
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
                this.skipColumns = null;

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

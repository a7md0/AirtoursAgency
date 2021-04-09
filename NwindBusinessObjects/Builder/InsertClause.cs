using System;
using System.Collections.Generic;
using System.Linq;

using System.Data;
using System.Data.SqlClient;

using System.Reflection;

namespace NwindBusinessObjects.Builder {
    using Schema;

    public class InsertClause : IDisposable {
        private List<string> columns;
        private List<string> values;
        private List<SqlParameter> parameters;

        private TableSchema schema;
        private string pkColumn;

        public InsertClause(TableSchema schema, string pkColumn) {
            this.columns = new List<string>();
            this.values = new List<string>();
            this.parameters = new List<SqlParameter>();

            this.schema = schema;
            this.pkColumn = pkColumn;
        }

        public bool HasAny => this.columns.Count > 0;

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

            if (this.schema[column].IsAutoIncrement) {
                return;
            }

            if (val == null) {
                val = DBNull.Value;
            }

            this.parameters.Add(new SqlParameter(column, val)); // Add to the parameters

            this.columns.Add($"[{column}]");
            this.values.Add($"@{column}");
        }

        public override string ToString() {
            string clause = "";

            if (this.columns.Count == 0) {
                return clause;
            }

            clause += "(";
            clause += string.Join(", ", this.columns);
            clause += $") OUTPUT INSERTED.{this.pkColumn} VALUES (";
            clause += string.Join(", ", this.values);
            clause += ")";

            return clause;
        }

        #region IDisposable Support
        private bool disposedValue = false; // To detect redundant calls

        protected virtual void Dispose(bool disposing) {
            if (!this.disposedValue) {
                if (disposing) {
                    // TODO: dispose managed state (managed objects).
                    this.columns.Clear();
                    this.values.Clear();
                    this.parameters.Clear();
                }

                // TODO: free unmanaged resources (unmanaged objects) and override a finalizer below.
                // TODO: set large fields to null.
                this.columns = null;
                this.values = null;
                this.parameters = null;

                this.disposedValue = true;
            }
        }

        // TODO: override a finalizer only if Dispose(bool disposing) above has code to free unmanaged resources.
        // ~InsertClause() {
        //   // Do not change this code. Put cleanup code in Dispose(bool disposing) above.
        //   Dispose(false);
        // }

        // This code added to correctly implement the disposable pattern.
        public void Dispose() {
            // Do not change this code. Put cleanup code in Dispose(bool disposing) above.
            this.Dispose(true);
            // TODO: uncomment the following line if the finalizer is overridden above.
            // GC.SuppressFinalize(this);
        }
        #endregion
    }
}

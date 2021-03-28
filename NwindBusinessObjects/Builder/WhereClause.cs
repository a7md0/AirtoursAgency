using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data.SqlClient;

namespace NwindBusinessObjects.Builder {
    public class WhereClause : IDisposable {
        private List<Predicate> predicates;
        private List<SqlParameter> parameters;

        public WhereClause() {
            this.predicates = new List<Predicate>();
            this.parameters = new List<SqlParameter>();

            this.predicates.Add(new AndPredicate());
        }

        public SqlParameter[] Parameters => this.parameters.ToArray();

        public WhereClause And() {
            //values.Add(key, value);
            predicates.Add(new AndPredicate());

            return this;
        }

        public WhereClause Or() {
            //values.Add(key, value);
            predicates.Add(new OrPredicate());

            return this;
        }

        #region operators
        // see https://en.wikipedia.org/wiki/SQL_syntax#Operators

        public WhereClause EqualTo(string columnName, object value) {
            var last = predicates.Last();

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} = @{columnName}");

            return this;
        }

        public WhereClause NotEqualTo(string columnName, object value) {
            var last = predicates.Last();

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} != @{columnName}");

            return this;
        }

        public WhereClause GreaterThan(string columnName, IComparable value) {
            var last = predicates.Last();

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} > @{columnName}");

            return this;
        }

        public WhereClause LessThan(string columnName, IComparable value) {
            var last = predicates.Last();

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} < @{columnName}");

            return this;
        }

        public WhereClause GreaterThanOrEqual(string columnName, IComparable value) {
            var last = predicates.Last();

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} >= @{columnName}");

            return this;
        }

        public WhereClause LessThanOrEqual(string columnName, IComparable value) {
            var last = predicates.Last();

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} <= @{columnName}");

            return this;
        }

        public WhereClause Between(string columnName, IComparable minValue, IComparable maxValue, bool not = false) {
            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";
            string minPlaceholder = $"min{columnName}";
            string maxPlaceholder = $"max{columnName}";

            parameters.Add(new SqlParameter(minPlaceholder, minValue));
            parameters.Add(new SqlParameter(maxPlaceholder, maxValue));
            last.Predicates.Add($"{prefix}{columnName} BETWEEN @{minPlaceholder} AND @{maxPlaceholder}");

            return this;
        }

        public WhereClause Like(string columnName, dynamic value, bool not = false) {
            throw new NotImplementedException();

#pragma warning disable CS0162 // Unreachable code detected
            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{prefix}{columnName} LIKE @{columnName}");

            return this;
#pragma warning restore CS0162 // Unreachable code detected
        }

        public WhereClause In(string columnName, dynamic value, bool not = false) {
            throw new NotImplementedException();
#pragma warning disable CS0162 // Unreachable code detected
            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";
            //string fValues = "";

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{prefix}{columnName} LIKE @{columnName}");

            return this;
#pragma warning restore CS0162 // Unreachable code detected
        }

        public WhereClause Is(string columnName, bool value, bool not = false) {
            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";
            string strValue = value == true ? "TRUE" : "FALSE";

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} IS {prefix}{strValue}");

            return this;
        }
        #endregion Operators

        public override string ToString() {
            string clause = "";
            bool isFirst = true;

            foreach (var predicate in this.predicates) {
                string op = predicate is AndPredicate ? " AND " : " OR ";
                if (isFirst) {
                    op = "WHERE ";
                    isFirst = false;
                }

                clause += op + string.Join(" AND ", predicate.Predicates);
            }

            return clause;
        }

        #region IDisposable Support
        private bool disposedValue = false; // To detect redundant calls

        protected virtual void Dispose(bool disposing) {
            if (!disposedValue) {
                if (disposing) {
                    // TODO: dispose managed state (managed objects).
                    this.predicates.ForEach(predicate => predicate.Dispose());
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
        // ~WhereCluase() {
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

    abstract class Predicate : IDisposable {
        protected List<string> predicates;

        public Predicate() {
            this.predicates = new List<string>();
        }

        public List<string> Predicates => this.predicates;

        #region IDisposable Support
        private bool disposedValue = false; // To detect redundant calls

        protected virtual void Dispose(bool disposing) {
            if (!disposedValue) {
                if (disposing) {
                    // TODO: dispose managed state (managed objects).
                    this.predicates.Clear();
                }

                // TODO: free unmanaged resources (unmanaged objects) and override a finalizer below.
                // TODO: set large fields to null.
                this.predicates = null;

                disposedValue = true;
            }
        }

        // TODO: override a finalizer only if Dispose(bool disposing) above has code to free unmanaged resources.
        // ~Predicate() {
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

    class AndPredicate : Predicate {
        public AndPredicate() : base() { }
    }

    class OrPredicate : Predicate {
        public OrPredicate() : base() { }
    }
}

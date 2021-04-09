using System;
using System.Collections.Generic;
using System.Linq;

using System.Data.SqlClient;

namespace AirtoursBusinessObjects.Builder {
    public class WhereClause : IDisposable {
        private List<Predicate> predicates;
        private List<SqlParameter> parameters;

        public WhereClause() {
            this.predicates = new List<Predicate>();
            this.parameters = new List<SqlParameter>();

            this.predicates.Add(new AndPredicate());
        }

        public SqlParameter[] Parameters => this.parameters.ToArray();

        #region Operators
        public WhereClause AndWhere(string columnName, dynamic value) => this.AndWhere(columnName, WhereOpreators.EqualTo, value);
        public WhereClause AndWhere(string columnName, WhereOpreators @operator, dynamic value) {
            var last = predicates.Last();
            var whereOpreator = this.whereOpreatorToSymbol(@operator);

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} {whereOpreator} @{columnName}");

            return this;
        }

        public WhereClause OrWhere(string columnName, dynamic value) => this.OrWhere(columnName, WhereOpreators.EqualTo, value);
        public WhereClause OrWhere(string columnName, WhereOpreators @operator, dynamic value) {
            predicates.Add(new OrPredicate());

            return this.AndWhere(columnName, @operator, value);
        }

        public WhereClause AndWhereBetween(string columnName, IComparable minValue, IComparable maxValue, bool not = false) {
            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";
            string minPlaceholder = $"Min{columnName}";
            string maxPlaceholder = $"Max{columnName}";

            parameters.Add(new SqlParameter(minPlaceholder, minValue));
            parameters.Add(new SqlParameter(maxPlaceholder, maxValue));
            last.Predicates.Add($"{prefix}{columnName} BETWEEN @{minPlaceholder} AND @{maxPlaceholder}");

            return this;
        }

        public WhereClause OrWhereBetween(string columnName, IComparable minValue, IComparable maxValue, bool not = false) {
            predicates.Add(new OrPredicate());

            return this.AndWhereBetween(columnName, minValue, maxValue, not);
        }

        public WhereClause AndWhereIs(string columnName, bool value, bool not = false) {
            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";
            string strValue = value == true ? "TRUE" : "FALSE";

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} IS {prefix}{strValue}");

            return this;
        }

        public WhereClause OrWhereIs(string columnName, bool value, bool not = false) {
            predicates.Add(new OrPredicate());

            return this.AndWhereBetween(columnName, value, not);
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
        #endregion Operators

        private string whereOpreatorToSymbol(WhereOpreators whereOpreator) {
            switch (whereOpreator) {
                case WhereOpreators.EqualTo:
                    return "=";
                case WhereOpreators.NotEqualTo:
                    return "!=";
                case WhereOpreators.GreaterThan:
                    return ">";
                case WhereOpreators.GreaterThanOrEqual:
                    return ">=";
                case WhereOpreators.LessThan:
                    return "<";
                case WhereOpreators.LessThanOrEqual:
                    return "<=";
            }

            return null;
        }

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

    public enum WhereOpreators {
        EqualTo, NotEqualTo,
        GreaterThan, LessThan,
        GreaterThanOrEqual, LessThanOrEqual,
    }
}

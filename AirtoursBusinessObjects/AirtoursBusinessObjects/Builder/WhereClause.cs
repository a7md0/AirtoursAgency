using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data.SqlClient;

namespace AirtoursBusinessObjects.Builder {
    using Schema;

    public class WhereClause : IDisposable {
        private List<Predicate> predicates;
        private List<SqlParameter> parameters;

        private TableSchema schema = null;

        public WhereClause() {
            this.predicates = new List<Predicate>();
            this.parameters = new List<SqlParameter>();

            this.predicates.Add(new AndPredicate());
        }

        public WhereClause(TableSchema schema) : this() {
            this.schema = schema;
        }

        public SqlParameter[] Parameters => this.parameters.ToArray();
        public bool HasAny => this.parameters.Count > 0;

        public WhereClause Or() {
            predicates.Add(new OrPredicate());

            return this;
        }

        #region Operators
        public WhereClause Where(string columnName, object value) => this.Where(columnName, WhereOpreators.EqualTo, value);
        public WhereClause Where(string columnName, WhereOpreators @operator, object value) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            var last = predicates.Last();
            var whereOpreator = this.whereOpreatorToSymbol(@operator);

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"[{columnName}] {whereOpreator} @{columnName}");

            return this;
        }

        public WhereClause WhereBetween(string columnName, IComparable minValue, IComparable maxValue, bool equal = true) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            var last = predicates.Last();

            string prefix = equal == false ? "NOT " : "";
            string minPlaceholder = $"Min{columnName}";
            string maxPlaceholder = $"Max{columnName}";

            parameters.Add(new SqlParameter(minPlaceholder, minValue));
            parameters.Add(new SqlParameter(maxPlaceholder, maxValue));
            last.Predicates.Add($"{prefix}[{columnName}] BETWEEN @{minPlaceholder} AND @{maxPlaceholder}");

            return this;
        }

        public WhereClause WhereIs(string columnName, bool? value, bool equal = true) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            var last = predicates.Last();

            string prefix = equal == false ? "NOT " : "";
            string strValue = value.HasValue ? (value == true ? "TRUE" : "FALSE") : "NULL";

            last.Predicates.Add($"[{columnName}] IS {prefix}{strValue}");

            return this;
        }

        public WhereClause WhereDate(string columnName, DateTime value) => this.WhereDate(columnName, WhereOpreators.EqualTo, value);
        public WhereClause WhereDate(string columnName, WhereOpreators @operator, DateTime value) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            var last = predicates.Last();
            var whereOpreator = this.whereOpreatorToSymbol(@operator);

            if (@operator == WhereOpreators.EqualTo) {
                string minPlaceholder = $"Min{columnName}";
                string maxPlaceholder = $"Max{columnName}";

                parameters.Add(new SqlParameter(minPlaceholder, value.Date));
                parameters.Add(new SqlParameter(maxPlaceholder, value.Date.AddDays(1)));

                last.Predicates.Add($"[{columnName}] >= @{minPlaceholder}");
                last.Predicates.Add($"[{columnName}] < @{maxPlaceholder}");
            } else {
                parameters.Add(new SqlParameter(columnName, value.Date));
                last.Predicates.Add($"[{columnName}] {whereOpreator} @{columnName}");
            }
            
            // last.Predicates.Add($"CAST([{columnName}] as date) {whereOpreator} CAST(@{columnName} as date)");

            return this;
        }

        public WhereClause Like(string columnName, object value, bool not = false) {
            throw new NotImplementedException();

#pragma warning disable CS0162 // Unreachable code detected
            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{prefix}[{columnName}] LIKE @{columnName}");

            return this;
#pragma warning restore CS0162 // Unreachable code detected
        }

        public WhereClause In(string columnName, object value, bool not = false) {
            throw new NotImplementedException();
#pragma warning disable CS0162 // Unreachable code detected
            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";
            //string fValues = "";

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{prefix}[{columnName}] LIKE @{columnName}");

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

        public override string ToString() => this.ToString();
        public string ToString(string columnPrefix = null) {
            StringBuilder clause = new StringBuilder();

            foreach (var predicate in this.predicates) {
                string op = predicate is AndPredicate ? " AND " : " OR ";
                if (clause.Length == 0) {
                    op = "";
                }

                var predicates = predicate.Predicates;
                if (columnPrefix is null == false) {
                    predicates = predicates.Select(p => p.Insert(p.IndexOf('['), $"{columnPrefix}.")).ToList();
                }

                clause.Append(op + string.Join(" AND ", predicates));
            }

            return clause.ToString();
        }

        #region Clone-able Support
        protected WhereClause(WhereClause another) {
            this.predicates = new List<Predicate>(another.predicates);
            this.parameters = new List<SqlParameter>(another.parameters);
        }

        public WhereClause Clone() => new WhereClause(this);
        #endregion

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

        #region Clone-able Support
        protected Predicate(Predicate another) {
            this.predicates = new List<string>(another.predicates);
        }

        public abstract Predicate Clone();
        #endregion

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

        #region Clone-able Support
        protected AndPredicate(AndPredicate another) : base(another) { }

        public override Predicate Clone() => new AndPredicate(this);
        #endregion
    }

    class OrPredicate : Predicate {
        public OrPredicate() : base() { }

        #region Clone-able Support
        protected OrPredicate(OrPredicate another) : base(another) { }

        public override Predicate Clone() => new OrPredicate(this);
        #endregion
    }

    public enum WhereOpreators {
        EqualTo, NotEqualTo,
        GreaterThan, LessThan,
        GreaterThanOrEqual, LessThanOrEqual,
    }
}

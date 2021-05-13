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
        public bool HasAny => this.parameters.Count > 0 || this.predicates[0].Predicates.Count > 0;

        public WhereClause Or() {
            predicates.Add(new OrPredicate());

            return this;
        }

        #region Operators
        public WhereClause Where(string columnName, object value) => this.Where(columnName, WhereOpreators.EqualTo, value);
        public WhereClause Where(string columnName, WhereOpreators @operator, object value) {
            this.checkColumnName(columnName);

            var last = this.predicates.Last();
            var whereOpreator = this.whereOpreatorToSymbol(@operator);

            this.parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"[{columnName}] {whereOpreator} @{columnName}");

            return this;
        }

        public WhereClause WhereBetween(string columnName, IComparable minValue, IComparable maxValue, bool equal = true) {
            this.checkColumnName(columnName);

            var last = this.predicates.Last();

            string prefix = equal == false ? "NOT " : "";
            string minPlaceholder = $"Min{columnName}";
            string maxPlaceholder = $"Max{columnName}";

            this.parameters.Add(new SqlParameter(minPlaceholder, minValue));
            this.parameters.Add(new SqlParameter(maxPlaceholder, maxValue));
            last.Predicates.Add($"{prefix}[{columnName}] BETWEEN @{minPlaceholder} AND @{maxPlaceholder}");

            return this;
        }

        public WhereClause WhereIs(string columnName, bool? value, bool equal = true) {
            this.checkColumnName(columnName);

            var last = this.predicates.Last();

            string prefix = equal == false ? "NOT " : "";
            string strValue = value.HasValue ? (value == true ? "TRUE" : "FALSE") : "NULL";

            last.Predicates.Add($"[{columnName}] IS {prefix}{strValue}");

            return this;
        }

        public WhereClause WhereDate(string columnName, DateTime value) => this.WhereDate(columnName, WhereOpreators.EqualTo, value);
        public WhereClause WhereDate(string columnName, WhereOpreators @operator, DateTime value) {
            this.checkColumnName(columnName);

            var last = this.predicates.Last();
            var whereOpreator = this.whereOpreatorToSymbol(@operator);

            if (@operator == WhereOpreators.EqualTo) {
                string minPlaceholder = $"Min{columnName}";
                string maxPlaceholder = $"Max{columnName}";

                this.parameters.Add(new SqlParameter(minPlaceholder, value.Date));
                this.parameters.Add(new SqlParameter(maxPlaceholder, value.Date.AddDays(1)));

                last.Predicates.Add($"[{columnName}] >= @{minPlaceholder}");
                last.Predicates.Add($"[{columnName}] < @{maxPlaceholder}");
            } else {
                this.parameters.Add(new SqlParameter(columnName, value.Date));
                last.Predicates.Add($"[{columnName}] {whereOpreator} @{columnName}");
            }

            // last.Predicates.Add($"CAST([{columnName}] as date) {whereOpreator} CAST(@{columnName} as date)");

            return this;
        }

        public WhereClause WhereLike(string columnName, string like, bool equal = true) {
            var last = this.predicates.Last();

            string prefix = equal == false ? "NOT " : "";

            this.parameters.Add(new SqlParameter(columnName, like));
            last.Predicates.Add($"{prefix}[{columnName}] LIKE @{columnName}");

            return this;
        }

        public WhereClause WhereIn(string columnName, object[] values, bool equal = true) {
            this.checkColumnName(columnName);

            var last = this.predicates.Last();

            string prefix = equal == false ? "NOT " : "";
            var list = new List<string>();

            for (int i = 0; i < values.Length; i++) {
                var value = values[i];
                var placeholder = $"{columnName}Val{i}";

                this.parameters.Add(new SqlParameter(placeholder, value));
                list.Add($"@{placeholder}");
            }

            var joinedList = string.Join(", ", list);

            last.Predicates.Add($"[{columnName}] {prefix}IN ({joinedList})");

            return this;
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

        private void checkColumnName(string columnName) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }
        }

        public override string ToString() => this.ToString();
        public string ToString(string columnPrefix = null) {
            StringBuilder clause = new StringBuilder(); // New string builder

            foreach (var predicate in this.predicates) {
                var predicates = predicate.Predicates;
                if (columnPrefix is null == false) {
                    predicates = predicates.Select(p => p.Insert(p.IndexOf('['), $"{columnPrefix}.")).ToList();
                }

                if (predicates.Count > 0) { // If there's items in the predicates
                    if (clause.Length > 0) { // If the clause already have something appended
                        clause.Append($" {predicate.ToString()} "); // Append the operator (either an AND or OR based on the current predicate)
                    }

                    clause.Append(string.Join(" AND ", predicates)); // Append the predicates joined with AND
                }
            }

            return clause.ToString(); // Return the string from StringBuilder
        }

        #region Clone-able Support
        protected WhereClause(WhereClause another) {
            this.predicates = new List<Predicate>(another.predicates);
            this.parameters = new List<SqlParameter>(another.parameters);
            this.schema = another.schema;
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

        public override string ToString() {
            return "AND";
        }

        #region Clone-able Support
        protected AndPredicate(AndPredicate another) : base(another) { }

        public override Predicate Clone() => new AndPredicate(this);
        #endregion
    }

    class OrPredicate : Predicate {
        public OrPredicate() : base() { }

        public override string ToString() {
            return "OR";
        }

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

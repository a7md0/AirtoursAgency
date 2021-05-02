﻿using System;
using System.Collections.Generic;
using System.Linq;

using System.Data.SqlClient;

namespace AirtoursBusinessObjects.Builder {
    using Schema;

    public class WhereClause : IDisposable {
        private List<Predicate> predicates;
        private List<SqlParameter> parameters;

        private TableSchema schema = null;

        private WhereClause() {
            this.predicates = new List<Predicate>();
            this.parameters = new List<SqlParameter>();

            this.predicates.Add(new AndPredicate());
        }

        public WhereClause(TableSchema schema) : this() {
            this.schema = schema;
        }

        public SqlParameter[] Parameters => this.parameters.ToArray();
        public bool HasAny => this.parameters.Count > 0;

        #region Operators
        public WhereClause AndWhere(string columnName, object value) => this.AndWhere(columnName, WhereOpreators.EqualTo, value);
        public WhereClause AndWhere(string columnName, WhereOpreators @operator, object value) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            var last = predicates.Last();
            var whereOpreator = this.whereOpreatorToSymbol(@operator);

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"[{columnName}] {whereOpreator} @{columnName}");

            return this;
        }

        public WhereClause OrWhere(string columnName, object value) => this.OrWhere(columnName, WhereOpreators.EqualTo, value);
        public WhereClause OrWhere(string columnName, WhereOpreators @operator, object value) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            predicates.Add(new OrPredicate());

            return this.AndWhere(columnName, @operator, value);
        }

        public WhereClause AndWhereBetween(string columnName, IComparable minValue, IComparable maxValue, bool not = false) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";
            string minPlaceholder = $"Min{columnName}";
            string maxPlaceholder = $"Max{columnName}";

            parameters.Add(new SqlParameter(minPlaceholder, minValue));
            parameters.Add(new SqlParameter(maxPlaceholder, maxValue));
            last.Predicates.Add($"{prefix}[{columnName}] BETWEEN @{minPlaceholder} AND @{maxPlaceholder}");

            return this;
        }

        public WhereClause OrWhereBetween(string columnName, IComparable minValue, IComparable maxValue, bool not = false) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            predicates.Add(new OrPredicate());

            return this.AndWhereBetween(columnName, minValue, maxValue, not);
        }

        public WhereClause AndWhereIs(string columnName, bool value, bool not = false) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";
            string strValue = value == true ? "TRUE" : "FALSE";

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"[{columnName}] IS {prefix}{strValue}");

            return this;
        }

        public WhereClause OrWhereIs(string columnName, bool value, bool not = false) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            predicates.Add(new OrPredicate());

            return this.AndWhereIs(columnName, value, not);
        }

        public WhereClause AndWhereIsNull(string columnName, bool not = false) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";

            last.Predicates.Add($"[{columnName}] IS {prefix}NULL");

            return this;
        }

        public WhereClause OrWhereIsNull(string columnName, bool not = false) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            predicates.Add(new OrPredicate());

            return this.AndWhereIsNull(columnName, not);
        }

        public WhereClause AndWhereDate(string columnName, DateTime value) => this.AndWhereDate(columnName, WhereOpreators.EqualTo, value);
        public WhereClause AndWhereDate(string columnName, WhereOpreators @operator, DateTime value) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            var last = predicates.Last();
            var whereOpreator = this.whereOpreatorToSymbol(@operator);

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"CAST([{columnName}] as date) {whereOpreator} CAST(@{columnName} as date)");

            return this;
        }

        public WhereClause OrWhereDate(string columnName, DateTime value) => this.OrWhereDate(columnName, WhereOpreators.EqualTo, value);
        public WhereClause OrWhereDate(string columnName, WhereOpreators @operator, DateTime value) {
            if (this.schema is null == false && !this.schema.HasColumn(columnName)) {
                throw new ArgumentOutOfRangeException(columnName, "This column does not exist in the table schema.");
            }

            predicates.Add(new OrPredicate());

            return this.AndWhereDate(columnName, @operator, value);
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

        public override string ToString() => this.ToString(null);
        public string ToString(string columnPrefix = null) {
            string clause = "";
            bool isFirst = true;

            foreach (var predicate in this.predicates) {
                string op = predicate is AndPredicate ? " AND " : " OR ";
                if (isFirst) {
                    op = "WHERE ";
                    isFirst = false;
                }

                var predicates = predicate.Predicates;
                if (columnPrefix is null == false) {
                    predicates = predicates.Select(p => $"{columnPrefix}.{p}").ToList();
                }

                clause += op + string.Join(" AND ", predicates);
            }

            return clause;
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

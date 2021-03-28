using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data.SqlClient;

namespace NwindBusinessObjects.Builder {
    public class WhereCluase {
        private List<Predicate> predicates;
        private List<SqlParameter> parameters;

        public WhereCluase() {
            this.predicates = new List<Predicate>();
            this.parameters = new List<SqlParameter>();

            this.predicates.Add(new AndPredicate());
        }

        public WhereCluase And() {
            //values.Add(key, value);
            predicates.Add(new AndPredicate());

            return this;
        }

        public WhereCluase Or() {
            //values.Add(key, value);
            predicates.Add(new OrPredicate());

            return this;
        }

        #region operators
        // see https://en.wikipedia.org/wiki/SQL_syntax#Operators

        public WhereCluase EqualTo(string columnName, object value) {
            var last = predicates.Last();

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} = @{columnName}");

            return this;
        }

        public WhereCluase NotEqualTo(string columnName, object value) {
            var last = predicates.Last();

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} != @{columnName}");

            return this;
        }

        public WhereCluase GreaterThan(string columnName, IComparable value) {
            var last = predicates.Last();

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} > @{columnName}");

            return this;
        }

        public WhereCluase LessThan(string columnName, IComparable value) {
            var last = predicates.Last();

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} < @{columnName}");

            return this;
        }

        public WhereCluase GreaterThanOrEqual(string columnName, IComparable value) {
            var last = predicates.Last();

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} >= @{columnName}");

            return this;
        }

        public WhereCluase LessThanOrEqual(string columnName, IComparable value) {
            var last = predicates.Last();

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{columnName} <= @{columnName}");

            return this;
        }

        public WhereCluase Between(string columnName, IComparable minValue, IComparable maxValue, bool not = false) {
            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";
            string minPlaceholder = $"min{columnName}";
            string maxPlaceholder = $"max{columnName}";

            parameters.Add(new SqlParameter(minPlaceholder, minValue));
            parameters.Add(new SqlParameter(maxPlaceholder, maxValue));
            last.Predicates.Add($"{prefix}{columnName} BETWEEN @{minPlaceholder} AND @{maxPlaceholder}");

            return this;
        }

        public WhereCluase Like(string columnName, dynamic value, bool not = false) {
            throw new NotImplementedException();

#pragma warning disable CS0162 // Unreachable code detected
            var last = predicates.Last();

            string prefix = not == true ? "NOT " : "";

            parameters.Add(new SqlParameter(columnName, value));
            last.Predicates.Add($"{prefix}{columnName} LIKE @{columnName}");

            return this;
#pragma warning restore CS0162 // Unreachable code detected
        }

        public WhereCluase In(string columnName, dynamic value, bool not = false) {
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

        public WhereCluase Is(string columnName, bool value, bool not = false) {
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
    }

    abstract class Predicate {
        protected List<string> predicates;

        public Predicate() {
            this.predicates = new List<string>();
        }

        public List<string> Predicates => this.predicates;
    }

    class AndPredicate : Predicate {
        public AndPredicate() : base() { }
    }

    class OrPredicate : Predicate {
        public OrPredicate() : base() { }
    }
}

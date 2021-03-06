using System.Reflection;

namespace AirtoursBusinessObjects {
    using Builder;
    using Schema;

    public abstract class DataListJoin<T> : DataList<T> where T : ModelJoin, new() {
        protected readonly string pkJoinColumn;

        public DataListJoin() : base() {
            TableAttribute tableAttribute = typeof(T).GetCustomAttribute<TableAttribute>();

            this.pkJoinColumn = tableAttribute.PkJoinColumn;
            base.nonUpdateableColumns = new[] { base.pkColumn, this.pkJoinColumn };
        }

        protected override WhereClause ModelWhereClause(T model) => base.ModelWhereClause(model).Where(this.pkJoinColumn, model.GetJoinId());
    }
}

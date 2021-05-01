using System;
using System.Reflection;
using System.Data.SqlClient;

namespace AirtoursBusinessObjects {
    using Builder;
    using Schema;

    public abstract class ModelListJoin<T> : ModelList<T> where T : ModelJoin, new() {
        protected readonly string pkJoinColumn;

        public ModelListJoin() : base() {
            var tableAttribute = typeof(T).GetCustomAttribute<TableAttribute>();

            this.pkJoinColumn = tableAttribute.PkJoinColumn;
            base.nonUpdateableColumns[1] = this.pkJoinColumn;
        }

        protected override string whereModelClause(SqlCommand command, T item) {
            command.Parameters.AddWithValue(this.pkJoinColumn, item.GetJoinId());

            return $"{base.whereModelClause(command, item)} AND [{this.pkJoinColumn}] = @{this.pkJoinColumn}";
        }
    }
}

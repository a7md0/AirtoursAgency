using System;
using System.Reflection;
using System.Data.SqlClient;

namespace AirtoursBusinessObjects {
    using Schema;

    public abstract class DataListJoin<T> : DataList<T> where T : ItemJoin, new() {
        protected readonly string pkJoinColumn;

        public DataListJoin() : base() {
            var tableAttribute = typeof(T).GetCustomAttribute<TableAttribute>();

            this.pkJoinColumn = tableAttribute.PkJoinColumn;
        }

        protected override string whereItemClause(SqlCommand command, T item) {
            command.Parameters.AddWithValue(this.pkJoinColumn, item.GetJoinId());

            return $"{base.whereItemClause(command, item)} AND [{this.pkJoinColumn}] = @{this.pkJoinColumn}";
        }
    }
}

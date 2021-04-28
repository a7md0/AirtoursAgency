using System;
using System.Reflection;
using System.Data.SqlClient;

namespace AirtoursBusinessObjects {
    using Builder;
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

        public override bool Update(T item) {
            using (var command = base.connection.CreateCommand())
            using (var set = new SetClause(base.schema)) {
                set.Add(item, itemProperties, new[] { base.pkColumn, this.pkJoinColumn });

                if (set.HasAny) {
                    return base.Update(item, command, set);
                }

                return false;
            }
        }
    }
}

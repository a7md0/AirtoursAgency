using System.Reflection;

namespace AirtoursBusinessObjects {
    public abstract class ItemJoin : Item {
        protected PropertyInfo joindIdProperty;

        public ItemJoin() : base() {
            this.joindIdProperty = base.type.GetProperty(base.tableAttribute.PkJoinColumn);
        }

        public dynamic JoinId {
            get => this.joindIdProperty.GetValue(this);
            set => this.joindIdProperty.SetValue(this, value);
        }
    }
}

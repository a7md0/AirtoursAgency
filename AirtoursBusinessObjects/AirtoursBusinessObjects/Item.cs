using System;
using System.Reflection;

namespace AirtoursBusinessObjects {
    using Schema;

    public abstract class Item {
        protected Type type;
        protected TableAttribute tableAttribute;
        protected PropertyInfo idProperty;

        public bool Valid { get; protected set; }
        public string ErrorMessage { get; protected set; }

        public Item() {
            this.type = this.GetType();
            this.tableAttribute = this.type.GetCustomAttribute<TableAttribute>();
            this.idProperty = this.type.GetProperty(this.tableAttribute.PkColumn);
        }

        public dynamic Id {
            get => this.idProperty.GetValue(this);
            set => this.idProperty.SetValue(this, value);
        }

        public void SetError(string message) {
            this.Valid = message == null ? true : false;
            this.ErrorMessage = message;
        }
    }
}

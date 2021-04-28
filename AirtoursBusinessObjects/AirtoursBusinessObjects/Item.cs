using System;
using System.Reflection;

namespace AirtoursBusinessObjects {
    using Schema;

    public abstract class Item {
        protected Type type;
        protected TableAttribute tableAttribute;
        protected PropertyInfo idProperty;

        protected bool valid;
        protected string errorMessage;

        public Item() {
            this.type = this.GetType();
            this.tableAttribute = this.type.GetCustomAttribute<TableAttribute>();
            this.idProperty = this.type.GetProperty(this.tableAttribute.PkColumn);
        }

        public dynamic Id {
            get => this.idProperty.GetValue(this);
            set => this.idProperty.SetValue(this, value);
        }

        public bool Valid {
            get {
                return this.valid;
            }

            set {
                this.valid = value;
            }
        }

        public string ErrorMessage {
            get {
                return this.errorMessage;
            }

            set {
                this.errorMessage = value;
            }
        }
    }
}

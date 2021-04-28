
namespace AirtoursBusinessObjects {
    public abstract class Item {
        public bool Valid { get; protected set; }
        public string ErrorMessage { get; protected set; }

        public Item() { }

        public abstract dynamic GetId();
        public abstract void SetId(dynamic id);

        public void SetError(string message) {
            this.Valid = message == null ? true : false;
            this.ErrorMessage = message;
        }
    }
}

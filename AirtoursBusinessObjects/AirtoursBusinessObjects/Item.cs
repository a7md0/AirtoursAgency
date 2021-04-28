
namespace AirtoursBusinessObjects {
    public abstract class Item {
        public bool Valid { get; protected set; }
        public string ErrorMessage { get; protected set; }

        /// <summary>
        /// Property which indicate whether this item is already inserted in the database.
        /// </summary>
        public bool Inserted { get; protected internal set; } = false;

        public Item() { }

        public abstract dynamic GetId();
        public abstract void SetId(dynamic id);

        public void SetError(string message) {
            this.Valid = message == null ? true : false;
            this.ErrorMessage = message;
        }
    }
}

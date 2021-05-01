
namespace AirtoursBusinessObjects {
    public abstract class Model {
        public bool Valid { get; protected internal set; }
        public string ErrorMessage { get; protected internal set; }

        /// <summary>
        /// Property which indicate whether this item is already inserted in the database.
        /// </summary>
        public bool Inserted { get; protected internal set; } = false;

        public Model() { }

        public abstract dynamic GetId();
        public abstract void SetId(dynamic id);

        protected internal void SetError(string message) {
            this.Valid = message == null ? true : false;
            this.ErrorMessage = message;
        }
    }
}

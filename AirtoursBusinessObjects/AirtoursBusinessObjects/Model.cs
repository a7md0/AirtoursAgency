
namespace AirtoursBusinessObjects {
    [System.Serializable]
    public abstract class Model {
        /// <summary>
        /// If this model has any previous errors
        /// </summary>
        public bool Valid { get; protected internal set; }

        /// <summary>
        /// Latest errors with this model
        /// </summary>
        public string ErrorMessage { get; protected internal set; }

        /// <summary>
        /// Property which indicate whether this item is already inserted in the database.
        /// </summary>
        public bool Inserted { get; protected internal set; } = false;

        public Model() { }

        /// <summary>
        /// Get the id value of this model
        /// </summary>
        /// <returns>Id value</returns>
        public abstract object GetId();

        /// <summary>
        /// Set the id value of this model
        /// </summary>
        /// <param name="id">New id</param>
        public abstract void SetId(object id);

        /// <summary>
        /// Set error message for this model
        /// </summary>
        /// <param name="message">The error message or null</param>
        protected internal void SetError(string message) {
            this.Valid = message == null ? true : false;
            this.ErrorMessage = message;
        }
    }
}

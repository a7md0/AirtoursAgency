
namespace AirtoursBusinessObjects {
    public abstract class ModelJoin : Model {

        public ModelJoin() : base() { }

        /// <summary>
        /// Get the join id value of this model
        /// </summary>
        /// <returns>Join id value</returns>
        public abstract object GetJoinId();

        /// <summary>
        /// Set the join id value of this model
        /// </summary>
        /// <param name="joinId">New join id</param>
        public abstract void SetJoinId(object joinId);
    }
}

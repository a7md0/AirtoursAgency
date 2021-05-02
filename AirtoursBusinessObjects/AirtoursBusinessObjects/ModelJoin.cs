
namespace AirtoursBusinessObjects {
    public abstract class ModelJoin : Model {

        public ModelJoin() : base() { }

        public abstract object GetJoinId();
        public abstract void SetJoinId(object joinId);
    }
}

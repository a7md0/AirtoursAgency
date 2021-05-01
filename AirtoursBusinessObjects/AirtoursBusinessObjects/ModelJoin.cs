
namespace AirtoursBusinessObjects {
    public abstract class ModelJoin : Model {

        public ModelJoin() : base() { }

        public abstract dynamic GetJoinId();
        public abstract void SetJoinId(dynamic joinId);
    }
}

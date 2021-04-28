
namespace AirtoursBusinessObjects {
    public abstract class ItemJoin : Item {

        public ItemJoin() : base() { }

        public abstract dynamic GetJoinId();
        public abstract void SetJoinId(dynamic joinId);
    }
}

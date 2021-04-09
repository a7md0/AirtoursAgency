
namespace AirtoursBusinessObjects {
    public abstract class ItemJoin : Item {
        private readonly string joinId;

        public ItemJoin(string id, string joinId) : base(id) {
            this.joinId = joinId;
        }

        public ItemJoin() : base() { }

        public string JoinId => this.joinId;
    }
}

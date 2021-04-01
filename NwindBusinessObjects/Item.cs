
namespace NwindBusinessObjects {
    public abstract class Item {
        protected string id;

        public Item(string id) {
            this.id = id;
        }

        public Item() { }

        public string Id => this.id;
        public string getID() => this.id;
    }
}

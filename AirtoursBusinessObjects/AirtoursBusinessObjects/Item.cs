
namespace AirtoursBusinessObjects {
    public abstract class Item {
        protected string id;

        private bool valid;
        private string errorMessage;

        public Item(string id) {
            this.id = id;
        }

        public Item() { }

        public string Id => this.id;

        public bool Valid {
            get {
                return this.valid;
            }

            set {
                this.valid = value;
            }
        }

        public string ErrorMessage {
            get {
                return this.errorMessage;
            }

            set {
                this.errorMessage = value;
            }
        }

        public string getID() => this.id;
    }
}

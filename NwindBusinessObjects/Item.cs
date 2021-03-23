using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NwindBusinessObjects {
    public abstract class Item {
        protected string id;

        public Item(string id) {
            this.id = id;
        }

        public Item() { }

        public string Id {
            get { return id; }
            //set { id = value; }
        }

        public string getID() {
            return this.id;
        }

        /*public void setID(string id) {
            this.id = id;
        }*/
    }
}

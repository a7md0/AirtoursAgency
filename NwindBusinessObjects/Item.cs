using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NwindBusinessObjects {
    public abstract class Item<T> {
        protected T id;

        public Item(T id) {
            this.id = id;
        }

        public Item() { }

        public T Id {
            get { return id; }
            set { id = value; }
        }
    }
}

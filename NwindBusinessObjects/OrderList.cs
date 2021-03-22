using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NwindBusinessObjects {
    public class OrderList : DataList<Order> {
        const string TABLE_NAME = "Orders";

        public OrderList() : base(TABLE_NAME, "OrderID") { }
    }
}

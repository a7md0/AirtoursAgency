using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NwindBusinessObjects {
    public class OrderList : DataList<Order> {
        const string TABLE_NAME = "Orders";
        const string PK_COLUMN = "OrderID";

        public OrderList() : base(TABLE_NAME, PK_COLUMN) { }
    }
}

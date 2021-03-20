using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NwindBusinessObjects {
    public class CustomerList : DataList<Customer> {
        const string TABLE_NAME = "Customers";

        public CustomerList() : base(TABLE_NAME) { }

        protected override void GenerateList() {
            list.Clear();

            while (reader.Read()) {
                var customer = new Customer();
                base.SetValues(customer);
                list.Add(customer);
            }

            reader.Close();
            connection.Close();
        }
    }
}

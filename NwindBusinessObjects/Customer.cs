using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NwindBusinessObjects {
    public class Customer : Item<string> {
        private string companyName;
        private string contactName;
        private string contactTitle;
        private string address;
        private string city;
        private string region;
        private string postalCode;
        private string country;
        private string phone;
        private string fax;

        public Customer(string customerID) : base(customerID) { }

        public Customer() { }

        public string CustomerID {
            get { return base.id; }
            set { base.id = value; }
        }

        public string CompanyName {
            get { return companyName; }
            set { companyName = value; }
        }

        public string ContactName {
            get { return contactName; }
            set { contactName = value; }
        }

        public string ContactTitle {
            get { return contactTitle; }
            set { contactTitle = value; }
        }

        public string Address {
            get { return address; }
            set { address = value; }
        }

        public string City {
            get { return city; }
            set { city = value; }
        }

        public string Region {
            get { return region; }
            set { region = value; }
        }

        public string PostalCode {
            get { return postalCode; }
            set { postalCode = value; }
        }

        public string Country {
            get { return country; }
            set { country = value; }
        }

        public string Phone {
            get { return phone; }
            set { phone = value; }
        }

        public string Fax {
            get { return fax; }
            set { fax = value; }
        }
    }
}

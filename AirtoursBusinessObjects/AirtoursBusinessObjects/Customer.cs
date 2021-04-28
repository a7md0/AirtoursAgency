using System;

namespace AirtoursBusinessObjects {
    using Schema;

    [Table("Customer", "CustomerID")]
    public class Customer : Item {

        private int customerID;
        private string lname; // null-able:	YES
        private string fname; // null-able:	YES
        private string phone; // null-able:	YES
        private string address;   // null-able:	YES
        private string city;  // null-able:	YES
        private string region;    // null-able:	YES
        private string postalCode;    // null-able:	YES
        private string country;   // null-able:	YES
        private string fax;   // null-able:	YES
        private string email; // null-able:	YES
        private int? miles;  // null-able:	YES
        private string password;  // null-able:	YES
        private string creditCardNumber;  // null-able:	YES
        private int? securityCode;	// null-able:	YES

        public Customer(int customerID) : base() {
            this.customerID = customerID;
        }

        public Customer() : base() { }

        public int CustomerID {
            get {
                return this.customerID;
            }

            set {
                this.customerID = value;
            }
        }

        public string Lname {
            get {
                return this.lname;
            }

            set {
                this.lname = value;
            }
        }

        public string Fname {
            get {
                return this.fname;
            }

            set {
                this.fname = value;
            }
        }

        public string Phone {
            get {
                return this.phone;
            }

            set {
                this.phone = value;
            }
        }

        public string Address {
            get {
                return this.address;
            }

            set {
                this.address = value;
            }
        }

        public string City {
            get {
                return this.city;
            }

            set {
                this.city = value;
            }
        }

        public string Region {
            get {
                return this.region;
            }

            set {
                this.region = value;
            }
        }

        public string PostalCode {
            get {
                return this.postalCode;
            }

            set {
                this.postalCode = value;
            }
        }

        public string Country {
            get {
                return this.country;
            }

            set {
                this.country = value;
            }
        }

        public string Fax {
            get {
                return this.fax;
            }

            set {
                this.fax = value;
            }
        }

        public string Email {
            get {
                return this.email;
            }

            set {
                this.email = value;
            }
        }

        public int? Miles {
            get {
                return this.miles;
            }

            set {
                this.miles = value;
            }
        }

        public string Password {
            get {
                return this.password;
            }

            set {
                this.password = value;
            }
        }

        public string CreditCardNumber {
            get {
                return this.creditCardNumber;
            }

            set {
                this.creditCardNumber = value;
            }
        }

        public int? SecurityCode {
            get {
                return this.securityCode;
            }

            set {
                this.securityCode = value;
            }
        }
    }
}

using System;

namespace AirtoursBusinessObjects {
    using Schema;

    [Table("Employee", "EmployeeID")]
    public class Employee : Item {

        private int employeeID;
        private string lname; // null-able:	YES
        private string fname; // null-able:	YES
        private DateTime? birthDate; // null-able:	YES
        private DateTime? hireDate;  // null-able:	YES
        private string address;   // null-able:	YES
        private string city;  // null-able:	YES
        private string region;    // null-able:	YES
        private string phone; // null-able:	YES
        private string notes;	// null-able:	YES

        public Employee(int employeeID) : base(employeeID.ToString()) {
            this.employeeID = employeeID;
        }

        public Employee() : base() { }

        public int EmployeeID {
            get {
                return this.employeeID;
            }

            set {
                base.id = value.ToString();
                this.employeeID = value;
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

        public DateTime? BirthDate {
            get {
                return this.birthDate;
            }

            set {
                this.birthDate = value;
            }
        }

        public DateTime? HireDate {
            get {
                return this.hireDate;
            }

            set {
                this.hireDate = value;
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

        public string Phone {
            get {
                return this.phone;
            }

            set {
                this.phone = value;
            }
        }

        public string Notes {
            get {
                return this.notes;
            }

            set {
                this.notes = value;
            }
        }
    }
}

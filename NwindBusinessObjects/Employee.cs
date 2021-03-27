using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NwindBusinessObjects {
    public class Employee : Item {
        private int employeeID;
        private string lastName;
        private string firstName;
        private string title;
        private string titleOfCourtesy;
        private DateTime? birthDate;
        private DateTime? hireDate;
        private string address;
        private string city;
        private string region;
        private string postalCode;
        private string country;
        private string homePhone;
        private string extension;
        private byte[] photo;
        private string notes;
        private int? reportsTo;
        private string photoPath;

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

        public string LastName {
            get {
                return this.lastName;
            }

            set {
                this.lastName = value;
            }
        }

        public string FirstName {
            get {
                return this.firstName;
            }

            set {
                this.firstName = value;
            }
        }

        public string Title {
            get {
                return this.title;
            }

            set {
                this.title = value;
            }
        }

        public string TitleOfCourtesy {
            get {
                return this.titleOfCourtesy;
            }

            set {
                this.titleOfCourtesy = value;
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

        public string HomePhone {
            get {
                return this.homePhone;
            }

            set {
                this.homePhone = value;
            }
        }

        public string Extension {
            get {
                return this.extension;
            }

            set {
                this.extension = value;
            }
        }

        public byte[] Photo {
            get {
                return this.photo;
            }

            set {
                this.photo = value;
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

        public int? ReportsTo {
            get {
                return this.reportsTo;
            }

            set {
                this.reportsTo = value;
            }
        }

        public string PhotoPath {
            get {
                return this.photoPath;
            }

            set {
                this.photoPath = value;
            }
        }
    }
}

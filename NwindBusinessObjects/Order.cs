using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NwindBusinessObjects {
    public class Order : Item<int> {
        private string customerID;
        private int? employeeID;
        private DateTime? orderDate;
        private DateTime? requiredDate;
        private DateTime? shippedDate;
        private int? shipVia;
        private decimal? freight;
        private string shipName;
        private string shipAddress;
        private string shipCity;
        private string shipRegion;
        private string shipPostalCode;
        private string shipCountry;

        public Order(int orderId) : base(orderId) { }

        public Order() { }

        public int OrderID {
            get {
                return base.id;
            }

            set {
                base.id = value;
            }
        }

        public string CustomerID {
            get {
                return this.customerID;
            }

            set {
                this.customerID = value;
            }
        }

        public int? EmployeeID {
            get {
                return this.employeeID;
            }

            set {
                this.employeeID = value;
            }
        }

        public DateTime? OrderDate {
            get {
                return this.orderDate;
            }

            set {
                this.orderDate = value;
            }
        }

        public DateTime? RequiredDate {
            get {
                return this.requiredDate;
            }

            set {
                this.requiredDate = value;
            }
        }

        public DateTime? ShippedDate {
            get {
                return this.shippedDate;
            }

            set {
                this.shippedDate = value;
            }
        }

        public int? ShipVia {
            get {
                return this.shipVia;
            }

            set {
                this.shipVia = value;
            }
        }

        public decimal? Freight {
            get {
                return this.freight;
            }

            set {
                this.freight = value;
            }
        }

        public string ShipName {
            get {
                return this.shipName;
            }

            set {
                this.shipName = value;
            }
        }

        public string ShipAddress {
            get {
                return this.shipAddress;
            }

            set {
                this.shipAddress = value;
            }
        }

        public string ShipCity {
            get {
                return this.shipCity;
            }

            set {
                this.shipCity = value;
            }
        }

        public string ShipRegion {
            get {
                return this.shipRegion;
            }

            set {
                this.shipRegion = value;
            }
        }

        public string ShipPostalCode {
            get {
                return this.shipPostalCode;
            }

            set {
                this.shipPostalCode = value;
            }
        }

        public string ShipCountry {
            get {
                return this.shipCountry;
            }

            set {
                this.shipCountry = value;
            }
        }
    }
}

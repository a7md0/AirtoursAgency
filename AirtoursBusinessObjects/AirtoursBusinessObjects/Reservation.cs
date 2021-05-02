using System;

namespace AirtoursBusinessObjects {
    using Schema;

    [Table("Reservation", "ReservationID")]
    public class Reservation : Model {

        private int reservationID;
        private int? customerID; // null-able:	YES
        private int? employeeID; // null-able:	YES
        private bool? paid = false;   // null-able:	YES
        private DateTime? reservationDate;   // null-able:	YES
        private decimal? price;	// null-able:	YES

        public Reservation(int reservationID) : base() {
            this.reservationID = reservationID;
        }

        public Reservation() : base() { }

        public int ReservationID {
            get {
                return this.reservationID;
            }

            set {
                this.reservationID = value;
            }
        }

        public int? CustomerID {
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

        public bool? Paid {
            get {
                return this.paid;
            }

            set {
                this.paid = value;
            }
        }

        public DateTime? ReservationDate {
            get {
                return this.reservationDate;
            }

            set {
                this.reservationDate = value;
            }
        }

        public decimal? Price {
            get {
                return this.price;
            }

            set {
                this.price = value;
            }
        }

        public override object GetId() => this.reservationID;
        public override void SetId(object id) => this.ReservationID = (int) id;
    }
}

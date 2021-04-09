using System;

namespace AirtoursBusinessObjects {
    using Schema;

    [Table("Passenger", "PassengerID")]
    public class Passenger : Item {

        private int passengerID;
        private string firstName; // null-able:	YES
        private string lastName;  // null-able:	YES
        private int? reservationID;	// null-able:	YES

        public Passenger(int passengerID) : base(passengerID.ToString()) {
            this.passengerID = passengerID;
        }

        public Passenger() : base() { }

        public int PassengerID {
            get {
                return this.passengerID;
            }

            set {
                base.id = value.ToString();
                this.passengerID = value;
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

        public string LastName {
            get {
                return this.lastName;
            }

            set {
                this.lastName = value;
            }
        }

        public int? ReservationID {
            get {
                return this.reservationID;
            }

            set {
                this.reservationID = value;
            }
        }
    }
}

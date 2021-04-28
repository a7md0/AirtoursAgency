using System;

namespace AirtoursBusinessObjects {
    using Schema;

    [Table("Flight", "FlightID")]
    public class Flight : Item {

        private int flightID;
        private string flightNumber;  // null-able:	YES
        private string origin;    // null-able:	YES
        private string destination;   // null-able:	YES
        private DateTime? departure; // null-able:	YES
        private DateTime? arrival;   // null-able:	YES
        private string airline;   // null-able:	YES
        private int? aircraftID; // null-able:	YES
        private string terminal;  // null-able:	YES
        private string stops; // null-able:	YES
        private decimal? fare; // null-able:	YES
        private string days;  // null-able:	YES
        private int? miles;	// null-able:	YES

        public Flight(int flightID) : base() {
            this.flightID = flightID;
        }

        public Flight() : base() { }

        public int FlightID {
            get {
                return this.flightID;
            }

            set {
                this.flightID = value;
            }
        }

        public string FlightNumber {
            get {
                return this.flightNumber;
            }

            set {
                this.flightNumber = value;
            }
        }

        public string Origin {
            get {
                return this.origin;
            }

            set {
                this.origin = value;
            }
        }

        public string Destination {
            get {
                return this.destination;
            }

            set {
                this.destination = value;
            }
        }

        public DateTime? Departure {
            get {
                return this.departure;
            }

            set {
                this.departure = value;
            }
        }

        public DateTime? Arrival {
            get {
                return this.arrival;
            }

            set {
                this.arrival = value;
            }
        }

        public string Airline {
            get {
                return this.airline;
            }

            set {
                this.airline = value;
            }
        }

        public int? AircraftID {
            get {
                return this.aircraftID;
            }

            set {
                this.aircraftID = value;
            }
        }

        public string Terminal {
            get {
                return this.terminal;
            }

            set {
                this.terminal = value;
            }
        }

        public string Stops {
            get {
                return this.stops;
            }

            set {
                this.stops = value;
            }
        }

        public decimal? Fare {
            get {
                return this.fare;
            }

            set {
                this.fare = value;
            }
        }

        public string Days {
            get {
                return this.days;
            }

            set {
                this.days = value;
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

        public override dynamic GetId() => this.flightID;
        public override void SetId(dynamic id) => this.FlightID = id;
    }
}

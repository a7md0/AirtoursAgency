using System;

namespace AirtoursBusinessObjects {
    using Schema;

    [Table("ScheduledFlight", "ScheduledFlightID")]
    public class ScheduledFlight : Item {

        private int scheduledFlightID;
        private int? flightID;   // null-able:	YES
        private DateTime? flightDate;	// null-able:	YES

        public ScheduledFlight(int scheduledFlightID) : base(scheduledFlightID.ToString()) {
            this.scheduledFlightID = scheduledFlightID;
        }

        public ScheduledFlight() : base() { }

        public int ScheduledFlightID {
            get {
                return this.scheduledFlightID;
            }

            set {
                base.id = value.ToString();
                this.scheduledFlightID = value;
            }
        }

        public int? FlightID {
            get {
                return this.flightID;
            }

            set {
                this.flightID = value;
            }
        }

        public DateTime? FlightDate {
            get {
                return this.flightDate;
            }

            set {
                this.flightDate = value;
            }
        }
    }
}

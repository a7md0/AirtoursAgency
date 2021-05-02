using System;

namespace AirtoursBusinessObjects {
    using Schema;

    [Table("ScheduledFlight", "ScheduledFlightID")]
    public class ScheduledFlight : Model {

        private int scheduledFlightID;
        private int? flightID;   // null-able:	YES
        private DateTime? flightDate;	// null-able:	YES

        public ScheduledFlight(int scheduledFlightID) : base() {
            this.scheduledFlightID = scheduledFlightID;
        }

        public ScheduledFlight() : base() { }

        public int ScheduledFlightID {
            get {
                return this.scheduledFlightID;
            }

            set {
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

        public override object GetId() => this.scheduledFlightID;
        public override void SetId(object id) => this.ScheduledFlightID = (int) id;
    }
}

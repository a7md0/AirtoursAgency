using System;

namespace AirtoursBusinessObjects {
    using Schema;

    [Table("ReservedSeat", "PassengerID", "ScheduledFlightID")]
    public class ReservedSeat : ItemJoin {

        private int passengerID;
        private int scheduledFlightID;  // null-able:	NO
        private string @class;  // null-able:	YES
        private string status;    // null-able:	YES
        private string sector;	// null-able:	YES

        public ReservedSeat(int passengerID, int scheduledFlightID) : base() {
            this.passengerID = passengerID;
            this.scheduledFlightID = scheduledFlightID;
        }

        public ReservedSeat() : base() { }

        public int PassengerID {
            get {
                return this.passengerID;
            }

            set {
                this.passengerID = value;
            }
        }

        public int ScheduledFlightID {
            get {
                return this.scheduledFlightID;
            }

            set {
                this.scheduledFlightID = value;
            }
        }

        public string Class {
            get {
                return this.@class;
            }

            set {
                this.@class = value;
            }
        }

        public string Status {
            get {
                return this.status;
            }

            set {
                this.status = value;
            }
        }

        public string Sector {
            get {
                return this.sector;
            }

            set {
                this.sector = value;
            }
        }

        public override dynamic GetId() => this.passengerID;
        public override void SetId(dynamic id) => this.PassengerID = id;

        public override dynamic GetJoinId() => this.scheduledFlightID;
        public override void SetJoinId(dynamic joinId) => this.ScheduledFlightID = joinId;
    }
}

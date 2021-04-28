using System;

namespace AirtoursBusinessObjects {
    using Schema;

    [Table("Aircraft", "AircraftID")]
    public class Aircraft : Item {

        private int aircraftID;
        private string model; // null-able:	YES
        private string manufacturer;  // null-able:	YES
        private int? businessCapacity;   // null-able:	YES
        private int? economyCapacity;	// null-able:	YES

        public Aircraft(int aircraftID) : base() {
            this.aircraftID = aircraftID;
        }

        public Aircraft() : base() { }

        public int AircraftID {
            get {
                return this.aircraftID;
            }

            set {
                this.aircraftID = value;
            }
        }

        public string Model {
            get {
                return this.model;
            }

            set {
                this.model = value;
            }
        }

        public string Manufacturer {
            get {
                return this.manufacturer;
            }

            set {
                this.manufacturer = value;
            }
        }

        public int? BusinessCapacity {
            get {
                return this.businessCapacity;
            }

            set {
                this.businessCapacity = value;
            }
        }

        public int? EconomyCapacity {
            get {
                return this.economyCapacity;
            }

            set {
                this.economyCapacity = value;
            }
        }

        public override dynamic GetId() => this.aircraftID;
        public override void SetId(dynamic id) => this.AircraftID = id;
    }
}

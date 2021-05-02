using System;

namespace AirtoursBusinessObjects {
    public class FlightList : ModelList<Flight> {
        public FlightList() : base() { }

        public bool FlightsFilter(string origin, string destination) {
            var where = base.WhereClause.AndWhere("Origin", origin)
                                        .AndWhere("Destination", destination);

            return base.Populate(where);
        }

        public bool FlightsFilter(string origin, string destination, DateTime date) {
            var where = base.WhereClause.AndWhere("Origin", origin)
                                        .AndWhere("Destination", destination);
            var on = new ScheduledFlightList().WhereClause.AndWhereDate("FlightDate", date);

            return base.FilterJoin(where, on, "ScheduledFlight", "FlightID");
        }
    }
}

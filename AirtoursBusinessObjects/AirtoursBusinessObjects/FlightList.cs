using System;

namespace AirtoursBusinessObjects {
    using Builder;

    public class FlightList : DataList<Flight> {
        public FlightList() : base() { }

        public bool FlightsFilter(string origin, string destination) {
            var where = base.WhereClause.Where("Origin", origin)
                                        .Where("Destination", destination);

            return base.Populate(where);
        }

        public bool FlightsFilter(string origin, string destination, DateTime date) {
            var where = base.WhereClause.Where("Origin", origin)
                                        .Where("Destination", destination);
            var on = new WhereClause().WhereDate("FlightDate", date);

            return base.FilterJoin(where, "ScheduledFlight", "FlightID", on);
        }
    }
}

using System;

namespace AirtoursBusinessObjects {
    public class FlightList : ModelList<Flight> {
        public FlightList() : base() { }

        public bool FlightsFilter(string origin, string destination) {
            var where = base.WhereClause.AndWhere("Origin", origin)
                                        .AndWhere("Destination", destination);

            return base.Populate(where);
        }
    }
}

using System;

namespace AirtoursBusinessObjects {
    using Builder;

    public class FlightList : DataList<Flight> {
        public FlightList() : base() { }

        public bool FlightsFilter(string origin, string destination) {
            WhereClause where = base.WhereClause.Where("Origin", origin)
                                        .Where("Destination", destination);

            return base.Populate(where);
        }

        public bool FlightsFilter(string origin, string destination, DateTime date) {
            WhereClause where = base.WhereClause.Where("Origin", origin)
                                        .Where("Destination", destination);
            WhereClause on = new WhereClause().WhereDate("FlightDate", date);

            return base.FilterJoin(where, "ScheduledFlight", "FlightID", on);
        }

        public static decimal CalclauteFlightCost(Flight flight, int numberOfPassengers = 1) {
            if (flight is null || !flight.Fare.HasValue) {
                return 0;
            }

            return flight.Fare.Value * numberOfPassengers;
        }
    }
}

using System;

namespace AirtoursBusinessObjects {
    using Builder;

    public class ReservationList : DataList<Reservation> {
        public ReservationList() : base() { }

        public decimal ReservationsTotalPrice() {
            return base.TotalValue<decimal>("Price");
        }

        public decimal ReservationsTotalPrice(bool paid) {
            WhereClause where = base.WhereClause.Where("Paid", paid);

            return base.TotalValue<decimal>("Price", where);
        }

        public decimal ReservationsTotalPrice(Customer customer) {
            WhereClause where = base.WhereClause.Where("CustomerID", customer.GetId());

            return base.TotalValue<decimal>("Price", where);
        }

        public decimal ReservationsTotalPrice(Customer customer, bool paid) {
            WhereClause where = base.WhereClause.Where("Paid", paid)
                                        .Where("CustomerID", customer.GetId());

            return base.TotalValue<decimal>("Price", where);
        }

        public bool ReservationsFilter(Customer customer) {
            WhereClause where = base.WhereClause.Where("CustomerID", customer.GetId());

            return base.Populate(where);
        }

        public bool FilterFutureReservations(Customer customer) {
            WhereClause whereClause = base.WhereClause;
            whereClause.Where("CustomerID", customer.CustomerID);

            WhereClause onClause = new WhereClause();
            onClause.WhereDate("FlightDate", WhereOpreators.GreaterThan, DateTime.Now);

            return base.FilterJoin(whereClause, "Passenger", "ReservationID", "ReservedSeat", "PassengerID", "ScheduledFlight", "ScheduledFlightID", onClause);
        }
    }
}

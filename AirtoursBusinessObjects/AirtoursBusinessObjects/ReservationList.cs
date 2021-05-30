using System;

namespace AirtoursBusinessObjects {
    using Builder;

    public class ReservationList : DataList<Reservation> {
        public ReservationList() : base() { }

        public decimal ReservationsTotalPrice() {
            return base.TotalValue<decimal>("Price");
        }

        public decimal ReservationsTotalPrice(bool paid) {
            var where = base.WhereClause.Where("Paid", paid);

            return base.TotalValue<decimal>("Price", where);
        }

        public decimal ReservationsTotalPrice(Customer customer) {
            var where = base.WhereClause.Where("CustomerID", customer.GetId());

            return base.TotalValue<decimal>("Price", where);
        }

        public decimal ReservationsTotalPrice(Customer customer, bool paid) {
            var where = base.WhereClause.Where("Paid", paid)
                                        .Where("CustomerID", customer.GetId());

            return base.TotalValue<decimal>("Price", where);
        }

        public bool ReservationsFilter(Customer customer) {
            var where = base.WhereClause.Where("CustomerID", customer.GetId());

            return base.Populate(where);
        }

        public bool FilterFutureReservations(Customer customer) {
            var whereClause = base.WhereClause;
            whereClause.Where("CustomerID", customer.CustomerID);

            var onClause = new WhereClause();
            onClause.WhereDate("FlightDate", WhereOpreators.GreaterThan, DateTime.Now);

            return base.FilterJoin(whereClause, "Passenger", "ReservationID", "ReservedSeat", "PassengerID", "ScheduledFlight", "ScheduledFlightID", onClause);
        }
    }
}

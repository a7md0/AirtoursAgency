using System;

namespace AirtoursBusinessObjects {
    using Builder;

    public class ReservationList : DataList<Reservation> {
        public ReservationList() : base() { }

        /// <summary>
        /// Query the total price for all reservations.
        /// </summary>
        /// <returns></returns>
        public decimal TotalPrice() {
            return base.TotalValue<decimal>("Price");
        }

        /// <summary>
        /// Query the total price for paid or unpaid reservations.
        /// </summary>
        /// <param name="paid"></param>
        /// <returns></returns>
        public decimal TotalPrice(bool paid) {
            WhereClause where = base.WhereClause.Where("Paid", paid); // Construct where clause to match paid or unpaid

            return base.TotalValue<decimal>("Price", where); // Call the base total value and pre-fill the column and the condition
        }

        public decimal TotalPrice(Customer customer) {
            WhereClause where = base.WhereClause.Where("CustomerID", customer.GetId());

            return base.TotalValue<decimal>("Price", where);
        }

        public decimal TotalPrice(Customer customer, bool paid) {
            WhereClause where = base.WhereClause.Where("Paid", paid)
                                        .Where("CustomerID", customer.GetId());

            return base.TotalValue<decimal>("Price", where);
        }

        public bool Filter(Customer customer) {
            WhereClause where = base.WhereClause.Where("CustomerID", customer.GetId());

            return base.Populate(where);
        }

        /// <summary>
        /// Filter only future reservations for given customer.
        /// </summary>
        /// <param name="customer">The customer to match</param>
        /// <returns></returns>
        public bool FilterFutureReservations(Customer customer) {
            WhereClause whereClause = base.WhereClause;
            whereClause.Where("CustomerID", customer.CustomerID);

            WhereClause onClause = new WhereClause();
            onClause.WhereDate("FlightDate", WhereOpreators.GreaterThan, DateTime.Now);

            return base.FilterJoin(whereClause, "Passenger", "ReservationID", "ReservedSeat", "PassengerID", "ScheduledFlight", "ScheduledFlightID", onClause);
        }
    }
}

namespace AirtoursBusinessObjects {
    using Builder;

    public class PassengerList : DataList<Passenger> {
        public PassengerList() : base() { }

        public bool PassengersFilter(Reservation reservation) {
            WhereClause where = base.WhereClause.Where("ReservationID", reservation.ReservationID);

            return base.FilterJoin(where, "ReservedSeat", "PassengerID");
        }
    }
}

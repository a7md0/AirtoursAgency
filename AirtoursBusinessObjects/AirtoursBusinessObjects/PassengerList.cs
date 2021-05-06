namespace AirtoursBusinessObjects {
    public class PassengerList : ModelList<Passenger> {
        public PassengerList() : base() { }

        public bool PassengersFilter(Reservation reservation) {
            var where = base.WhereClause.Where("ReservationID", reservation.ReservationID);

            return base.FilterJoin(where, "ReservedSeat", "PassengerID");
        }
    }
}

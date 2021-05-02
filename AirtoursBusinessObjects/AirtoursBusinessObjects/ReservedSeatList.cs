namespace AirtoursBusinessObjects {
    public class ReservedSeatList : ModelListJoin<ReservedSeat> {
        public ReservedSeatList() : base() { }

        public int ReservedSeatsTotalCount(ScheduledFlight scheduledFlight, string @class) {
            var where = base.WhereClause.AndWhere("ScheduledFlightID", scheduledFlight.ScheduledFlightID)
                            .AndWhere("Class", @class);

            return base.TotalCount(where);
        }
    }
}

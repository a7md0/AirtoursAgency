namespace AirtoursBusinessObjects {
    public class ReservedSeatList : ModelListJoin<ReservedSeat> {
        public ReservedSeatList() : base() { }

        public int ReservedSeatsTotalCount(ScheduledFlight scheduledFlight, string @class) {
            var where = base.WhereClause.Where("ScheduledFlightID", scheduledFlight.ScheduledFlightID)
                            .Where("Class", @class);

            return base.TotalCount(where);
        }
    }
}

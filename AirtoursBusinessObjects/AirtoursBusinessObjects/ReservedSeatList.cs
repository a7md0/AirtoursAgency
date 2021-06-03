namespace AirtoursBusinessObjects {
    using Builder;

    public class ReservedSeatList : DataListJoin<ReservedSeat> {
        public ReservedSeatList() : base() { }

        public int ReservedSeatsTotalCount(ScheduledFlight scheduledFlight, string @class) {
            WhereClause where = base.WhereClause.Where("ScheduledFlightID", scheduledFlight.ScheduledFlightID)
                            .Where("Class", @class);

            return base.TotalCount(where);
        }
    }
}

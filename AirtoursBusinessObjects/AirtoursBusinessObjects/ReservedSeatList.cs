namespace AirtoursBusinessObjects {
    using Builder;

    public class ReservedSeatList : DataListJoin<ReservedSeat> {
        public ReservedSeatList() : base() { }

        /// <summary>
        /// Query the total count of reserved seats in given scheduled flight.
        /// </summary>
        /// <param name="scheduledFlight">Scheduled flight to match</param>
        /// <param name="class">Seat class (i.e. Economy or Business)</param>
        /// <returns></returns>
        public int ReservedSeatsTotalCount(ScheduledFlight scheduledFlight, string @class) {
            WhereClause where = base.WhereClause.Where("ScheduledFlightID", scheduledFlight.ScheduledFlightID)
                            .Where("Class", @class);

            return base.TotalCount(where); // Call the base total count, with the built where clause for conditions
        }
    }
}

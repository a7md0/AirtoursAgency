namespace AirtoursBusinessObjects {
    public class ReservationList : ModelList<Reservation> {
        public ReservationList() : base() { }

        public decimal ReservationsTotalPrice() {
            return base.TotalValue<decimal>("Price");
        }

        public decimal ReservationsTotalPrice(bool paid) {
            var where = base.WhereClause.AndWhere("Paid", paid);

            return base.TotalValue<decimal>("Price", where);
        }

        public decimal ReservationsTotalPrice(Customer customer) {
            var where = base.WhereClause.AndWhere("CustomerID", customer.GetId());

            return base.TotalValue<decimal>("Price", where);
        }

        public decimal ReservationsTotalPrice(Customer customer, bool paid) {
            var where = base.WhereClause.AndWhere("Paid", paid)
                                        .AndWhere("CustomerID", customer.GetId());

            return base.TotalValue<decimal>("Price", where);
        }

        public bool ReservationsFilter(Customer customer) {
            var where = base.WhereClause.AndWhere("CustomerID", customer.GetId());

            return base.Populate(where);
        }
    }
}

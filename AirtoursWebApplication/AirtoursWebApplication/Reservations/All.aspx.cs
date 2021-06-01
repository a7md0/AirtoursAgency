using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication.Reservations {
    public partial class All : System.Web.UI.Page {
        protected Customer customer;

        protected void Page_Load(object sender, EventArgs e) {
            this.customer = (Customer) this.Session["customer"];

            if (!Page.IsPostBack) {
                ReservationList reservationList = new ReservationList();

                var whereClause = reservationList.WhereClause;
                whereClause.Where("CustomerID", this.customer.CustomerID);

                reservationList.Populate(whereClause);

                this.ReservationsGridView.DataSource = reservationList.DataTable;
                this.ReservationsGridView.DataBind();
            }
        }

        protected void ReservationsGridView_SelectedIndexChanged(object sender, EventArgs e) {
            GridView gridView = (GridView) sender;
            GridViewRow selectedRow = gridView.SelectedRow;

            object reservationID = gridView.DataKeys[selectedRow.RowIndex]["ReservationID"];
            Response.Redirect($"/Reservations/View.aspx?reservationID={reservationID}&returnList={Uri.EscapeDataString(this.Request.Url.PathAndQuery)}", true);
        }
    }
}

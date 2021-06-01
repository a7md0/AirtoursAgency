using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;
using AirtoursBusinessObjects.Builder;

namespace AirtoursWebApplication.Reservations {
    public partial class Default : System.Web.UI.Page {
        protected Customer customer => this.Session["customer"] as Customer;

        protected void Page_Load(object sender, EventArgs e) {
            if (!Page.IsPostBack) {
                ReservationList reservationList = new ReservationList();
                reservationList.FilterFutureReservations(this.customer);

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

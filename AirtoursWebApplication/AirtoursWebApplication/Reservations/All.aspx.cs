using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication.Reservations {
    public partial class All : System.Web.UI.Page {
        protected Customer customer => this.Session["customer"] as Customer; // getter for the customer from the session

        protected void Page_Load(object sender, EventArgs e) {
            if (!Page.IsPostBack) {
                ReservationList reservationList = new ReservationList();
                reservationList.Populate("CustomerID", this.customer.CustomerID); // Populate all reservations of the current customer

                this.ReservationsGridView.DataSource = reservationList.DataTable; // Assign the query result to the grid view
                this.ReservationsGridView.DataBind(); // Bind the data
            }
        }

        protected void ReservationsGridView_SelectedIndexChanged(object sender, EventArgs e) {
            GridView gridView = sender as GridView; // Cast the sender
            GridViewRow selectedRow = gridView.SelectedRow; // The selected row from the grid

            object reservationID = gridView.DataKeys[selectedRow.RowIndex]["ReservationID"]; // Retrieve the reservation id from the data-keys of the grid
            Response.Redirect($"/Reservations/View.aspx?reservationID={reservationID}&returnList={Uri.EscapeDataString(this.Request.Url.PathAndQuery)}", true); // Redirect and add the res_id in the query string along with return list parameter to the current URL (and escaped)
        }
    }
}

using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication.Flights {
    public partial class Default : System.Web.UI.Page {
        private static FlightList flightList = new FlightList();

        protected void Page_Load(object sender, EventArgs e) {
            if (!Page.IsPostBack) {
                this.Session["Outward_FlightIdx"] = null;
                this.Session["Return_FlightIdx"] = null;

                List<string> origins = flightList.UniqueValues("Origin");

                this.OriginsDropDownList.DataSource = origins;
                this.OriginsDropDownList.DataBind();

                if (this.DepartureDateTextBox.Text == "") {
                    this.DepartureDateTextBox.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    this.ReturnDateTextBox.Text = DateTime.Now.AddDays(14).ToString("yyyy-MM-dd");
                }
            }

            var whereClause = flightList.WhereClause;
            whereClause.Where("Origin", this.OriginsDropDownList.SelectedValue);
            List<string> destinations = flightList.UniqueValues("Destination", whereClause);

            this.DestinationsDropDownList.DataSource = destinations;
            this.DestinationsDropDownList.DataBind();

            this.ControlsVisiblity();
        }

        protected void ControlsVisiblity() {
            bool showBookReturnFlight = this.BookReturnFlight.Checked;

            this.ReturnDateSection.Visible = showBookReturnFlight;
        }

        protected void SearchButton_Click(object sender, EventArgs e) {
            if (this.DepartureDateTextBox.Text == string.Empty) {
                return;
            }

            if (this.BookReturnFlight.Checked == true && this.ReturnDateTextBox.Text == string.Empty) {
                return;
            }

            string origin = this.OriginsDropDownList.SelectedValue;
            string destination = this.DestinationsDropDownList.SelectedValue;

            string departureDate = this.DepartureDateTextBox.Text;
            string returnDate = this.ReturnDateTextBox.Text;

            string route = $"Choose.aspx?origin={origin}&destination={destination}&departureDate={departureDate}";

            if (this.BookReturnFlight.Checked == true) {
                route += $"&returnDate={returnDate}";
            }

            Response.Redirect(route, endResponse: true);
        }
    }
}

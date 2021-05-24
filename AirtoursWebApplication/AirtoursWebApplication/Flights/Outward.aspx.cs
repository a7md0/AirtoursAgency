using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication.Flights {
    public partial class Outward : System.Web.UI.Page {
        private static FlightList flightList = new FlightList();

        protected void Page_Load(object sender, EventArgs e) {
            if (!Page.IsPostBack) {
                List<string> origins = flightList.UniqueValues("Origin");
                List<string> destinations = flightList.UniqueValues("Destination");

                this.OriginsDropDownList.DataSource = origins;
                this.OriginsDropDownList.DataBind();

                this.DestinationsDropDownList.DataSource = destinations;
                this.DestinationsDropDownList.DataBind();
            }
        }

        protected void SearchButton_Click(object sender, EventArgs e) {
            string origin = this.OriginsDropDownList.SelectedValue;
            string destination = this.DestinationsDropDownList.SelectedValue;
            DateTime departure = DateTime.ParseExact(this.DepartureDateTextBox.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            flightList.FlightsFilter(origin, destination, departure);

            this.ResultsGridView.DataSource = flightList.DataTable;
            this.ResultsGridView.DataBind();
        }
    }
}

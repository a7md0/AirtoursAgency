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
                List<string> origins = flightList.UniqueValues("Origin");
                // List<string> destinations = flightList.UniqueValues("Destination");

                /*var whereClause = flightList.WhereClause;
                whereClause.WhereIn("Origin", origins.ToArray());
                List<string> destinations = flightList.UniqueValues("Destination", whereClause);*/

                this.OriginsDropDownList.DataSource = origins;
                this.OriginsDropDownList.DataBind();

                //this.DestinationsDropDownList.DataSource = destinations;
                //this.DestinationsDropDownList.DataBind();

                /*this.ReturnOriginDropDownList.DataSource = origins;
                this.ReturnOriginDropDownList.DataBind();

                this.ReturnDestinationDropDownList.DataSource = destinations;
                this.ReturnDestinationDropDownList.DataBind();*/

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


            /*this.ReturnFlightControls.Visible = showBookReturnFlight;

            this.ReturnOriginDropDownList.SelectedValue = this.DestinationsDropDownList.SelectedValue;
            this.ReturnDestinationDropDownList.SelectedValue = this.OriginsDropDownList.SelectedValue;*/
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

            /* if (this.DepartureDateTextBox.Text == string.Empty) {
                return;
            }

            string origin = this.OriginsDropDownList.SelectedValue;
            string destination = this.DestinationsDropDownList.SelectedValue;
            DateTime departureDate = DateTime.ParseExact(this.DepartureDateTextBox.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            flightList.FlightsFilter(origin, destination, departureDate);

            DataTable outwardDataTable = flightList.DataTable.Copy();

           this.OutwardFlightsGridView.DataSource = outwardDataTable;
            this.OutwardFlightsGridView.DataBind();

            if (this.ReturnDateTextBox.Text != string.Empty) {
                DateTime returnDate = DateTime.ParseExact(this.ReturnDateTextBox.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);

                bool found = flightList.FlightsFilter(destination, origin, returnDate);

                DataTable returnDataTable = flightList.DataTable.Copy();

                this.ReturnFlightsGridView.DataSource = returnDataTable;
                this.ReturnFlightsGridView.DataBind();
            }*/
        }

        protected void ReserveFlightsButton_Click(object sender, EventArgs e) {
            /*int? outwardFlightId = this.GetValueFromCheckedRow(this.OutwardFlightsGridView, 1);
            int? returnFlightId = this.GetValueFromCheckedRow(this.ReturnFlightsGridView, 1);

            if (!outwardFlightId.HasValue) {
                Response.Write("Please select a flight");
                return;
            }

            string redirectURL = $"/Reservations/New.aspx?outwardFlight={outwardFlightId.Value}";

            if (returnFlightId.HasValue) {
                redirectURL += $"&returnFlight={returnFlightId.Value}";
            }

            Response.Redirect(redirectURL);*/
        }

        protected int? GetValueFromCheckedRow(GridView gv, int cellIdx) {
            int? flightID = null;

            foreach (GridViewRow row in gv.Rows) {
                var selectedCtrl = (CheckBox) row.FindControl("Selected");

                if (selectedCtrl.Checked) {
                    flightID = int.Parse(row.Cells[cellIdx].Text);
                    break;
                }
            }

            return flightID;
        }
    }
}

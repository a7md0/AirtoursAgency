using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication.Flights {
    public partial class Default : System.Web.UI.Page {
        protected string origin;
        protected string destination;

        protected static FlightList flightList = new FlightList();
        protected static ScheduledFlightList scheduledFlightList = new ScheduledFlightList();

        protected void Page_Load(object sender, EventArgs e) {
            if (!Page.IsPostBack) {
                this.ViewState["Outward_FlightIdx"] = null;
                this.ViewState["Return_FlightIdx"] = null;

                this.Session["Outward_ScheduledFlight"] = null;
                this.Session["Return_ScheduledFlight"] = null;

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

            this.origin = this.OriginsDropDownList.SelectedValue;
            this.destination = this.DestinationsDropDownList.SelectedValue;
        }

        protected void ControlsVisiblity() {
            bool showBookReturnFlight = this.BookReturnFlight.Checked;

            this.ReturnDateSection.Visible = showBookReturnFlight;
        }

        protected void SearchButton_Click(object sender, EventArgs e) {
            DateTime departureDate;
            DateTime returnDate = DateTime.MinValue;

            bool validDepartureDate = DateTime.TryParseExact(
                s: this.DepartureDateTextBox.Text,
                format: "yyyy-MM-dd",
                provider: CultureInfo.InvariantCulture,
                style: DateTimeStyles.AssumeUniversal,
                result: out departureDate
            );

            if (!validDepartureDate) {
                Response.Write("Invalid departure date was entered");
                return;
            }

            if (this.BookReturnFlight.Checked == true) {
                bool validReturnDate = DateTime.TryParseExact(
                    s: this.ReturnDateTextBox.Text,
                    format: "yyyy-MM-dd",
                    provider: CultureInfo.InvariantCulture,
                    style: DateTimeStyles.AssumeUniversal,
                    result: out returnDate
                );

                if (!validReturnDate) {
                    Response.Write("Invalid departure date was entered");
                    return;
                }
            }

            this.ChooseFlightSection.Visible = true;
            this.PopulateControl(departureDate, returnDate);
        }

        /***************************************************/

        protected void PopulateControl(DateTime departureDate, DateTime returnDate) {
            flightList.FlightsFilter(origin, destination, departureDate);

            this.OutwardFlightsGridView.DataSource = flightList.DataTable.Copy();
            this.OutwardFlightsGridView.DataBind();
            this.OutwardFlightsGridView.Caption = $"Outward flights ({this.DepartureDateTextBox.Text})";

            if (this.BookReturnFlight.Checked) {
                flightList.FlightsFilter(destination, origin, returnDate);

                this.ReturnFlightsGridView.DataSource = flightList.DataTable.Copy();
                this.ReturnFlightsGridView.DataBind();
                this.ReturnFlightsGridView.Caption = $"Return flights ({this.ReturnDateTextBox.Text})";
            }
        }

        protected void OutwardFlightsGridView_SelectedIndexChanged(object sender, EventArgs e) {
            GridView gridView = (GridView) sender;
            GridViewRow selectedRow = gridView.SelectedRow;

            object flightID = gridView.DataKeys[selectedRow.RowIndex]["FlightID"];
            DateTime flightDate = DateTime.ParseExact(this.DepartureDateTextBox.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            ScheduledFlight scheduledFlight = this.FindScheduledFlight(flightID, flightDate);

            if (scheduledFlight is null == false) {
                this.ViewState["Outward_FlightIdx"] = selectedRow.RowIndex;
                this.Session["Outward_ScheduledFlight"] = scheduledFlight;
            }
        }

        protected void ReturnFlightsGridView_SelectedIndexChanged(object sender, EventArgs e) {
            GridView gridView = (GridView) sender;
            GridViewRow selectedRow = gridView.SelectedRow;

            object flightID = gridView.DataKeys[selectedRow.RowIndex]["FlightID"];
            DateTime flightDate = DateTime.ParseExact(this.ReturnDateTextBox.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            ScheduledFlight scheduledFlight = this.FindScheduledFlight(flightID, flightDate);

            if (scheduledFlight is null == false) {
                this.ViewState["Return_FlightIdx"] = selectedRow.RowIndex;
                this.Session["Return_ScheduledFlight"] = scheduledFlight;
            }
        }

        protected void ReserveFlightsButton_Click(object sender, EventArgs e) {
            if (this.Session["Outward_ScheduledFlight"] == null) {
                Response.Write("Please select a flight");
                return;
            }

            Response.Redirect("/Reservations/Create");
        }

        protected ScheduledFlight FindScheduledFlight(object flightID, DateTime flightDate) {
            AirtoursBusinessObjects.Builder.WhereClause whereClause = scheduledFlightList.WhereClause;
            whereClause.Where("FlightID", flightID).WhereDate("FlightDate", flightDate);

            return scheduledFlightList.FindOne(whereClause);
        }

        protected void Page_LoadComplete(object sender, EventArgs e) {
            if (this.ViewState["Outward_FlightIdx"] is null == false) {
                int idx = (int) this.ViewState["Outward_FlightIdx"];

                foreach (GridViewRow row in this.OutwardFlightsGridView.Rows) {
                    this.OutwardFlightsGridView.Rows[row.RowIndex].BackColor = row.RowIndex == idx ? Color.Cyan : Color.Transparent;
                }
            }

            if (this.ViewState["Return_FlightIdx"] is null == false) {
                int idx = (int) this.ViewState["Return_FlightIdx"];

                foreach (GridViewRow row in this.ReturnFlightsGridView.Rows) {
                    this.ReturnFlightsGridView.Rows[row.RowIndex].BackColor = row.RowIndex == idx ? Color.Cyan : Color.Transparent;
                }
            }
        }
    }
}

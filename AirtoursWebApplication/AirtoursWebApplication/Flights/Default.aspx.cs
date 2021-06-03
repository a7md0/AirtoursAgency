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
        protected static FlightList flightList = new FlightList();
        protected static ScheduledFlightList scheduledFlightList = new ScheduledFlightList();

        protected string origin {
            get => this.OriginsDropDownList.SelectedValue;
            set => this.OriginsDropDownList.SelectedValue = value;
        }
        protected string destination {
            get => this.DestinationsDropDownList.SelectedValue;
            set => this.DestinationsDropDownList.SelectedValue = value;
        }

        protected DateTime departureDate {
            get => (DateTime) this.ViewState["departureDate"];
            set => this.ViewState["departureDate"] = value;
        }
        protected DateTime returnDate {
            get => (DateTime) this.ViewState["returnDate"];
            set => this.ViewState["returnDate"] = value;
        }

        protected int? outwardFlightIdx {
            get => this.ViewState["outwardFlightIdx"] as int?;
            set => this.ViewState["outwardFlightIdx"] = value;
        }

        protected int? returnFlightIdx {
            get => this.ViewState["returnFlightIdx"] as int?;
            set => this.ViewState["returnFlightIdx"] = value;
        }

        protected ScheduledFlight outwardScheduledFlight {
            get => this.Session["outwardScheduledFlight"] as ScheduledFlight;
            set => this.Session["outwardScheduledFlight"] = value;
        }

        protected ScheduledFlight returnScheduledFlight {
            get => this.Session["returnScheduledFlight"] as ScheduledFlight;
            set => this.Session["returnScheduledFlight"] = value;
        }

        protected void Page_Load(object sender, EventArgs e) {
            if (!Page.IsPostBack) {
                /// Reset selected flights ///
                this.outwardFlightIdx = null;
                this.returnFlightIdx = null;

                this.outwardScheduledFlight = null;
                this.returnScheduledFlight = null;
                /////////////////////////////

                List<string> origins = flightList.UniqueValues("Origin"); // Query unique origins list as string

                this.OriginsDropDownList.DataSource = origins; // Set the origins drop down to the list
                this.OriginsDropDownList.DataBind(); // Bind the data

                if (this.DepartureDateTextBox.Text == "") { // If the dep date is empty
                    this.DepartureDateTextBox.Text = DateTime.Now.ToString("yyyy-MM-dd"); // Dep date default to today date
                    this.ReturnDateTextBox.Text = DateTime.Now.AddDays(14).ToString("yyyy-MM-dd"); // Return date to today + 2 weeks
                }
            }

            this.OnOriginChanged(); // Call the origin changed to update the available destination list
            this.ControlsVisibility();
        }

        // Hide and show controls conditionally
        protected void ControlsVisibility() {
            bool showBookReturnFlight = this.BookReturnFlight.Checked;

            this.ReturnDateSection.Visible = showBookReturnFlight;
        }

        /// <summary>
        /// Populate the destination list based on gived origin
        /// </summary>
        protected void OnOriginChanged() {
            var whereClause = flightList.WhereClause;
            whereClause.Where("Origin", this.origin);

            List<string> destinations = flightList.UniqueValues("Destination", whereClause);

            this.DestinationsDropDownList.DataSource = destinations;
            this.DestinationsDropDownList.DataBind();
        }

        /// <summary>
        /// Event on origins drop down list has changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OriginsDropDownList_SelectedIndexChanged(object sender, EventArgs e) {
            this.OnOriginChanged();
        }

        /// <summary>
        /// Event on destinations drop down list has changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void DestinationsDropDownList_SelectedIndexChanged(object sender, EventArgs e) {

        }

        /// <summary>
        /// Parse input date with given format
        /// </summary>
        /// <param name="dateStr"></param>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        protected bool TryParseInputDate(string dateStr, out DateTime dateTime) {
            return DateTime.TryParseExact(
                s: dateStr,
                format: "yyyy-MM-dd",
                provider: CultureInfo.InvariantCulture,
                style: DateTimeStyles.AssumeUniversal,
                result: out dateTime
            );
        }

        /// <summary>
        /// Event on search button is clicked
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void SearchButton_Click(object sender, EventArgs e) {
            DateTime departureDate;
            DateTime returnDate = DateTime.MinValue;

            // Try parse the DateTime with given format
            bool validDepartureDate = this.TryParseInputDate(this.DepartureDateTextBox.Text, out departureDate);

            if (!validDepartureDate) {
                Response.Write("<script defer>alert(\"Invalid departure date was entered\");</script>");
                return;
            }

            if (this.BookReturnFlight.Checked == true) {
                bool validReturnDate = this.TryParseInputDate(this.ReturnDateTextBox.Text, out returnDate);

                if (!validReturnDate) {
                    Response.Write("<script defer>alert(\"Invalid departure date was entered\");</script>");
                    return;
                }
            }

            this.departureDate = departureDate; // Set the dep date for later usage
            this.returnDate = returnDate; // Set the return date for later usage

            /// Reset the selected flights ///
            this.outwardFlightIdx = null;
            this.returnFlightIdx = null;

            this.outwardScheduledFlight = null;
            this.returnScheduledFlight = null;
            //////////////////////////////////

            this.ChooseFlightSection.Visible = true; // Show the flights section
            this.PopulateResultsControl(); // Populate the grids view with flights
        }

        /***************************************************/

        /// <summary>
        /// Populate results of the query (origin/dest/dep date/return date)
        /// </summary>
        protected void PopulateResultsControl() {
            FlightList flightList = new FlightList();
            flightList.FlightsFilter(this.origin, this.destination, this.departureDate);

            this.OutwardFlightsGridView.DataSource = flightList.DataTable.Copy();
            this.OutwardFlightsGridView.DataBind();
            this.OutwardFlightsGridView.Caption = $"Outward flights ({this.DepartureDateTextBox.Text})";

            if (this.BookReturnFlight.Checked) {
                flightList.FlightsFilter(this.destination, this.origin, this.returnDate);

                this.ReturnFlightsGridView.DataSource = flightList.DataTable.Copy();
                this.ReturnFlightsGridView.DataBind();
                this.ReturnFlightsGridView.Caption = $"Return flights ({this.ReturnDateTextBox.Text})";
            }
        }

        protected void OutwardFlightsGridView_SelectedIndexChanged(object sender, EventArgs e) {
            GridView gridView = (GridView) sender;
            GridViewRow selectedRow = gridView.SelectedRow;

            object flightID = gridView.DataKeys[selectedRow.RowIndex]["FlightID"];

            ScheduledFlight scheduledFlight = this.FindScheduledFlight(flightID, this.departureDate);

            if (scheduledFlight is null == false) {
                this.outwardFlightIdx = selectedRow.RowIndex;
                this.outwardScheduledFlight = scheduledFlight;
            }
        }

        protected void ReturnFlightsGridView_SelectedIndexChanged(object sender, EventArgs e) {
            GridView gridView = (GridView) sender;
            GridViewRow selectedRow = gridView.SelectedRow;

            object flightID = gridView.DataKeys[selectedRow.RowIndex]["FlightID"];

            ScheduledFlight scheduledFlight = this.FindScheduledFlight(flightID, this.returnDate);

            if (scheduledFlight is null == false) {
                this.returnFlightIdx = selectedRow.RowIndex;
                this.returnScheduledFlight = scheduledFlight;
            }
        }

        protected void ReserveFlightsButton_Click(object sender, EventArgs e) {
            if (this.outwardScheduledFlight == null) {
                Response.Write("<script defer>alert(\"Please select a flight\");</script>");
                return;
            }

            this.Response.Redirect("/Reservations/Create");
        }

        protected ScheduledFlight FindScheduledFlight(object flightID, DateTime flightDate) {
            AirtoursBusinessObjects.Builder.WhereClause whereClause = scheduledFlightList.WhereClause;
            whereClause.Where("FlightID", flightID).WhereDate("FlightDate", flightDate);

            return scheduledFlightList.FindOne(whereClause);
        }

        protected void Page_LoadComplete(object sender, EventArgs e) {
            foreach (GridViewRow row in this.OutwardFlightsGridView.Rows) {
                row.BackColor = Color.Transparent;

                if (this.outwardFlightIdx.HasValue && row.RowIndex == this.outwardFlightIdx.Value) {
                    row.BackColor = Color.Cyan;
                }
            }

            foreach (GridViewRow row in this.ReturnFlightsGridView.Rows) {
                row.BackColor = Color.Transparent;

                if (this.returnFlightIdx.HasValue && row.RowIndex == this.returnFlightIdx.Value) {
                    row.BackColor = Color.Cyan;
                }
            }
        }
    }
}

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
    public partial class Choose : System.Web.UI.Page {
        protected string origin;
        protected string destination;

        protected string departureString;
        protected DateTime departureDate;

        protected string returnString;
        protected DateTime returnDate;

        protected static FlightList flightList = new FlightList();
        protected static ScheduledFlightList scheduledFlightList = new ScheduledFlightList();

        protected void Page_Load(object sender, EventArgs e) {
            this.origin = this.Request.Params["origin"];
            this.destination = this.Request.Params["destination"];

            this.departureString = this.Request.Params["departureDate"];
            this.returnString = this.Request.Params["returnDate"];

            this.PopulateControl();
        }



        protected void PopulateControl() {
            this.departureDate = DateTime.ParseExact(this.departureString, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            flightList.FlightsFilter(origin, destination, departureDate);

            this.OutwardFlightsGridView.DataSource = flightList.DataTable.Copy();
            this.OutwardFlightsGridView.DataBind();
            this.OutwardFlightsGridView.Caption = $"Outward flights ({this.departureString})";

            if (this.returnString != string.Empty && this.returnString != null) {
                this.returnDate = DateTime.ParseExact(this.returnString, "yyyy-MM-dd", CultureInfo.InvariantCulture);

                flightList.FlightsFilter(destination, origin, returnDate);

                this.ReturnFlightsGridView.DataSource = flightList.DataTable.Copy();
                this.ReturnFlightsGridView.DataBind();
                this.ReturnFlightsGridView.Caption = $"Return flights ({this.returnString})";
            }
        }

        protected void OutwardFlightsGridView_SelectedIndexChanged(object sender, EventArgs e) {
            GridView gridView = (GridView) sender;
            GridViewRow selectedRow = gridView.SelectedRow;

            object flightID = gridView.DataKeys[selectedRow.RowIndex]["FlightID"];
            DateTime flightDate = this.departureDate;

            ScheduledFlight scheduledFlight = this.FindScheduledFlight(flightID, flightDate);

            if (scheduledFlight is null == false) { 
                Session["Outward_FlightIdx"] = selectedRow.RowIndex;
                Session["Outward_FlightID"] = flightID;
                Session["Outward_ScheduledFlightID"] = scheduledFlight.ScheduledFlightID;
                Session["Outward_FlightDate"] = scheduledFlight.FlightDate;
            }
        }

        protected void ReturnFlightsGridView_SelectedIndexChanged(object sender, EventArgs e) {
            GridView gridView = (GridView) sender;
            GridViewRow selectedRow = gridView.SelectedRow;

            object flightID = gridView.DataKeys[selectedRow.RowIndex]["FlightID"];
            DateTime flightDate = this.returnDate;

            ScheduledFlight scheduledFlight = this.FindScheduledFlight(flightID, flightDate);

            if (scheduledFlight is null == false) {
                Session["Return_FlightIdx"] = selectedRow.RowIndex;
                Session["Return_FlightID"] = flightID;
                Session["Return_ScheduledFlightID"] = scheduledFlight.ScheduledFlightID;
                Session["Return_FlightDate"] = scheduledFlight.FlightDate;
            }
        }

        protected void ReserveFlightsButton_Click(object sender, EventArgs e) {
            object outwardFlightId = Session["Outward_FlightID"];
            object returnFlightId = Session["Return_FlightID"];

            if (outwardFlightId == null) {
                Response.Write("Please select a flight");
                return;
            }

            Response.Redirect("/Reservations/New.aspx");
        }


        protected ScheduledFlight FindScheduledFlight(object flightID, DateTime flightDate) {
            AirtoursBusinessObjects.Builder.WhereClause whereClause = scheduledFlightList.WhereClause;
            whereClause.Where("FlightID", flightID).WhereDate("FlightDate", flightDate);

            return scheduledFlightList.FindOne(whereClause);
        }

        protected void Page_LoadComplete(object sender, EventArgs e) {

            if (Session["Outward_FlightIdx"] != null) {
                int idx = (int) Session["Outward_FlightIdx"];
                this.OutwardFlightsGridView.Rows[idx].BackColor = Color.Cyan;
            }

            if (Session["Return_FlightIdx"] != null) {
                int idx = (int) Session["Return_FlightIdx"];
                this.ReturnFlightsGridView.Rows[idx].BackColor = Color.Cyan;
            }
        }
    }
}

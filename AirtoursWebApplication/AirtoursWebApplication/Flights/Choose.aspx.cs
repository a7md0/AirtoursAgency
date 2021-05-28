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

        protected string departureDate;
        protected string returnDate;

        protected static FlightList flightList = new FlightList();

        protected void Page_Load(object sender, EventArgs e) {
            this.origin = this.Request.Params["origin"];
            this.destination = this.Request.Params["destination"];

            this.departureDate = this.Request.Params["departureDate"];
            this.returnDate = this.Request.Params["returnDate"];

            this.PopulateControl();
        }

        protected void PopulateControl() {
            DateTime departureDate = DateTime.ParseExact(this.departureDate, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            flightList.FlightsFilter(origin, destination, departureDate);

            this.OutwardFlightsGridView.DataSource = this.GenerateTableForFlight(flightList.List);
            this.OutwardFlightsGridView.DataBind();
            this.OutwardFlightsGridView.Caption = $"Outward flights ({this.departureDate})";

            if (this.returnDate != string.Empty && this.returnDate != null) {
                DateTime returnDate = DateTime.ParseExact(this.returnDate, "yyyy-MM-dd", CultureInfo.InvariantCulture);

                flightList.FlightsFilter(destination, origin, returnDate);

                this.ReturnFlightsGridView.DataSource = this.GenerateTableForFlight(flightList.List);
                this.ReturnFlightsGridView.DataBind();
                this.ReturnFlightsGridView.Caption = $"Return flights ({this.returnDate})";
            }

            if (Session["Outward_FlightIdx"] != null) {
                int idx = (int) Session["Outward_FlightIdx"];
                this.OutwardFlightsGridView.Rows[idx].BackColor = Color.Cyan;
            }

            if (Session["Return_FlightIdx"] != null) {
                int idx = (int) Session["Return_FlightIdx"];
                this.ReturnFlightsGridView.Rows[idx].BackColor = Color.Cyan;
            }
        }

        protected DataTable GenerateTableForFlight(List<Flight> flights) {
            DataTable dataTable = new DataTable();

            dataTable.Columns.Add(new DataColumn("Flight ID", typeof(int)));
            dataTable.Columns.Add(new DataColumn("Flight Number", typeof(string)));
            dataTable.Columns.Add(new DataColumn("Origin", typeof(string)));
            dataTable.Columns.Add(new DataColumn("Destination", typeof(string)));
            dataTable.Columns.Add(new DataColumn("Departure Time", typeof(string)));
            dataTable.Columns.Add(new DataColumn("Arrival Time", typeof(string)));
            dataTable.Columns.Add(new DataColumn("Airline", typeof(string)));
            dataTable.Columns.Add(new DataColumn("Fare", typeof(string)));

            foreach (Flight flight in flights) {
                DataRow row = dataTable.NewRow();

                row["Flight ID"] = flight.FlightID;
                row["Flight Number"] = flight.FlightNumber;
                row["Origin"] = flight.Origin;
                row["Destination"] = flight.Destination;
                row["Departure Time"] = flight.Departure?.ToShortTimeString() ?? "";
                row["Arrival Time"] = flight.Arrival?.ToShortTimeString() ?? "";
                row["Airline"] = flight.Airline;
                row["Fare"] = $"${flight.Fare?.ToString("0.00")}";

                dataTable.Rows.Add(row);
            }

            return dataTable;
        }

        protected void OutwardFlightsGridView_SelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow selectedRow = this.OutwardFlightsGridView.SelectedRow;

            Session["Outward_FlightIdx"] = selectedRow.RowIndex;
            Session["Outward_FlightID"] = int.Parse(selectedRow.Cells[1].Text);
            /*Session["Outward_FlightNumber"] = selectedRow.Cells[2].Text;
            Session["Outward_FlightAirline"] = selectedRow.Cells[7].Text;
            Session["Outward_FlightOrigin"] = selectedRow.Cells[3].Text;
            Session["Outward_FlightDestination"] = selectedRow.Cells[4].Text;
            Session["Outward_FlightDate"] = null;
            Session["Outward_FlightDepartureTime"] = selectedRow.Cells[5].Text;
            Session["Outward_FlightArrivalTime"] = selectedRow.Cells[6].Text;*/

            selectedRow.BackColor = Color.Cyan;
        }

        protected void ReturnFlightsGridView_SelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow selectedRow = this.ReturnFlightsGridView.SelectedRow;

            Session["Return_FlightIdx"] = selectedRow.RowIndex;
            Session["Return_FlightID"] = int.Parse(selectedRow.Cells[1].Text);
            /*Session["Return_FlightNumber"] = selectedRow.Cells[7].Text;
            Session["Return_FlightAirline"] = selectedRow.Cells[2].Text;
            Session["Return_FlightOrigin"] = selectedRow.Cells[3].Text;
            Session["Return_FlightDestination"] = selectedRow.Cells[4].Text;
            Session["Return_FlightDate"] = null;
            Session["Return_FlightDepartureTime"] = selectedRow.Cells[5].Text;
            Session["Return_FlightArrivalTime"] = selectedRow.Cells[6].Text;*/

            selectedRow.BackColor = Color.Cyan;
        }

        protected void ReserveFlightsButton_Click(object sender, EventArgs e) {
            int? outwardFlightId = this.GetValueFromCheckedRow(this.OutwardFlightsGridView, "Outward", 1);
            int? returnFlightId = this.GetValueFromCheckedRow(this.ReturnFlightsGridView, "Return", 1);

            if (!outwardFlightId.HasValue) {
                Response.Write("Please select a flight");
                return;
            }

            string redirectURL = $"/Reservations/New.aspx?outwardFlight={outwardFlightId.Value}";

            if (returnFlightId.HasValue) {
                redirectURL += $"&returnFlight={returnFlightId.Value}";
            }

            Response.Redirect(redirectURL);
        }

        private int? GetValueFromCheckedRow(GridView gv, string sessionPrefix, int cellIdx) {

            int? flightID = null;

            if (Session[$"{sessionPrefix}_FlightIdx"] != null) {
                int idx = (int) Session[$"{sessionPrefix}_FlightIdx"];

                flightID = int.Parse(gv.Rows[idx].Cells[cellIdx].Text);
            }

            return flightID;
        }
    }
}

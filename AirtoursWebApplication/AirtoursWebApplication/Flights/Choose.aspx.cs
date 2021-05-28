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

        private void PopulateControl() {
            DateTime departureDate = DateTime.ParseExact(this.departureDate, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            flightList.FlightsFilter(origin, destination, departureDate);

            DataTable outwardDataTable = flightList.DataTable.Copy();

            this.OutwardFlightsGridView.DataSource = outwardDataTable;
            this.OutwardFlightsGridView.DataBind();

            if (this.returnDate != string.Empty && this.returnDate != null) {
                DateTime returnDate = DateTime.ParseExact(this.returnDate, "yyyy-MM-dd", CultureInfo.InvariantCulture);

                bool found = flightList.FlightsFilter(destination, origin, returnDate);

                DataTable returnDataTable = flightList.DataTable.Copy();

                this.ReturnFlightsGridView.DataSource = returnDataTable;
                this.ReturnFlightsGridView.DataBind();
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

        protected void OutwardFlightsGridView_SelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow selectedRow = this.OutwardFlightsGridView.SelectedRow;

            Session["Outward_FlightIdx"] = selectedRow.RowIndex;
            Session["Outward_FlightID"] = int.Parse(selectedRow.Cells[1].Text);
            Session["Outward_FlightNumber"] = selectedRow.Cells[7].Text;
            Session["Outward_FlightAirline"] = selectedRow.Cells[2].Text;
            Session["Outward_FlightOrigin"] = selectedRow.Cells[3].Text;
            Session["Outward_FlightDestination"] = selectedRow.Cells[4].Text;
            Session["Outward_FlightDate"] = null;
            Session["Outward_FlightDepartureTime"] = selectedRow.Cells[5].Text;
            Session["Outward_FlightArrivalTime"] = selectedRow.Cells[6].Text;

            selectedRow.BackColor = Color.Cyan;
        }

        protected void ReturnFlightsGridView_SelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow selectedRow = this.ReturnFlightsGridView.SelectedRow;

            Session["Return_FlightIdx"] = selectedRow.RowIndex;
            Session["Return_FlightID"] = int.Parse(selectedRow.Cells[1].Text);
            Session["Return_FlightNumber"] = selectedRow.Cells[7].Text;
            Session["Return_FlightAirline"] = selectedRow.Cells[2].Text;
            Session["Return_FlightOrigin"] = selectedRow.Cells[3].Text;
            Session["Return_FlightDestination"] = selectedRow.Cells[4].Text;
            Session["Return_FlightDate"] = null;
            Session["Return_FlightDepartureTime"] = selectedRow.Cells[5].Text;
            Session["Return_FlightArrivalTime"] = selectedRow.Cells[6].Text;

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

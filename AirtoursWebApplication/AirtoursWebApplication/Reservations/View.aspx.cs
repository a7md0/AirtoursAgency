using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;
using AirtoursBusinessObjects.Builder;

namespace AirtoursWebApplication.Reservations {
    public partial class View : System.Web.UI.Page {
        protected static ReservationList reservationList = new ReservationList();
        protected static FlightList flightList = new FlightList();
        protected static ScheduledFlightList scheduledFlightList = new ScheduledFlightList();

        protected Customer customer;

        protected string reservationID;
        protected Reservation reservation;

        /****************************************************/
        protected Flight outwardFlight;
        protected ScheduledFlight outwardScheduledFlight;

        protected Flight returnFlight;
        protected ScheduledFlight returnScheduledFlight;
        /****************************************************/

        protected void Page_Load(object sender, EventArgs e) {
            this.customer = (Customer) this.Session["customer"];
            this.reservationID = this.Request.QueryString["reservationID"];

            if (!Page.IsPostBack) {
                var whereClause = reservationList.WhereClause;
                whereClause.Where("CustomerID", this.customer.CustomerID);
                whereClause.Where("ReservationID", this.reservationID);

                this.reservation = reservationList.FindOne(whereClause);

                if (this.reservation is null == false) {
                    this.PopulateReservationLabels(reservation);
                    int passengerID = this.FindAndPopulatePassengers(this.reservation);

                    if (passengerID > 0) {
                        this.FindFlights(passengerID);

                        this.PopulateOutwardFlight();
                        this.PopulateReturnFlight();
                    }
                } else {
                    this.Response.Redirect("/", true);
                }

                this.ControlVisiblity();
            }
        }

        private void ControlVisiblity() {
            // Only if this reservation flights are in the future (both Outward and Return flights)
            if (this.outwardScheduledFlight?.FlightDate >= DateTime.Now && this.returnScheduledFlight?.FlightDate >= DateTime.Now) {
                this.EditReservationButton.Visible = true; // Show the edit button
                this.DeleteReservationButton.Visible = true; // Show the delete button
            } else {
                this.EditDeleteLabel.Text = "This reservation cannot be edited or deleted anymore. The flight date have already passed the allowed period.";
                this.EditDeleteLabel.Visible = true;
                this.EditDeleteLabel.ForeColor = Color.Red;
            }

            if (this.Request.QueryString["returnList"] == null) { // If there is no returnList paramter in the query string
                this.BackButton.Visible = false; // Hide the back button
            }
        }

        protected void PopulateReservationLabels(Reservation reservation) {
            this.ReservationDateLabel.Text = reservation.ReservationDate?.ToLongDateString() ?? "-"; // Set the reservation date
            this.ReservationTotalLabel.Text = string.Format("{0:C}", reservation.Price ?? 0m); // Format currency
            this.ReservationPaidLabel.Text = (reservation?.Paid ?? false) ? "Yes" : "No"; // Set the paid label to Yes, No
        }

        // Find all passengers tied to this reservation and return first passenger id
        protected int FindAndPopulatePassengers(Reservation reservation) {
            PassengerList passengerList = new PassengerList();
            passengerList.Populate("ReservationID", reservation.ReservationID);

            this.PassengersGridView.DataSource = passengerList.DataTable;
            this.PassengersGridView.DataBind();

            if (passengerList.List.Count > 0) {
                return passengerList.List[0].PassengerID;
            }

            return 0;
        }

        /// <summary>
        /// Populate the outward flight labels
        /// </summary>
        protected void PopulateOutwardFlight() {
            if (outwardFlight is null == false && outwardScheduledFlight is null == false) {
                this.OutwardFlightNumberLabel.Text = this.outwardFlight.FlightNumber;
                this.OutwardFlightAirlineLabel.Text = this.outwardFlight.Airline;

                this.OutwardFlightOriginLabel.Text = this.outwardFlight.Origin;
                this.OutwardFlightDestinationLabel.Text = this.outwardFlight.Destination;

                this.OutwardFlightDepartureLabel.Text = this.outwardFlight.Departure?.ToShortTimeString();
                this.OutwardFlightArrivalLabel.Text = this.outwardFlight.Arrival?.ToShortTimeString();

                this.OutwardFlightDateLabel.Text = this.outwardScheduledFlight.FlightDate?.ToLongDateString();
                this.OutwardFlightFareLabel.Text = string.Format("{0:C}", this.outwardFlight.Fare ?? 0m);
            }
        }

        /// <summary>
        /// Populate the return flight labels (if there's any)
        /// </summary>
        protected void PopulateReturnFlight() {

            if (returnFlight is null == false && returnScheduledFlight is null == false) {
                this.ReturnFlightNumberLabel.Text = this.returnFlight.FlightNumber;
                this.ReturnFlightAirlineLabel.Text = this.returnFlight.Airline;

                this.ReturnFlightOriginLabel.Text = this.returnFlight.Origin;
                this.ReturnFlightDestinationLabel.Text = this.returnFlight.Destination;

                this.ReturnFlightDepartureLabel.Text = this.returnFlight.Departure?.ToShortTimeString();
                this.ReturnFlightArrivalLabel.Text = this.returnFlight.Arrival?.ToShortTimeString();

                this.ReturnFlightDateLabel.Text = this.returnScheduledFlight.FlightDate?.ToLongDateString();
                this.ReturnFlightFareLabel.Text = string.Format("{0:C}", this.returnFlight.Fare ?? 0m);

                this.ReturnFlightView.Visible = true;
            }
        }

        /// <summary>
        /// Find the linked flights with the provided passenger id
        /// </summary>
        /// <param name="passengerID"></param>
        protected void FindFlights(int passengerID) {
            ReservedSeatList reservedSeatList = new ReservedSeatList();
            reservedSeatList.Populate("PassengerID", passengerID);

            foreach (ReservedSeat reservedSeat in reservedSeatList.List) { // For each reserved seat (there could be one or two)
                this.ReservationClassLabel.Text = reservedSeat.Class; // Set the class label from the reserved seat

                if (reservedSeat.Sector == "Outward") {
                    this.outwardScheduledFlight = scheduledFlightList.FindOne("ScheduledFlightID", reservedSeat.ScheduledFlightID);
                    this.outwardFlight = flightList.FindOne("FlightID", this.outwardScheduledFlight.FlightID);
                } else if (reservedSeat.Sector == "Return") {
                    this.returnScheduledFlight = scheduledFlightList.FindOne("ScheduledFlightID", reservedSeat.ScheduledFlightID);
                    this.returnFlight = flightList.FindOne("FlightID", returnScheduledFlight.FlightID);
                }
            }
        }

        /// <summary>
        /// Event on edit reservation button clicked.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void EditReservationButton_Click(object sender, EventArgs e) {
            Session["EditReservationID"] = int.Parse(this.reservationID); // Set the reservation id in the session

            // Redirect the user to the edit reservation page, with the current URL as return (and Escaped)
            Response.Redirect($"/Reservations/Edit?returnUrl={Uri.EscapeDataString(this.Request.Url.PathAndQuery)}", true);
        }

        protected void DeleteReservationButton_Click(object sender, EventArgs e) {
            // Construct where clause with two conditions (CustomerID + ReservationID)
            WhereClause whereClause = reservationList.WhereClause
                .Where("CustomerID", this.customer.CustomerID)
                .Where("ReservationID", this.reservationID);

            int affectedRows = reservationList.Delete(whereClause); // Delete the reservation, which would cause the DELETE CASCADE on all child record (linked through foreign-key)

            if (affectedRows > 0) { // If affected row by the deletion > 0
                Response.Redirect("/Reservations", true); // Redirect the user from the current page, since it does not exist anymore
            } else { // If delete failed
                Response.Write("<script defer>alert(\"Failed to delete the reservation.\");</script>"); // Show an error for the user
            }

            /// The following code is useless, the [Reservation], [Passenger], [ReservedSeat] tables already have DELETE CASCADE on all foreign keys
            /// Which mean, deleting an reservation row would delete all the linked foreign key (i.e. the linked Passenger(s) will be deleted; Which would cause the ReservedSeat to be deleted).

            /*PassengerList passengerList = new PassengerList();
            var passengerListWhere = passengerList.WhereClause;
            passengerListWhere.Where("ReservationID", this.reservationID);

            int affectedRows = passengerList.Delete(passengerListWhere, "ReservedSeat", "PassengerID");


            if (affectedRows > 0) {
                ReservationList reservationList = new ReservationList();

                var reservationWhereClause = reservationList.WhereClause;
                reservationWhereClause.Where("CustomerID", this.customer.CustomerID);
                reservationWhereClause.Where("ReservationID", this.reservationID);

                affectedRows = reservationList.Delete(reservationWhereClause, "Passenger", "ReservationID");

                if (affectedRows > 0) {
                    affectedRows = reservationList.Delete(reservationWhereClause);

                    if (affectedRows > 0) {
                        Response.Redirect("/Reservations", true);
                    } else {
                        Response.Write("Failed to delete reservation.");
                    }
                } else {
                    Response.Write("Failed to delete passengers.");
                }
            } else {
                Response.Write("Failed to delete reserved seats.");
            }*/
        }

        /// <summary>
        /// Event for clicking the back button
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void BackButton_Click(object sender, EventArgs e) {
            if (this.Request.QueryString["returnList"] != null) { // If the query string has returnList parameter
                this.Response.Redirect(this.Request.QueryString["returnList"]); // Redirect the user to that link
            }
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;
using AirtoursBusinessObjects.Builder;

namespace AirtoursWebApplication.Reservations {
    public partial class Edit : System.Web.UI.Page {
        protected static PassengerList passengerList = new PassengerList();
        protected static ReservedSeatList reservedSeatList = new ReservedSeatList();

        protected static FlightList flightList = new FlightList();
        protected static ScheduledFlightList scheduledFlightList = new ScheduledFlightList();

        protected static ReservationList reservationList = new ReservationList();

        protected Customer customer => this.Session["customer"] as Customer; // getter for the customer from the session

        protected int reservationID => (int) this.Session["EditReservationID"];
        protected Reservation reservation {
            get => this.ViewState["reservation"] as Reservation;
            set => this.ViewState["reservation"] = value;
        }

        protected List<Passenger> passengers {
            get => this.ViewState["Passengers"] as List<Passenger>;
            set => this.ViewState["Passengers"] = value;
        }

        /****************************************************/
        protected Flight outwardFlight {
            get => this.ViewState["outwardFlight"] as Flight;
            set => this.ViewState["outwardFlight"] = value;
        }
        protected ScheduledFlight outwardScheduledFlight {
            get => this.ViewState["outwardScheduledFlight"] as ScheduledFlight;
            set => this.ViewState["outwardScheduledFlight"] = value;
        }

        protected Flight returnFlight {
            get => this.ViewState["returnFlight"] as Flight;
            set => this.ViewState["returnFlight"] = value;
        }
        protected ScheduledFlight returnScheduledFlight {
            get => this.ViewState["returnScheduledFlight"] as ScheduledFlight;
            set => this.ViewState["returnScheduledFlight"] = value;
        }
        /****************************************************/

        protected void Page_Load(object sender, EventArgs e) {
            if (!Page.IsPostBack) {
                ReservationList reservationList = new ReservationList();

                var whereClause = reservationList.WhereClause;
                whereClause.Where("CustomerID", this.customer.CustomerID);
                whereClause.Where("ReservationID", this.reservationID);

                this.reservation = reservationList.FindOne(whereClause);

                if (this.reservation is null == false) {
                    this.PopulateReservation(reservation);
                    int passengerID = this.FindAndPopulatePassengers(this.reservation);

                    if (passengerID > 0) {
                        this.FindFlights(passengerID);

                        this.PopulateOutwardFlight();
                        this.PopulateReturnFlight();
                    }
                }
            }
        }

        protected void PopulateReservation(Reservation reservation) {
            this.ReservationDateLabel.Text = reservation.ReservationDate?.ToLongDateString();
            this.ReservationTotalLabel.Text = string.Format("{0:C}", reservation.Price ?? 0m);
            this.ReservationPaidLabel.Text = (reservation?.Paid ?? false) ? "Yes" : "No";
        }

        /// <summary>
        /// Find all passengers tied to this reservation and return first passenger id
        /// </summary>
        /// <param name="reservation">Reservation to match</param>
        /// <returns></returns>
        protected int FindAndPopulatePassengers(Reservation reservation) {
            passengerList.Populate("ReservationID", reservation.ReservationID); // Populate all passengers based on reservation id

            this.passengers = passengerList.List.GetRange(0, passengerList.List.Count);

            if (this.passengers.Count > 0) { // If there are passenger (it should be; but just in case)
                return this.passengers[0].PassengerID; // Return the 1st passenger id only for later usage
            }

            return 0; // return 0 otherwise
        }

        protected void PopulateOutwardFlight() {
            if (outwardFlight is null == false && outwardScheduledFlight is null == false) { // if the outward flight is available
                this.OutwardFlightNumberLabel.Text = this.outwardFlight.FlightNumber;
                this.OutwardFlightAirlineLabel.Text = this.outwardFlight.Airline;

                this.OutwardFlightOriginLabel.Text = this.outwardFlight.Origin;
                this.OutwardFlightDestinationLabel.Text = this.outwardFlight.Destination;

                this.OutwardFlightDepartureLabel.Text = this.outwardFlight.Departure?.ToShortTimeString(); // Format time
                this.OutwardFlightArrivalLabel.Text = this.outwardFlight.Arrival?.ToShortTimeString(); // Format time

                this.OutwardFlightDateLabel.Text = this.outwardScheduledFlight.FlightDate?.ToLongDateString(); // Formate date
                this.OutwardFlightFareLabel.Text = string.Format("{0:C}", this.outwardFlight.Fare ?? 0m); // Format currency
            }
        }

        protected void PopulateReturnFlight() {
            if (returnFlight is null == false && returnScheduledFlight is null == false) { // if the return flight is available
                this.ReturnFlightNumberLabel.Text = this.returnFlight.FlightNumber;
                this.ReturnFlightAirlineLabel.Text = this.returnFlight.Airline;

                this.ReturnFlightOriginLabel.Text = this.returnFlight.Origin;
                this.ReturnFlightDestinationLabel.Text = this.returnFlight.Destination;

                this.ReturnFlightDepartureLabel.Text = this.returnFlight.Departure?.ToShortTimeString(); // Format time
                this.ReturnFlightArrivalLabel.Text = this.returnFlight.Arrival?.ToShortTimeString(); // Format time

                this.ReturnFlightDateLabel.Text = this.returnScheduledFlight.FlightDate?.ToLongDateString(); // Formate date
                this.ReturnFlightFareLabel.Text = string.Format("{0:C}", this.returnFlight.Fare ?? 0m); // Format currency

                this.ReturnFlightView.Visible = true; // Show the return flight view
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
                if (!string.IsNullOrEmpty(reservedSeat.Class)) {
                    this.ReservationClassDropDownList.SelectedValue = reservedSeat.Class; // Set the class label from the reserved seat
                }

                if (reservedSeat.Sector == "Outward") {
                    this.outwardScheduledFlight = scheduledFlightList.FindOne("ScheduledFlightID", reservedSeat.ScheduledFlightID);
                    this.outwardFlight = flightList.FindOne("FlightID", this.outwardScheduledFlight.FlightID);
                } else if (reservedSeat.Sector == "Return") {
                    this.returnScheduledFlight = scheduledFlightList.FindOne("ScheduledFlightID", reservedSeat.ScheduledFlightID);
                    this.returnFlight = flightList.FindOne("FlightID", this.returnScheduledFlight.FlightID);
                }
            }
        }

        /// <summary>
        /// Event called on click of the delete button on given passenger row in the grid view
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void PassengersGridView_RowDeleting(object sender, GridViewDeleteEventArgs e) {
            GridView gridView = sender as GridView; // Cast the sender

            int idx = e.RowIndex; // get the row index from the event
            int passengerID = (int) gridView.DataKeys[idx]["PassengerID"]; // Get the passenger id for given row from data-keys
            Passenger passenger = new Passenger(passengerID); // Construct the passenger with the id

            if (this.passengers.Count == 1) { // If only one passenger in the list
                e.Cancel = true; // Indicate that this event is canceled
                Response.Write("<script defer>alert(\"You cannot delete all passengers from this reservation\");</script>"); // Show error

                return; // exit from method
            }

            bool wasDeleted = passengerList.Delete(passenger); // Delete the passenger record
            if (wasDeleted) { // if was deleted
                this.passengers.RemoveAt(idx); // remove the passenger from the temporarily list
                this.UpdatePrice(); // update the reservation price
            }
        }

        /// <summary>
        /// Event on the add passenger button clicked
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void AddPassengerButton_Click(object sender, EventArgs e) {
            if (string.IsNullOrEmpty(this.FirstNameTextBox.Text) || string.IsNullOrEmpty(this.LastNameTextBox.Text)) { // If either first or last name are empty
                Response.Write("<script defer>alert(\"Passenger first and last name cannot be empty.\");</script>"); // Show error message
                return; // Exit from method
            }

            this.AddPassenger(this.FirstNameTextBox.Text, this.LastNameTextBox.Text); // Add passenger with the given first/last name

            this.FirstNameTextBox.Text = string.Empty; // Empty control
            this.LastNameTextBox.Text = string.Empty; // Empty control
        }

        /// <summary>
        /// Add a passenger and create related records
        /// </summary>
        /// <param name="firstName">Passenger first name</param>
        /// <param name="lastName">Passenger last name</param>
        protected void AddPassenger(string firstName, string lastName) {
            // Create new passenger object
            Passenger passenger = new Passenger() {
                ReservationID = this.reservation.ReservationID, // assign reservation id
                FirstName = firstName,
                LastName = lastName,
            };

            bool wasAdded = passengerList.Add(passenger); // add passenger
            if (wasAdded) { // if added
                wasAdded = this.ReserveNewSeat(this.outwardScheduledFlight, passenger, "Outward"); // Reserve seat on outward flight for the passenger

                if (this.returnScheduledFlight is null == false) {
                    wasAdded = this.ReserveNewSeat(this.returnScheduledFlight, passenger, "Return"); // Reserve seat on return flight for the passenger
                }

                this.passengers.Add(passenger); // Add the passenger to the temporary list
                this.UpdatePrice(); // Update the reservation price
            }
        }

        /// <summary>
        /// Reserve new seat on given scheduled flight for given passenger on a specific sector
        /// </summary>
        /// <param name="scheduledFlight">The scheduled flight</param>
        /// <param name="passenger">The passenger which the seat will be reserved</param>
        /// <param name="sector">The seat sector (Outward/Return)</param>
        /// <returns></returns>
        protected bool ReserveNewSeat(ScheduledFlight scheduledFlight, Passenger passenger, string sector = "Outward") {
            // Create reserved seat and fill details
            ReservedSeat returnReservedSeat = new ReservedSeat() {
                PassengerID = passenger.PassengerID, // set the passenger id
                ScheduledFlightID = scheduledFlight.ScheduledFlightID, // set the scheduled flight id
                Class = this.ReservationClassDropDownList.SelectedValue, // set the customer preferred class
                Status = "Waitlisted", // Default to wait-listed
                Sector = sector // Set the sector as passed
            };

            return reservedSeatList.Add(returnReservedSeat); // Add and return the state
        }

        /// <summary>
        /// Update the reservation price
        /// </summary>
        protected void UpdatePrice() {
            this.reservation.Price = this.CalculateTotalFlights();
            reservationList.Update(this.reservation);

            this.PopulateReservation(this.reservation);
        }

        /// <summary>
        /// Calculate the total flight cost
        /// </summary>
        /// <param name="flight">Specific flight</param>
        /// <returns></returns>
        protected decimal CalculateTotalFlight(Flight flight) {
            return FlightList.CalclauteFlightCost(flight, this.passengers.Count);
        }

        /// <summary>
        /// Calculate the total flights cost
        /// </summary>
        /// <returns></returns>
        protected decimal CalculateTotalFlights() {
            return this.CalculateTotalFlight(this.outwardFlight) + this.CalculateTotalFlight(this.returnFlight);
        }

        /// <summary>
        /// Event on the reservation class drop-down list has changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ReservationClassDropDownList_SelectedIndexChanged(object sender, EventArgs e) {
            int count = this.passengers.Count; // Count of passengers
            object[] passengersIDs = new object[count]; // object array of all passengers ids
            for (int i = 0; i < count; i++) { // fill the array of ids
                passengersIDs[i] = this.passengers[i].PassengerID;
            }

            // Create set clause to update Class col
            SetClause set = new SetClause(reservedSeatList.TableSchema);
            set.Add("Class", this.ReservationClassDropDownList.SelectedValue); // from the selected drop down

            WhereClause where = reservedSeatList.WhereClause.WhereIn("PassengerID", passengersIDs); // Where clause to match given passenger ids (WHERE [PassengerID] IN (.., .., ....)

            reservedSeatList.Update(set, where); // Issue the query with the set and where (will update all in one query)
        }

        /// <summary>
        /// Event on clicking the back button
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void BackButton_Click(object sender, EventArgs e) {
            if (this.Request.QueryString["returnUrl"] != null) {
                this.Response.Redirect(this.Request.QueryString["returnUrl"], true);
            }
        }

        /// <summary>
        /// Page load complete (occur after all controls event, perfect for rendering)
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_LoadComplete(object sender, EventArgs e) {
            this.PassengersGridView.DataSource = this.passengers;
            this.PassengersGridView.DataBind();
        }
    }
}

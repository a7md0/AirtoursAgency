using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication.Reservations {
    public partial class Create : System.Web.UI.Page {
        protected static ReservationList reservationList = new ReservationList();
        protected static PassengerList passengerList = new PassengerList();
        protected static ReservedSeatList reservedSeatList = new ReservedSeatList();
        protected static FlightList flightList = new FlightList();

        protected Customer customer => this.Session["customer"] as Customer; // getter for the customer from the session

        protected Flight outwardFlight { // Property which get & set from the session
            get => this.Session["outwardFlight"] as Flight;
            set => this.Session["outwardFlight"] = value;
        }
        protected ScheduledFlight outwardScheduledFlight { // Property which get & set from the session
            get => this.Session["outwardScheduledFlight"] as ScheduledFlight;
            set => this.Session["outwardScheduledFlight"] = value;
        }

        protected Flight returnFlight { // Property which get & set from the session
            get => this.Session["returnFlight"] as Flight;
            set => this.Session["returnFlight"] = value;
        }
        protected ScheduledFlight returnScheduledFlight { // Property which get & set from the session
            get => this.Session["returnScheduledFlight"] as ScheduledFlight;
            set => this.Session["returnScheduledFlight"] = value;
        }

        protected List<Passenger> passengers { // Property which get & set from the session
            get => this.ViewState["Passengers"] as List<Passenger>;
            set => this.ViewState["Passengers"] = value;
        }

        protected void Page_Load(object sender, EventArgs e) {
            if (!Page.IsPostBack) {
                this.passengers = new List<Passenger>(); // On 1st load initialize an empty list of passengers
                this.AddTempPassenger(customer.Fname, customer.Lname); // Add the current customer as 1st passenger

                if (this.outwardScheduledFlight is null == false) { // if the outward scheduled flight is not null
                    this.outwardFlight = flightList.FindOne("FlightID", this.outwardScheduledFlight.FlightID); // Query the corresponding flight and save in session
                } else { // if no scheduled flight in session (manual visit?)
                    this.Response.Redirect("/"); // Redirect to home page
                }

                if (this.returnScheduledFlight is null == false) { // if return scheduled flight is set (which is optional)
                    this.returnFlight = flightList.FindOne("FlightID", this.returnScheduledFlight.FlightID); // Query the corresponding flight and save in session
                }
            }
        }

        /// <summary>
        /// Event on the add passenger record is clicked
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void AddPassengerButton_Click(object sender, EventArgs e) {
            if (string.IsNullOrEmpty(this.FirstNameTextBox.Text) || string.IsNullOrEmpty(this.LastNameTextBox.Text)) { // If either first or last name are empty
                Response.Write("<script defer>alert(\"Passenger first and last name cannot be empty.\");</script>"); // Show error message
                return; // Exit from method
            }

            this.AddTempPassenger(this.FirstNameTextBox.Text, this.LastNameTextBox.Text); // Add the passenger temporarily

            this.FirstNameTextBox.Text = string.Empty; // Empty the controls
            this.LastNameTextBox.Text = string.Empty; // Empty the controls
        }

        /// <summary>
        /// Event on the place reservation button is clicked
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void PlaceReservationButton_Click(object sender, EventArgs e) {
            decimal reservationTotal = this.CalculateTotalFlights(); // Calculate the total for flights

            // Create reservation and assign details
            Reservation reservation = new Reservation() {
                CustomerID = this.customer.CustomerID,
                EmployeeID = null,
                Paid = false,
                ReservationDate = DateTime.Now,
                Price = reservationTotal
            };
            bool sucess = reservationList.Add(reservation);  // Indicate the success of add

            if (sucess) {
                foreach (Passenger passenger in this.passengers) { // Create passengers records (foreach)
                    passenger.ReservationID = reservation.ReservationID; // Set the reservation id on the passenger
                    sucess = passengerList.Add(passenger); // Add the passenger record

                    if (!sucess) { // if add failed
                        break;
                    }

                    sucess = this.ReserveNewSeat(this.outwardScheduledFlight, passenger, "Outward"); // Reserve seat for outward flight for the passenger

                    if (!sucess) { // if add failed
                        break;
                    }

                    if (this.returnFlight is null == false) { // if the return flight is not null
                        sucess = this.ReserveNewSeat(this.returnScheduledFlight, passenger, "Return"); // Reserve seat for return flight for the passenger

                        if (!sucess) { // if add failed
                            break;
                        }
                    }
                }
            }

            if (sucess) {
                this.outwardFlight = null; // Reset
                this.outwardScheduledFlight = null; // Reset

                this.returnFlight = null; // Reset
                this.returnScheduledFlight = null; // Reset

                Response.Redirect($"/Reservations/View?reservationID={reservation.ReservationID}", true); // Redirect to the view reservation page
            } else {
                Response.Write("<script defer>alert(\"Failed to place the reservation, please try again later.\");</script>"); // Show error message
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
                Class = this.ClassDropDownList.SelectedValue, // set the customer preferred class
                Status = "Waitlisted", // Default to wait-listed
                Sector = sector // Set the sector as passed
            };

            return reservedSeatList.Add(returnReservedSeat); // Add and return the state
        }

        /// <summary>
        /// Temporarily add passenger obj to the view-state
        /// </summary>
        /// <param name="firstName">Passenger first name</param>
        /// <param name="lastName">Passenger last name</param>
        protected void AddTempPassenger(string firstName, string lastName) {
            if (this.passengers == null) { // if the list is empty (fatal error, which shouldn't occur)
                return;
            }

            // Create a new passenger temporarily with first and last name only
            Passenger passenger = new Passenger() {
                FirstName = firstName,
                LastName = lastName,
            };

            this.passengers.Add(passenger); // Add the passenger to the view-state only
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
        /// Event called on click of the delete button on given passenger row in the grid view
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void PassengersGridView_RowDeleting(object sender, GridViewDeleteEventArgs e) {
            GridView gridView = sender as GridView; // Cast the sender

            int idx = e.RowIndex; // get the row index from the event

            if (this.passengers.Count == 1) { // If only one passenger in the list
                e.Cancel = true; // Indicate that this event is canceled
                Response.Write("<script defer>alert(\"You cannot delete all passengers\");</script>"); // Show error

                return; // Exit the method
            }

            this.passengers.RemoveAt(idx); // delete the passenger from the list
        }

        /// <summary>
        /// Page load complete event which run after all events
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_LoadComplete(object sender, EventArgs e) {
            this.PassengersGridView.DataSource = this.passengers;
            this.PassengersGridView.DataBind();

            this.OutwardFlightTotalLabel.Text = "$" + this.CalculateTotalFlight(this.outwardFlight).ToString("0.##");
            this.ReturnFlightTotalLabel.Text = "$" + this.CalculateTotalFlight(this.returnFlight).ToString("0.##");
            this.FlightsTotalLabel.Text = "$" + this.CalculateTotalFlights().ToString("0.##");
        }
    }
}

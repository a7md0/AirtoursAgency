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

        protected Customer customer => this.Session["customer"] as Customer;

        protected Flight outwardFlight {
            get => this.Session["outwardFlight"] as Flight;
            set => this.Session["outwardFlight"] = value;
        }
        protected ScheduledFlight outwardScheduledFlight {
            get => this.Session["outwardScheduledFlight"] as ScheduledFlight;
            set => this.Session["outwardScheduledFlight"] = value;
        }

        protected Flight returnFlight {
            get => this.Session["returnFlight"] as Flight;
            set => this.Session["returnFlight"] = value;
        }
        protected ScheduledFlight returnScheduledFlight {
            get => this.Session["returnScheduledFlight"] as ScheduledFlight;
            set => this.Session["returnScheduledFlight"] = value;
        }

        protected List<Passenger> passengers {
            get => this.ViewState["Passengers"] as List<Passenger>;
            set => this.ViewState["Passengers"] = value;
        }

        protected void Page_Load(object sender, EventArgs e) {
            if (!Page.IsPostBack) {
                this.passengers = new List<Passenger>();
                this.AddTempPassenger(customer.Fname, customer.Lname);

                if (this.outwardScheduledFlight is null == false) {
                    this.outwardFlight = flightList.FindOne("FlightID", this.outwardScheduledFlight.FlightID);
                } else {
                    this.Response.Redirect("/");
                }

                if (this.returnScheduledFlight is null == false) {
                    this.returnFlight = flightList.FindOne("FlightID", this.returnScheduledFlight.FlightID);
                }
            }
        }

        protected void AddPassengerButton_Click(object sender, EventArgs e) {
            if (this.FirstNameTextBox.Text == string.Empty || this.LastNameTextBox.Text == string.Empty) {
                return;
            }

            this.AddTempPassenger(this.FirstNameTextBox.Text, this.LastNameTextBox.Text);

            this.FirstNameTextBox.Text = string.Empty;
            this.LastNameTextBox.Text = string.Empty;
        }

        protected void PlaceReservationButton_Click(object sender, EventArgs e) {
            decimal outwardFlightTotal = this.CalculateTotalFlight(this.outwardFlight);
            decimal returnFlightTotal = this.CalculateTotalFlight(this.returnFlight);

            List<int> passengerIDs = new List<int>();
            bool failed = false;

            // Create reservation
            Reservation reservation = new Reservation() {
                CustomerID = this.customer.CustomerID,
                EmployeeID = null,
                Paid = false,
                ReservationDate = DateTime.Now,
                Price = outwardFlightTotal + returnFlightTotal
            };
            reservationList.Add(reservation);
            failed = !reservation.Valid;

            if (reservation.Valid) {

                // Create passengers (foreach)
                foreach (Passenger passenger in this.passengers) {
                    passenger.ReservationID = reservation.ReservationID;
                    passengerList.Add(passenger);

                    if (!passenger.Valid) {
                        failed = true;
                        break;
                    }

                    bool sucess = this.ReserveNewSeat(this.outwardScheduledFlight, passenger, "Outward");

                    if (!sucess) {
                        failed = true;
                        break;
                    }

                    if (this.returnFlight is null == false) {
                        sucess = this.ReserveNewSeat(this.returnScheduledFlight, passenger, "Return");

                        if (!sucess) {
                            failed = true;
                            break;
                        }
                    }
                }
            }

            if (!failed) {
                Response.Redirect($"/Reservations/View?reservationID={reservation.ReservationID}", true);
            } else {
                Response.Write("Failed to place the reservation, please try again later.");
            }
        }

        protected bool ReserveNewSeat(ScheduledFlight scheduledFlight, Passenger passenger, string sector = "Outward") {
            ReservedSeat returnReservedSeat = new ReservedSeat() {
                PassengerID = passenger.PassengerID,
                ScheduledFlightID = scheduledFlight.ScheduledFlightID,
                Class = this.ClassDropDownList.SelectedValue,
                Status = "Waitlisted",
                Sector = sector
            };

            return reservedSeatList.Add(returnReservedSeat);
        }

        protected void AddTempPassenger(string firstName, string lastName) {
            if (this.passengers == null) {
                return;
            }

            Passenger passenger = new Passenger() {
                FirstName = firstName,
                LastName = lastName,
            };

            this.passengers.Add(passenger);
        }

        protected decimal CalculateTotalFlight(Flight flight) {
            return FlightList.CalclauteFlightCost(flight, this.passengers.Count);
        }

        protected decimal CalculateTotalFlights() {
            return this.CalculateTotalFlight(this.outwardFlight) + this.CalculateTotalFlight(this.returnFlight);
        }

        protected void PassengersGridView_RowDeleting(object sender, GridViewDeleteEventArgs e) {
            GridView gridView = sender as GridView;

            int idx = e.RowIndex;

            if (this.passengers.Count == 1) {
                e.Cancel = true; // Indicate that this event is canceled
                Response.Write("You cannot delete all passengers");

                return;
            }

            this.passengers.RemoveAt(idx);
        }

        protected void Page_LoadComplete(object sender, EventArgs e) {
            this.PassengersGridView.DataSource = this.passengers;
            this.PassengersGridView.DataBind();

            this.OutwardFlightTotalLabel.Text = "$" + this.CalculateTotalFlight(this.outwardFlight).ToString("0.##");
            this.ReturnFlightTotalLabel.Text = "$" + this.CalculateTotalFlight(this.returnFlight).ToString("0.##");
            this.FlightsTotalLabel.Text = "$" + this.CalculateTotalFlights().ToString("0.##");
        }
    }
}

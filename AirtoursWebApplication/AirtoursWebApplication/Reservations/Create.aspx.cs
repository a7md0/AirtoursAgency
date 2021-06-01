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

        protected Customer customer;

        protected Flight outwardFlight;
        protected ScheduledFlight outwardScheduledFlight;

        protected Flight returnFlight;
        protected ScheduledFlight returnScheduledFlight;

        protected void Page_Load(object sender, EventArgs e) {
            this.customer = this.Session["customer"] as Customer;

            if (!Page.IsPostBack) {
                this.ViewState["Passengers"] = new List<Passenger>();
                this.AddPassenger(customer.Fname, customer.Lname);

                if (this.Session["Outward_ScheduledFlight"] is null == false) {
                    this.ViewState["Outward_ScheduledFlight"] = this.Session["Outward_ScheduledFlight"];

                    this.outwardScheduledFlight = this.ViewState["Outward_ScheduledFlight"] as ScheduledFlight;
                    this.ViewState["Outward_Flight"] = flightList.FindOne("FlightID", this.outwardScheduledFlight.FlightID);

                    this.Session["Outward_ScheduledFlight"] = null;
                } else {
                    this.Response.Redirect("/");
                }

                if (this.Session["Return_ScheduledFlight"] is null == false) {
                    this.ViewState["Return_ScheduledFlight"] = this.Session["Return_ScheduledFlight"];

                    this.returnScheduledFlight = this.ViewState["Return_ScheduledFlight"] as ScheduledFlight;
                    this.ViewState["Return_Flight"] = flightList.FindOne("FlightID", this.returnScheduledFlight.FlightID);

                    this.Session["Return_ScheduledFlight"] = null;
                }
            }

            if (this.ViewState["Outward_Flight"] is null == false && this.ViewState["Outward_ScheduledFlight"] is null == false) {
                this.outwardFlight = this.ViewState["Outward_Flight"] as Flight;
                this.outwardScheduledFlight = this.ViewState["Outward_ScheduledFlight"] as ScheduledFlight;
            }

            if (this.ViewState["Return_Flight"] is null == false && this.ViewState["Return_ScheduledFlight"] is null == false) {
                this.returnFlight = this.ViewState["Return_Flight"] as Flight;
                this.returnScheduledFlight = this.ViewState["Return_ScheduledFlight"] as ScheduledFlight;
            }
        }

        protected void AddPassengerButton_Click(object sender, EventArgs e) {
            if (this.FirstNameTextBox.Text == string.Empty || this.LastNameTextBox.Text == string.Empty) {
                return;
            }

            this.AddPassenger(this.FirstNameTextBox.Text, this.LastNameTextBox.Text);

            this.FirstNameTextBox.Text = string.Empty;
            this.LastNameTextBox.Text = string.Empty;
        }

        protected void PlaceReservationButton_Click(object sender, EventArgs e) {
            List<Passenger> passengers = this.ViewState["Passengers"] as List<Passenger>;

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
                foreach (Passenger passenger in passengers) {
                    passenger.ReservationID = reservation.ReservationID;
                    passengerList.Add(passenger);

                    if (!passenger.Valid) {
                        failed = true;
                        break;
                    }

                    passengerIDs.Add(passenger.PassengerID);
                }

                // Create ReservedSeat (foreach)
                foreach (int passengerID in passengerIDs) {
                    ReservedSeat outwardReservedSeat = new ReservedSeat() {
                        PassengerID = passengerID,
                        ScheduledFlightID = this.outwardScheduledFlight.ScheduledFlightID,
                        Class = this.ClassDropDownList.SelectedValue,
                        Status = "Waitlisted",
                        Sector = "Outward"
                    };

                    reservedSeatList.Add(outwardReservedSeat);

                    if (!outwardReservedSeat.Valid) {
                        failed = true;
                        break;
                    }

                    if (this.returnFlight is null == false) {
                        ReservedSeat returnReservedSeat = new ReservedSeat() {
                            PassengerID = passengerID,
                            ScheduledFlightID = this.returnScheduledFlight.ScheduledFlightID,
                            Class = this.ClassDropDownList.SelectedValue,
                            Status = "Waitlisted",
                            Sector = "Return"
                        };

                        reservedSeatList.Add(returnReservedSeat);

                        if (!returnReservedSeat.Valid) {
                            failed = true;
                            break;
                        }
                    }

                }
            }

            if (!failed) {
                Response.Redirect($"/Reservations/View.aspx?reservationID={reservation.ReservationID}", true);
            } else {
                Response.Write("Failed to place the reservation, please try again later.");
            }
        }

        protected void AddPassenger(string firstName, string lastName) {
            if (this.ViewState["Passengers"] == null) {
                return;
            }

            List<Passenger> passengers = this.ViewState["Passengers"] as List<Passenger>;

            Passenger passenger = new Passenger() {
                FirstName = firstName,
                LastName = lastName,
            };

            passengers.Add(passenger);
        }

        protected decimal CalculateTotalFlight(Flight flight) {
            decimal total = 0m;
            List<Passenger> passengers = this.ViewState["Passengers"] as List<Passenger>;

            if (flight is null == false) {
                total = flight.Fare ?? 0m;
                total *= passengers.Count;
            }

            return total;
        }

        protected decimal CalculateTotalFlights() {
            return this.CalculateTotalFlight(this.outwardFlight) + this.CalculateTotalFlight(this.returnFlight);
        }

        protected void Page_LoadComplete(object sender, EventArgs e) {
            List<Passenger> passengers = this.ViewState["Passengers"] as List<Passenger>;

            this.PassengersGridView.DataSource = passengers;
            this.PassengersGridView.DataBind();

            this.OutwardFlightTotalLabel.Text = "$" + this.CalculateTotalFlight(this.outwardFlight).ToString("0.##");
            this.ReturnFlightTotalLabel.Text = "$" + this.CalculateTotalFlight(this.returnFlight).ToString("0.##");
            this.FlightsTotalLabel.Text = "$" + this.CalculateTotalFlights().ToString("0.##");
        }
    }
}

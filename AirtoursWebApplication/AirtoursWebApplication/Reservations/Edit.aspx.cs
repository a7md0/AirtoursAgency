using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication.Reservations {
    public partial class Edit : System.Web.UI.Page {
        protected Customer customer;

        protected int reservationID;
        protected Reservation reservation;

        /****************************************************/
        protected Flight outwardFlight;
        protected ScheduledFlight outwardScheduledFlight;

        protected Flight returnFlight;
        protected ScheduledFlight returnScheduledFlight;
        /****************************************************/

        protected static PassengerList passengerList = new PassengerList();
        protected static ReservedSeatList reservedSeatList = new ReservedSeatList();

        protected static FlightList flightList = new FlightList();
        protected static ScheduledFlightList scheduledFlightList = new ScheduledFlightList();

        protected void Page_Load(object sender, EventArgs e) {
            this.customer = (Customer) this.Session["customer"];
            this.reservationID = (int) this.Session["EditReservationID"];

            if (this.ViewState["reservation"] is null == false) {
                this.reservation = this.ViewState["reservation"] as Reservation;
            }

            if (this.ViewState["outwardFlight"] is null == false && this.ViewState["outwardScheduledFlight"] is null == false) {
                this.outwardFlight = this.ViewState["outwardFlight"] as Flight;
                this.outwardScheduledFlight = this.ViewState["outwardScheduledFlight"] as ScheduledFlight;
            }

            if (this.ViewState["returnFlight"] is null == false && this.ViewState["returnScheduledFlight"] is null == false) {
                this.returnFlight = this.ViewState["returnFlight"] as Flight;
                this.returnScheduledFlight = this.ViewState["returnScheduledFlight"] as ScheduledFlight;
            }

            if (!Page.IsPostBack) {
                ReservationList reservationList = new ReservationList();

                var whereClause = reservationList.WhereClause;
                whereClause.Where("CustomerID", this.customer.CustomerID);
                whereClause.Where("ReservationID", this.reservationID);

                this.reservation = reservationList.FindOne(whereClause);
                this.ViewState["reservation"] = this.reservation;

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

        protected int FindAndPopulatePassengers(Reservation reservation) {
            PassengerList passengerList = new PassengerList();
            passengerList.Populate("ReservationID", reservation.ReservationID);

            this.ViewState["Passengers"] = passengerList.List.GetRange(0, passengerList.List.Count);

            if (passengerList.List.Count > 0) {
                return passengerList.List[0].PassengerID;
            }

            return 0;
        }

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

        protected void FindFlights(int passengerID) {
            ReservedSeatList reservedSeatList = new ReservedSeatList();
            reservedSeatList.Populate("PassengerID", passengerID);

            foreach (ReservedSeat reservedSeat in reservedSeatList.List) {
                if (!string.IsNullOrEmpty(reservedSeat.Class)) {
                    this.ReservationClassDropDownList.SelectedValue = reservedSeat.Class;
                }

                var scheduledFlightWhere = scheduledFlightList.WhereClause;
                scheduledFlightWhere.Where("ScheduledFlightID", reservedSeat.ScheduledFlightID);

                if (reservedSeat.Sector == "Outward") {
                    this.outwardScheduledFlight = scheduledFlightList.FindOne(scheduledFlightWhere);

                    if (this.outwardScheduledFlight is null == false) {
                        var flightWhere = flightList.WhereClause;
                        flightWhere.Where("FlightID", this.outwardScheduledFlight.FlightID);

                        this.outwardFlight = flightList.FindOne(flightWhere);
                    }
                } else if (reservedSeat.Sector == "Return") {
                    this.returnScheduledFlight = scheduledFlightList.FindOne(scheduledFlightWhere);

                    if (this.returnScheduledFlight is null == false) {
                        var flightWhere = flightList.WhereClause;
                        flightWhere.Where("FlightID", this.returnScheduledFlight.FlightID);

                        returnFlight = flightList.FindOne(flightWhere);
                    }
                }
            }

            this.ViewState["outwardFlight"] = this.outwardFlight;
            this.ViewState["outwardScheduledFlight"] = this.outwardScheduledFlight;

            this.ViewState["returnFlight"] = this.returnFlight;
            this.ViewState["returnScheduledFlight"] = this.returnScheduledFlight;
        }

        protected void PassengersGridView_RowDeleting(object sender, GridViewDeleteEventArgs e) {
            GridView gridView = sender as GridView;

            int idx = e.RowIndex;
            int passengerID = (int) gridView.DataKeys[idx]["PassengerID"];
            Passenger passenger = new Passenger(passengerID);

            List<Passenger> passengers = this.ViewState["Passengers"] as List<Passenger>;

            if (passengers.Count == 1) {
                e.Cancel = true; // Indicate that this event is canceled
                Response.Write("You cannot delete all passengers from this reservation");

                return;
            }

            reservedSeatList.Delete("PassengerID", passengerID);
            bool wasDeleted = passengerList.Delete(passenger);
            if (wasDeleted) {
                passengers.RemoveAt(idx);
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

        protected void AddPassenger(string firstName, string lastName) {
            Passenger passenger = new Passenger() {
                ReservationID = this.reservation.ReservationID,
                FirstName = firstName,
                LastName = lastName,
            };

            bool wasAdded = passengerList.Add(passenger);
            if (wasAdded) {
                ReservedSeat outwardReservedSeat = new ReservedSeat() {
                    PassengerID = passenger.PassengerID,
                    ScheduledFlightID = this.outwardScheduledFlight.ScheduledFlightID,
                    // Class = ?, // TODO
                    Status = "Waitlisted",
                    Sector = "Outward"
                };
                reservedSeatList.Add(outwardReservedSeat);

                if (this.returnScheduledFlight is null == false) {
                    ReservedSeat returnReservedSeat = new ReservedSeat() {
                        PassengerID = passenger.PassengerID,
                        ScheduledFlightID = this.returnScheduledFlight.ScheduledFlightID,
                        // Class = ?, // TODO
                        Status = "Waitlisted",
                        Sector = "Return"
                    };
                    reservedSeatList.Add(returnReservedSeat);
                }

                (this.ViewState["Passengers"] as List<Passenger>).Add(passenger);
            }
        }

        protected decimal CalculateTotalFlight(Flight flight) {
            List<Passenger> passengers = this.ViewState["Passengers"] as List<Passenger>;

            return FlightList.CalclauteFlightCost(flight, passengers.Count);
        }

        protected decimal CalculateTotalFlights() {
            return this.CalculateTotalFlight(this.outwardFlight) + this.CalculateTotalFlight(this.returnFlight);
        }

        protected void Page_LoadComplete(object sender, EventArgs e) {
            this.PassengersGridView.DataSource = this.ViewState["Passengers"];
            this.PassengersGridView.DataBind();
        }

        protected void ReservationClassDropDownList_SelectedIndexChanged(object sender, EventArgs e) {
            List<Passenger> passengers = this.ViewState["Passengers"] as List<Passenger>;

            int count = passengers.Count;
            object[] passengersIDs = new object[count];
            for (int i = 0; i < count; i++) {
                passengersIDs[i] = passengers[i].PassengerID;
            }

            var set = new AirtoursBusinessObjects.Builder.SetClause(reservedSeatList.TableSchema);
            set.Add("Class", this.ReservationClassDropDownList.SelectedValue);

            var where = reservedSeatList.WhereClause;
            where.WhereIn("PassengerID", passengersIDs);

            reservedSeatList.Update(set, where);
        }

        protected void BackButton_Click(object sender, EventArgs e) {
            if (this.Request.QueryString["returnUrl"] != null) {
                this.Response.Redirect(this.Request.QueryString["returnUrl"]);
            }
        }
    }
}

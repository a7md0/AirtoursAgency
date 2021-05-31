using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AirtoursBusinessObjects;

namespace AirtoursWebApplication.Reservations {
    public partial class View : System.Web.UI.Page {
        protected Customer customer;
        protected Reservation reservation;

        /****************************************************/
        protected Flight outwardFlight;
        protected ScheduledFlight outwardScheduledFlight;

        protected Flight returnFlight;
        protected ScheduledFlight returnScheduledFlight;
        /****************************************************/

        /****************************************************/
        protected ReservedSeatList reservedSeatList;
        protected ReservedSeat reservedSeat;
        /****************************************************/

        protected void Page_Load(object sender, EventArgs e) {
            this.customer = (Customer) this.Session["customer"];
            string reservationID = this.Request.QueryString["reservationID"];

            if (!Page.IsPostBack) {
                ReservationList reservationList = new ReservationList();

                var whereClause = reservationList.WhereClause;
                whereClause.Where("CustomerID", this.customer.CustomerID);
                whereClause.Where("ReservationID", reservationID);

                Reservation reservation = reservationList.FindOne(whereClause);

                if (reservation is null == false) {
                    this.PopulateReservation(reservation);
                    int passengerID = this.PopulatePassengers(reservation);

                    if (passengerID > 0) {
                        this.PopulateFlights(passengerID);
                    }
                }
            }
        }

        protected void PopulateReservation(Reservation reservation) {
            this.ReservationDateLabel.Text = reservation.ReservationDate?.ToLongDateString();
            this.ReservationTotalLabel.Text = string.Format("{0:C}", reservation.Price ?? 0m);
            this.ReservationPaidLabel.Text = (reservation?.Paid ?? false) ? "Yes" : "No";
        }

        protected void PopulateOutwardFlight(Flight flight, ScheduledFlight scheduledFlight) {
            this.OutwardFlightNumberLabel.Text = flight.FlightNumber;
            this.OutwardFlightAirlineLabel.Text = flight.Airline;

            this.OutwardFlightOriginLabel.Text = flight.Origin;
            this.OutwardFlightDestinationLabel.Text = flight.Destination;

            this.OutwardFlightDepartureLabel.Text = flight.Departure?.ToShortTimeString();
            this.OutwardFlightArrivalLabel.Text = flight.Arrival?.ToShortTimeString();

            this.OutwardFlightDateLabel.Text = scheduledFlight.FlightDate?.ToLongDateString();
            this.OutwardFlightFareLabel.Text = string.Format("{0:C}", flight.Fare ?? 0m);
        }

        protected void PopulateReturnFlight(Flight flight, ScheduledFlight scheduledFlight) {
            this.ReturnFlightNumberLabel.Text = flight.FlightNumber;
            this.ReturnFlightAirlineLabel.Text = flight.Airline;

            this.ReturnFlightOriginLabel.Text = flight.Origin;
            this.ReturnFlightDestinationLabel.Text = flight.Destination;

            this.ReturnFlightDepartureLabel.Text = flight.Departure?.ToShortTimeString();
            this.ReturnFlightArrivalLabel.Text = flight.Arrival?.ToShortTimeString();

            this.ReturnFlightDateLabel.Text = scheduledFlight.FlightDate?.ToLongDateString();
            this.ReturnFlightFareLabel.Text = string.Format("{0:C}", flight.Fare ?? 0m);

            this.ReturnFlightView.Visible = true;
        }

        protected int PopulatePassengers(Reservation reservation) {
            PassengerList passengerList = new PassengerList();
            passengerList.Populate("ReservationID", reservation.ReservationID);

            this.PassengersGridView.DataSource = passengerList.DataTable;
            this.PassengersGridView.DataBind();

            return passengerList.List[0]?.PassengerID ?? 0;
        }

        protected void PopulateFlights(int passengerID) {
            ReservedSeatList reservedSeatList = new ReservedSeatList();
            reservedSeatList.Populate("PassengerID", passengerID);

            FlightList flightList = new FlightList();
            ScheduledFlightList scheduledFlightList = new ScheduledFlightList();

            Flight outwardFlight = null;
            ScheduledFlight outwardScheduledFlight = null;

            Flight returnFlight = null;
            ScheduledFlight returnScheduledFlight = null;

            foreach (ReservedSeat reservedSeat in reservedSeatList.List) {
                this.ReservationClassLabel.Text = reservedSeat.Class;

                var scheduledFlightWhere = scheduledFlightList.WhereClause;
                scheduledFlightWhere.Where("ScheduledFlightID", reservedSeat.ScheduledFlightID);

                if (reservedSeat.Sector == "Outward") {
                    outwardScheduledFlight = scheduledFlightList.FindOne(scheduledFlightWhere);

                    var flightWhere = flightList.WhereClause;
                    flightWhere.Where("FlightID", outwardScheduledFlight.FlightID);

                    outwardFlight = flightList.FindOne(flightWhere);
                } else if (reservedSeat.Sector == "Return") {
                    returnScheduledFlight = scheduledFlightList.FindOne(scheduledFlightWhere);

                    var flightWhere = flightList.WhereClause;
                    flightWhere.Where("FlightID", returnScheduledFlight.FlightID);

                    returnFlight = flightList.FindOne(flightWhere);
                }
            }

            if (outwardFlight is null == false && outwardScheduledFlight is null == false) {
                this.PopulateOutwardFlight(outwardFlight, outwardScheduledFlight);
            }

            if (returnFlight is null == false && returnScheduledFlight is null == false) {
                this.PopulateReturnFlight(returnFlight, returnScheduledFlight);
            }
        }
    }
}

﻿using System;
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

        protected void Page_Load(object sender, EventArgs e) {
            this.customer = (Customer) this.Session["customer"];
            string reservationID = this.Request.QueryString["reservationID"];

            if (!Page.IsPostBack) {
                ReservationList reservationList = new ReservationList();

                var whereClause = reservationList.WhereClause;
                whereClause.Where("CustomerID", this.customer.CustomerID);
                whereClause.Where("ReservationID", reservationID);

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

        protected int FindAndPopulatePassengers(Reservation reservation) {
            PassengerList passengerList = new PassengerList();
            passengerList.Populate("ReservationID", reservation.ReservationID);

            this.PassengersGridView.DataSource = passengerList.DataTable;
            this.PassengersGridView.DataBind();

            return passengerList.List[0]?.PassengerID ?? 0;
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

            FlightList flightList = new FlightList();
            ScheduledFlightList scheduledFlightList = new ScheduledFlightList();

            foreach (ReservedSeat reservedSeat in reservedSeatList.List) {
                this.ReservationClassLabel.Text = reservedSeat.Class;

                var scheduledFlightWhere = scheduledFlightList.WhereClause;
                scheduledFlightWhere.Where("ScheduledFlightID", reservedSeat.ScheduledFlightID);

                if (reservedSeat.Sector == "Outward") {
                    this.outwardScheduledFlight = scheduledFlightList.FindOne(scheduledFlightWhere);

                    var flightWhere = flightList.WhereClause;
                    flightWhere.Where("FlightID", this.outwardScheduledFlight.FlightID);

                    this.outwardFlight = flightList.FindOne(flightWhere);
                } else if (reservedSeat.Sector == "Return") {
                    returnScheduledFlight = scheduledFlightList.FindOne(scheduledFlightWhere);

                    var flightWhere = flightList.WhereClause;
                    flightWhere.Where("FlightID", returnScheduledFlight.FlightID);

                    returnFlight = flightList.FindOne(flightWhere);
                }
            }
        }
    }
}

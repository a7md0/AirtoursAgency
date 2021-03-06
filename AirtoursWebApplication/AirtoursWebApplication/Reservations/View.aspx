<%@ Page Title="View reservation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="View.aspx.cs" Inherits="AirtoursWebApplication.Reservations.View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-1 align-self-start">
                <asp:Button ID="BackButton" runat="server" Text="Back" class="btn btn-info" OnClick="BackButton_Click" />
            </div>
            <div class="col-9 align-self-center">
                <h3 style="text-align: center;">View Reservation</h3>
            </div>
            <div class="col-2 align-self-end">
                <asp:Button ID="EditReservationButton" runat="server" Visible="false" Text="Edit" class="btn btn-primary" OnClick="EditReservationButton_Click" />
                <asp:Button ID="DeleteReservationButton" runat="server" Visible="false" Text="Delete" class="btn btn-danger float-right" OnClientClick="return confirm('Confirm deleation\nAre you sure to delete this reservation?')" OnClick="DeleteReservationButton_Click" />
                <asp:Label ID="EditDeleteLabel" runat="server" Text="Label" Visible="False"></asp:Label>
            </div>
        </div>

        <br />
        <br />

        <div class="row" style="display: flex; text-align: center;">
            <div class="col-md-6 mb-2 border-right">
                <h3 style="text-align: center;">Reservation detail</h3>

                <div class="row">
                    <div class="col-md-6 mb-2">
                        <h6>Reservation date</h6>
                        <asp:Label ID="ReservationDateLabel" runat="server"></asp:Label>
                    </div>

                    <div class="col-md-6 mb-2">
                        <h6>Reservation total</h6>
                        <asp:Label ID="ReservationTotalLabel" runat="server"></asp:Label>
                    </div>

                    <div class="col-md-6 mb-2">
                        <h6>Class</h6>
                        <asp:Label ID="ReservationClassLabel" runat="server"></asp:Label>
                    </div>

                    <div class="col-md-6 mb-2">
                        <h6>Paid</h6>
                        <asp:Label ID="ReservationPaidLabel" runat="server"></asp:Label>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mb-2">
                <h3 style="text-align: center;">Passengers</h3>

                <div class="row">
                    <div class="col-md-12">
                        <asp:GridView ID="PassengersGridView" runat="server" ShowHeaderWhenEmpty="true" DataKeyNames="PassengerID, ReservationID" CssClass="table table-bordered table-striped table-hover" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField HeaderText="PassengerID" DataField="PassengerID" ReadOnly="True" Visible="False" />
                                <asp:BoundField DataField="FirstName" HeaderText="First name" ReadOnly="True" />
                                <asp:BoundField DataField="LastName" HeaderText="Last name" ReadOnly="True" />
                                <asp:BoundField HeaderText="ReservationID" DataField="ReservationID" ReadOnly="True" Visible="False" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>

        <br />
        <br />

        <div class="row" style="display: flex; align-items: center; text-align: center;">
            <div class="col-md">
                <h3 style="text-align: center;">Outward flight</h3>

                <div class="row">
                    <div class="col-md-6 mb-2">
                        <h6>Flight number</h6>
                        <asp:Label ID="OutwardFlightNumberLabel" runat="server"></asp:Label>
                    </div>

                    <div class="col-md-6 mb-2">
                        <h6>Airline</h6>
                        <asp:Label ID="OutwardFlightAirlineLabel" runat="server"></asp:Label>
                    </div>


                    <div class="col-md-6 mb-2">
                        <h6>Origin</h6>
                        <asp:Label ID="OutwardFlightOriginLabel" runat="server"></asp:Label>
                    </div>

                    <div class="col-md-6 mb-2">
                        <h6>Destination</h6>
                        <asp:Label ID="OutwardFlightDestinationLabel" runat="server"></asp:Label>
                    </div>


                    <div class="col-md-6 mb-2">
                        <h6>Flight date</h6>
                        <asp:Label ID="OutwardFlightDateLabel" runat="server"></asp:Label>
                    </div>

                    <div class="col-md-6 mb-2">
                        <h6>Fare</h6>
                        <asp:Label ID="OutwardFlightFareLabel" runat="server"></asp:Label>
                    </div>

                    <div class="col-md-6 mb-2">
                        <h6>Departure time</h6>
                        <asp:Label ID="OutwardFlightDepartureLabel" runat="server"></asp:Label>
                    </div>

                    <div class="col-md-6 mb-2">
                        <h6>Arrival time</h6>
                        <asp:Label ID="OutwardFlightArrivalLabel" runat="server"></asp:Label>
                    </div>
                </div>
            </div>

            <div id="ReturnFlightView" runat="server" class="col-md border-left" visible="false">
                <h3 style="text-align: center;">Return flight</h3>

                <div class="row">
                    <div class="col-md-6 mb-2">
                        <h6>Flight number</h6>
                        <asp:Label ID="ReturnFlightNumberLabel" runat="server"></asp:Label>
                    </div>

                    <div class="col-md-6 mb-2">
                        <h6>Airline</h6>
                        <asp:Label ID="ReturnFlightAirlineLabel" runat="server"></asp:Label>
                    </div>


                    <div class="col-md-6 mb-2">
                        <h6>Origin</h6>
                        <asp:Label ID="ReturnFlightOriginLabel" runat="server"></asp:Label>
                    </div>

                    <div class="col-md-6 mb-2">
                        <h6>Destination</h6>
                        <asp:Label ID="ReturnFlightDestinationLabel" runat="server"></asp:Label>
                    </div>


                    <div class="col-md-6 mb-2">
                        <h6>Flight date</h6>
                        <asp:Label ID="ReturnFlightDateLabel" runat="server"></asp:Label>
                    </div>

                    <div class="col-md-6 mb-2">
                        <h6>Fare</h6>
                        <asp:Label ID="ReturnFlightFareLabel" runat="server"></asp:Label>
                    </div>


                    <div class="col-md-6 mb-2">
                        <h6>Departure time</h6>
                        <asp:Label ID="ReturnFlightDepartureLabel" runat="server"></asp:Label>
                    </div>

                    <div class="col-md-6 mb-2">
                        <h6>Arrival time</h6>
                        <asp:Label ID="ReturnFlightArrivalLabel" runat="server"></asp:Label>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>

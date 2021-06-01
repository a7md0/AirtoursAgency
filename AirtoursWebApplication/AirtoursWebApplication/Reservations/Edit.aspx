<%@ Page Title="Edit Reservation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="AirtoursWebApplication.Reservations.Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-1 align-self-start"></div>
            <div class="col-10 align-self-center">
                <h3 style="text-align: center;">Edit Reservation</h3>
            </div>
            <div class="col-1 align-self-end"></div>
        </div>

        <br />
        <br />

        <div class="row" style="display: flex; align-items: center; text-align: center;">
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
                        <asp:DropDownList ID="ReservationClassDropDownList" runat="server" class="custom-select d-block w-100" AutoPostBack="True" OnSelectedIndexChanged="ReservationClassDropDownList_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="Economy">Economy class</asp:ListItem>
                            <asp:ListItem Value="Business">Business class</asp:ListItem>
                        </asp:DropDownList>
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
                        <asp:GridView ID="PassengersGridView" runat="server" ShowHeaderWhenEmpty="True" DataKeyNames="PassengerID,ReservationID" CssClass="table table-bordered table-striped table-hover" AutoGenerateColumns="False" OnRowDeleting="PassengersGridView_RowDeleting">
                            <Columns>
                                <asp:BoundField HeaderText="PassengerID" DataField="PassengerID" ReadOnly="True" Visible="False" />
                                <asp:BoundField DataField="FirstName" HeaderText="First name" ReadOnly="True" />
                                <asp:BoundField DataField="LastName" HeaderText="Last name" ReadOnly="True" />
                                <asp:BoundField HeaderText="ReservationID" DataField="ReservationID" ReadOnly="True" Visible="False" />
                                <asp:CommandField ShowDeleteButton="True" />
                            </Columns>
                        </asp:GridView>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="FirstNameTextBox">First name:</label>
                        <asp:TextBox ID="FirstNameTextBox" runat="server" class="form-control" MaxLength="32"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="LastNameTextBox">Last name</label>
                        <asp:TextBox ID="LastNameTextBox" runat="server" class="form-control" MaxLength="32"></asp:TextBox>
                    </div>

                    <div class="col-md-12 mb-3">
                        <asp:Button ID="AddPassengerButton" runat="server" class="btn btn-primary btn-lg btn-block" Text="Add Passenger" OnClick="AddPassengerButton_Click" />
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

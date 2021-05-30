<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="New.aspx.cs" Inherits="AirtoursWebApplication.Reservations.New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="py-5 text-center">
            <h2>Place reservation</h2>
        </div>

        <div class="row">
            <div class="col-md-4 order-md-2 mb-4">
                <h4 class="d-flex justify-content-between align-items-center mb-3">
                    <span class="text-muted">Your reservation</span>
                </h4>
                <ul class="list-group mb-3">
                    <li class="list-group-item d-flex justify-content-between lh-condensed">
                        <div>
                            <h6 class="my-0">Outward flight</h6>
                            <small class="text-muted">
                                <asp:Label ID="OutwardFlightDescriptionLabel" runat="server"></asp:Label>
                            </small>
                        </div>
                        <span class="text-muted">
                            <asp:Label ID="OutwardFlightTotalLabel" runat="server" Text="$0"></asp:Label>
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between lh-condensed">
                        <div>
                            <h6 class="my-0">Return flight</h6>
                            <small class="text-muted">
                                <asp:Label ID="ReturnFlightDescriptionLabel" runat="server"></asp:Label>
                            </small>
                        </div>
                        <span class="text-muted">
                            <asp:Label ID="ReturnFlightTotalLabel" runat="server" Text="$0"></asp:Label>
                        </span>
                    </li>

                    <li class="list-group-item d-flex justify-content-between">
                        <span>Total (USD)</span>
                        <strong>
                            <asp:Label ID="FlightsTotalLabel" runat="server" Text="$0"></asp:Label>
                        </strong>
                    </li>
                </ul>

                <asp:Button ID="PlaceReservationButton" runat="server" class="btn btn-primary btn-lg btn-block" Text="Place Reservation" OnClick="PlaceReservationButton_Click" />
            </div>

            <div class="col-md-8 order-md-1">
                <h4 class="mb-3">Reservation details</h4>

                <div class="row">
                    <div class="col-md-12 mb-3">
                        <label for="state">Class</label>
                        <asp:DropDownList ID="ClassDropDownList" runat="server" class="custom-select d-block w-100">
                            <asp:ListItem Selected="True" Value="Economy">Economy class</asp:ListItem>
                            <asp:ListItem Value="Business">Business class</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <hr class="mb-4">

                <h4 class="mb-3">Passengers</h4>
                <div class="row">

                    <div class="col-md-12 mb-3">
                        <asp:GridView ID="PassengersGridView" runat="server" ShowHeaderWhenEmpty="true" DataKeyNames="PassengerID, ReservationID" CssClass="table table-bordered table-striped table-hover" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField HeaderText="PassengerID" DataField="PassengerID" ReadOnly="True" Visible="False" />
                                <asp:BoundField DataField="FirstName" HeaderText="First name" ReadOnly="True" />
                                <asp:BoundField DataField="LastName" HeaderText="Last name" ReadOnly="True" />
                                <asp:BoundField HeaderText="ReservationID" DataField="ReservationID" ReadOnly="True" Visible="False" />
                            </Columns>
                        </asp:GridView>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="FirstNameTextBox">First name:</label>
                        <asp:TextBox ID="FirstNameTextBox" runat="server" class="form-control" minlength="2" maxlength="32" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="LastNameTextBox">Last name</label>
                        <asp:TextBox ID="LastNameTextBox" runat="server" class="form-control" minlength="2" maxlength="32" required="true"></asp:TextBox>
                    </div>

                    <div class="col-md-12 mb-3">
                        <asp:Button ID="AddPassengerButton" runat="server" class="btn btn-primary btn-lg btn-block" Text="Add Passenger" OnClick="AddPassengerButton_Click" />
                    </div>
                </div>

                <hr class="mb-4">
            </div>
        </div>
    </div>
</asp:Content>

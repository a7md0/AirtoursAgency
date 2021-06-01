<%@ Page Title="Lookup flights" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AirtoursWebApplication.Flights.Default" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">
        <div class="row mt-3">
            <div class="col-1 align-self-start">
            </div>
            <div class="col-10 align-self-center">
                <h3 style="text-align: center;">Lookup flights</h3>
            </div>
            <div class="col-1 align-self-end">
            </div>
        </div>

        <br />
        <br />
        <br />

        <div class="row">
            <div class="col-md-6 form-group">
                <label class="form-label" for="OriginsDropDownList">Origin:</label>
                <asp:DropDownList ID="OriginsDropDownList" runat="server" class="form-control" AutoPostBack="True" OnSelectedIndexChanged="OriginsDropDownList_SelectedIndexChanged"></asp:DropDownList>
            </div>
            <div class="col-md-6 form-group">
                <label class="form-label" for="DestinationsDropDownList">Destination:</label>
                <asp:DropDownList ID="DestinationsDropDownList" runat="server" class="form-control" AutoPostBack="False" OnSelectedIndexChanged="DestinationsDropDownList_SelectedIndexChanged"></asp:DropDownList>
            </div>


            <div class="col-md-6 form-group">
                <label for="DepartureDateTextBox">Departure Date:</label>
                <asp:TextBox ID="DepartureDateTextBox" runat="server" class="form-control" TextMode="Date"></asp:TextBox>
            </div>

            <div class="col-md-6 form-group">
                <div runat="server" id="ReturnDateSection">
                    <label for="ReturnDateTextBox">Return Date:</label>
                    <asp:TextBox ID="ReturnDateTextBox" runat="server" class="form-control" TextMode="Date"></asp:TextBox>
                </div>
            </div>

            <div class="form-group form-check float-right">
                <asp:CheckBox ID="BookReturnFlight" runat="server" AutoPostBack="True" Checked="True" />
                <label for="DepartureDateTextBox">Lookup return flight</label>
            </div>

            <div class="col-md-12 form-group mb-2">
                <asp:Button ID="SearchButton" runat="server" Text="Search" class="btn btn-primary btn-block" OnClick="SearchButton_Click" />
            </div>
        </div>

        <div id="ChooseFlightSection" runat="server" visible="false" class="mt-3">
            <br />
            <br />
            <br />

            <div class="row">
                <div class="col-1 align-self-start">
                </div>
                <div class="col-10 align-self-center">
                    <h3 style="text-align: center;">Choose flight(s)</h3>
                </div>
                <div class="col-1 align-self-end">
                </div>
            </div>

            <br />
            <br />
            <br />

            <asp:GridView ID="OutwardFlightsGridView" runat="server" ShowHeaderWhenEmpty="true" DataKeyNames="FlightID" CssClass="table table-bordered table-striped table-hover" Caption="Outward flights" CaptionAlign="Top" OnSelectedIndexChanged="OutwardFlightsGridView_SelectedIndexChanged" AutoGenerateColumns="False">
                <Columns>
                    <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                        <ControlStyle CssClass="btn btn-primary" />
                    </asp:CommandField>

                    <asp:BoundField HeaderText="FlightID" DataField="FlightID" ReadOnly="True" Visible="False" />
                    <asp:BoundField HeaderText="Flight Number" DataField="FlightNumber" ReadOnly="True" />
                    <asp:BoundField HeaderText="Origin" DataField="Origin" />
                    <asp:BoundField HeaderText="Destination" DataField="Destination" />
                    <asp:BoundField HeaderText="Departure Time" DataField="Departure" DataFormatString="{0:t}" />
                    <asp:BoundField HeaderText="Arrival Time" DataField="Arrival" DataFormatString="{0:t}" />
                    <asp:BoundField HeaderText="Airline" DataField="Airline" />
                    <asp:BoundField HeaderText="Fare" DataField="Fare" DataFormatString="{0:C}" />
                </Columns>

            </asp:GridView>

            <asp:GridView ID="ReturnFlightsGridView" runat="server" ShowHeaderWhenEmpty="true" DataKeyNames="FlightID" CssClass="table table-bordered table-striped table-hover" Caption="Return flights" CaptionAlign="Top" OnSelectedIndexChanged="ReturnFlightsGridView_SelectedIndexChanged" AutoGenerateColumns="False">
                <Columns>
                    <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                        <ControlStyle CssClass="btn btn-primary" />
                    </asp:CommandField>

                    <asp:BoundField HeaderText="FlightID" DataField="FlightID" ReadOnly="True" Visible="False" />
                    <asp:BoundField HeaderText="Flight Number" DataField="FlightNumber" ReadOnly="True" />
                    <asp:BoundField HeaderText="Origin" DataField="Origin" />
                    <asp:BoundField HeaderText="Destination" DataField="Destination" />
                    <asp:BoundField HeaderText="Departure Time" DataField="Departure" DataFormatString="{0:t}" />
                    <asp:BoundField HeaderText="Arrival Time" DataField="Arrival" DataFormatString="{0:t}" />
                    <asp:BoundField HeaderText="Airline" DataField="Airline" />
                    <asp:BoundField HeaderText="Fare" DataField="Fare" DataFormatString="{0:C}" />
                </Columns>
            </asp:GridView>

            <asp:Button ID="ReserveFlightsButton" runat="server" class="btn btn-primary btn-lg btn-block" Text="Reserve" OnClick="ReserveFlightsButton_Click" />
        </div>
    </div>

</asp:Content>

<%@ Page Title="Outward Flights" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Outward.aspx.cs" Inherits="AirtoursWebApplication.Flights.Outward" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">
        <div class="row">
            <div class="col-md-3 form-group">
                <label class="form-label" for="OriginsDropDownList">Origin</label>
                <asp:DropDownList ID="OriginsDropDownList" runat="server" class="form-control"></asp:DropDownList>
            </div>
            <div class="col-md-3 form-group">
                <label class="form-label" for="DestinationsDropDownList">Destination</label>
                <asp:DropDownList ID="DestinationsDropDownList" runat="server" class="form-control"></asp:DropDownList>
            </div>
            <div class="col-md-3 form-group">
                <label for="DepartureDateTextBox">Departure Date:</label>
                <asp:TextBox ID="DepartureDateTextBox" runat="server" class="form-control" TextMode="Date"></asp:TextBox>
            </div>

            <div class="col-md-3">
                <asp:Button ID="SearchButton" runat="server" Text="Search" class="btn btn-primary btn-large" OnClick="SearchButton_Click" />
            </div>
        </div>

        <asp:GridView ID="ResultsGridView" runat="server"></asp:GridView>
    </div>

</asp:Content>

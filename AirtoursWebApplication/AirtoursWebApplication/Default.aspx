<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AirtoursWebApplication._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">
                <asp:Label ID="WelcomeLabel" runat="server" Text="Hello, guest!"></asp:Label>

            </h1>
            <p>Welcome to Airtours agency portal, you can book and manage your reservation with a few clicks.</p>
            <p><asp:HyperLink ID="HyperLink" runat="server" href="/Register" class="btn btn-primary btn-lg" role="button">Join now &raquo;</asp:HyperLink></p>
        </div>
    </div>

    <div class="container">
        <!-- Example row of columns -->
        <div class="row">
            <div class="col-md-6 border-right">
                <h2>Lookup flights</h2>
                <p>You can lookup flights and book your reservation in few clicks.</p>
                <p><a class="btn btn-secondary" href="/Flights/" role="button">Lookup flights &raquo;</a></p>
            </div>
            <div class="col-md-6">
                <h2>Upcoming reservations</h2>
                <p>Keep track of your upcoming reservations and make any changes before the flight date.</p>
                <p><a class="btn btn-secondary" href="/Reservations/" role="button">View upcoming reservations &raquo;</a></p>
            </div>
        </div>
        <hr>
    </div>
    <!-- /container -->

</asp:Content>

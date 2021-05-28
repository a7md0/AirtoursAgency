<%@ Page Title="Outward Flights" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lookup.aspx.cs" Inherits="AirtoursWebApplication.Flights.Lookup" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">
        <div class="row">
            <div class="col-md-4 form-group">
                <label class="form-label" for="OriginsDropDownList">Origin</label>
                <asp:DropDownList ID="OriginsDropDownList" runat="server" class="form-control" AutoPostBack="True"></asp:DropDownList>
            </div>
            <div class="col-md-4 form-group">
                <label class="form-label" for="DestinationsDropDownList">Destination</label>
                <asp:DropDownList ID="DestinationsDropDownList" runat="server" class="form-control" AutoPostBack="True"></asp:DropDownList>
            </div>
            <div class="col-md-4 form-group">
                <label for="DepartureDateTextBox">Departure Date:</label>
                <asp:TextBox ID="DepartureDateTextBox" runat="server" class="form-control" TextMode="Date"></asp:TextBox>
            </div>

            <div class="col-md-4"></div>
            <div class="col-md-4 form-group">
                <label for="DepartureDateTextBox">Book return flight:</label>
                <asp:CheckBox ID="BookReturnFlight" runat="server" AutoPostBack="True" Checked="True" />
            </div>
            <div class="col-md-4 form-group">
                <label for="ReturnDateTextBox">Return Date:</label>
                <asp:TextBox ID="ReturnDateTextBox" runat="server" class="form-control" TextMode="Date"></asp:TextBox>
            </div>
            <div class="col-md-4"></div>

            <div class="col-md-12">
                <asp:Button ID="SearchButton" runat="server" Text="Search" class="btn btn-primary btn-lg btn-block" OnClick="SearchButton_Click" />
            </div>
        </div>

        <asp:GridView ID="OutwardFlightsGridView" runat="server" UseAccessibleHeader="true" CssClass="table table-bordered table-striped table-hover" Width="50%" Caption="Outward flights" CaptionAlign="Top">
            <Columns>
                <asp:TemplateField HeaderText="Select">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="Selected" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:GridView ID="ReturnFlightsGridView" runat="server" UseAccessibleHeader="true" CssClass="table table-bordered table-striped table-hover" Caption="Return flights" CaptionAlign="Top">
            <Columns>
                <asp:TemplateField HeaderText="Select">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="Selected" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:Button ID="ReserveFlightsButton" runat="server" class="btn btn-primary btn-lg btn-block" Text="Reserve" OnClick="ReserveFlightsButton_Click" />
    </div>

</asp:Content>

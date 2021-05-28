<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Choose.aspx.cs" Inherits="AirtoursWebApplication.Flights.Choose" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h3>Choose flight(s)</h3>
            </div>
        </div>
        <asp:GridView ID="OutwardFlightsGridView" runat="server" CssClass="table table-bordered table-striped table-hover" Caption="Outward flights" CaptionAlign="Top" OnSelectedIndexChanged="OutwardFlightsGridView_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                    <ControlStyle CssClass="btn btn-primary" />
                </asp:CommandField>
            </Columns>

        </asp:GridView>

        <asp:GridView ID="ReturnFlightsGridView" runat="server" CssClass="table table-bordered table-striped table-hover" Caption="Return flights" CaptionAlign="Top" OnSelectedIndexChanged="ReturnFlightsGridView_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                    <ControlStyle CssClass="btn btn-primary" />
                </asp:CommandField>
            </Columns>
        </asp:GridView>

        <asp:Button ID="ReserveFlightsButton" runat="server" class="btn btn-primary btn-lg btn-block" Text="Reserve" OnClick="ReserveFlightsButton_Click" />
    </div>
</asp:Content>

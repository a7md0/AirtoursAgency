<%@ Page Title="All reservations" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="All.aspx.cs" Inherits="AirtoursWebApplication.Reservations.All" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <asp:GridView ID="ReservationsGridView" runat="server" ShowHeaderWhenEmpty="True" DataKeyNames="ReservationID,CustomerID,EmployeeID" CssClass="table table-bordered table-striped table-hover" AutoGenerateColumns="False" OnSelectedIndexChanged="ReservationsGridView_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                    <ControlStyle CssClass="btn btn-primary" />
                </asp:CommandField>

                <asp:BoundField HeaderText="ReservationID" DataField="ReservationID" ReadOnly="True" />
                <asp:BoundField HeaderText="CustomerID" DataField="CustomerID" ReadOnly="True" Visible="False" />
                <asp:BoundField HeaderText="EmployeeID" DataField="EmployeeID" ReadOnly="True" Visible="False" />

                <asp:BoundField HeaderText="Paid" DataField="Paid" />
                <asp:BoundField HeaderText="Price" DataField="Price" DataFormatString="{0:C}" />
                <asp:BoundField HeaderText="ReservationDate" DataField="ReservationDate" DataFormatString="{0:d}" />
            </Columns>

        </asp:GridView>
    </div>
</asp:Content>

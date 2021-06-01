<%@ Page Title="All reservations" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="All.aspx.cs" Inherits="AirtoursWebApplication.Reservations.All" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-1 align-self-start"></div>
            <div class="col-10 align-self-center">
                <h3 style="text-align: center;">All Reservations</h3>
            </div>
            <div class="col-1 align-self-end"></div>
        </div>

        <br />
        <br />

        <div class="row">
            <div class="col-md-12">
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
        </div>
    </div>
</asp:Content>

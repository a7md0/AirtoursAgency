<%@ Page Title="Register" Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" MasterPageFile="~/Site.Master" Inherits="AirtoursWebApplication.Register" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <fieldset class="form-horizontal">
        <div id="legend">
            <legend class="">Register</legend>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-4 form-group">
                    <label class="control-label" for="FirstNameTextBox">First Name*</label>
                    <div class="controls">
                        <asp:TextBox ID="FirstNameTextBox" runat="server" class="form-control" autocomplete="given-name" MaxLength="15"></asp:TextBox>
                    </div>
                </div>
                <div class="col-4 form-group">
                    <label class="control-label" for="LastNameTextBox">Last Name*</label>
                    <div class="controls">
                        <asp:TextBox ID="LastNameTextBox" runat="server" class="form-control" autocomplete="family-name" MaxLength="20"></asp:TextBox>
                    </div>
                </div>
                <div class="col-4 form-group">
                    <label class="control-label" for="PhoneTextBox">Phone</label>
                    <div class="controls">
                        <asp:TextBox ID="PhoneTextBox" runat="server" class="form-control" autocomplete="tel" MaxLength="25"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-6 form-group">
                    <label class="control-label" for="EmailTextBox">Email*</label>
                    <div class="controls">
                        <asp:TextBox ID="EmailTextBox" runat="server" class="form-control" TextMode="Email" autocomplete="email" MaxLength="30"></asp:TextBox>
                    </div>
                </div>
                <div class="col-6 form-group">
                    <label class="control-label" for="PasswordTextBox">Password*</label>
                    <div class="controls">
                        <asp:TextBox ID="PasswordTextBox" TextMode="Password" runat="server" class="form-control" autocomplete="new-password"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-4 form-group">
                    <label class="control-label" for="CountryDropDownList">Country*</label>
                    <div class="controls">
                        <asp:DropDownList ID="CountryDropDownList" runat="server" class="form-control" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
                <div class="col-4 form-group">
                    <label class="control-label" for="CityTextBox">City</label>
                    <div class="controls">
                        <asp:TextBox ID="CityTextBox" runat="server" class="form-control" autocomplete="address-level2" MaxLength="50"></asp:TextBox>
                    </div>
                </div>
                <div class="col-4 form-group">
                    <label class="control-label" for="AddressTextBox">Address</label>
                    <div class="controls">
                        <asp:TextBox ID="AddressTextBox" runat="server" class="form-control" autocomplete="address-line1" MaxLength="20"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <!-- Button -->
                <div class="controls">
                    <asp:Button ID="RegisterButton" runat="server" class="btn btn-success" Text="Register" OnClick="RegisterButton_Click" />
                </div>
            </div>
        </div>

    </fieldset>
</asp:Content>

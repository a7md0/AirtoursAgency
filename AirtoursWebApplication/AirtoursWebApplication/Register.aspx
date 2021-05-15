<%@ Page Title="Register" Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" MasterPageFile="~/Site.Master" Inherits="AirtoursWebApplication.Register" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <fieldset class="form-horizontal">
        <div id="legend">
            <legend class="">Register</legend>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-6 form-group">
                    <label class="form-label" for="FirstNameTextBox">First Name*</label>
                    <div class="controls">
                        <asp:TextBox ID="FirstNameTextBox" runat="server" class="form-control" autocomplete="given-name" MaxLength="15" placeholder="First name"></asp:TextBox>
                    </div>
                </div>
                <div class="col-6 form-group">
                    <label class="form-label" for="LastNameTextBox">Last Name*</label>
                    <div class="controls">
                        <asp:TextBox ID="LastNameTextBox" runat="server" class="form-control" autocomplete="family-name" MaxLength="20" placeholder="Family name"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-6 form-group">
                    <label class="form-label" for="EmailTextBox">Email*</label>
                    <div class="controls">
                        <asp:TextBox ID="EmailTextBox" runat="server" class="form-control" TextMode="Email" autocomplete="email" MaxLength="30" placeholder="user@email.com"></asp:TextBox>
                    </div>
                </div>
                <div class="col-6 form-group">
                    <label class="form-label" for="PasswordTextBox">Password*</label>
                    <div class="controls">
                        <asp:TextBox ID="PasswordTextBox" TextMode="Password" runat="server" class="form-control" autocomplete="new-password" placeholder="Your password"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-6 form-group">
                    <label class="form-label" for="CountryDropDownList">Country*</label>
                    <div class="controls">
                        <asp:DropDownList ID="CountryDropDownList" runat="server" class="form-control"></asp:DropDownList>
                    </div>
                </div>
                <div class="col-6 form-group">
                    <label class="form-label" for="CityTextBox">City</label>
                    <div class="controls">
                        <asp:TextBox ID="CityTextBox" runat="server" class="form-control" autocomplete="address-level2" MaxLength="50" placeholder="Your city"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-6 form-group">
                    <label class="form-label" for="AddressTextBox">Address</label>
                    <div class="controls">
                        <asp:TextBox ID="AddressTextBox" runat="server" class="form-control" autocomplete="address-line1" MaxLength="20" placeholder="Address 1"></asp:TextBox>
                    </div>
                </div>
                <div class="col-6 form-group">
                    <label class="form-label" for="PhoneTextBox">Phone</label>
                    <div class="controls">
                        <asp:TextBox ID="PhoneTextBox" runat="server" class="form-control" autocomplete="tel" MaxLength="25" placeholder="+973xxxxxxxx"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <!-- Button -->
                <div class="controls">
                    <asp:Button ID="RegisterButton" runat="server" class="btn btn-primary btn-lg btn-block" Text="Register" OnClick="RegisterButton_Click" />
                </div>
            </div>
        </div>

    </fieldset>
</asp:Content>

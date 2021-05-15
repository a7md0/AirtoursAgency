<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" MasterPageFile="~/Site.Master" Inherits="AirtoursWebApplication.Register" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h1>Register</h1>
        <p>
            <label for="FirstNameTextBox">First Name</label>
            <asp:TextBox ID="FirstNameTextBox" runat="server" autocomplete="given-name" MaxLength="15"></asp:TextBox>

            <label for="LastNameTextBox">Last Name</label>
            <asp:TextBox ID="LastNameTextBox" runat="server" autocomplete="family-name" MaxLength="20"></asp:TextBox>

            <label for="PhoneTextBox">Phone</label>
            <asp:TextBox ID="PhoneTextBox" runat="server" autocomplete="tel" MaxLength="25"></asp:TextBox>
        </p>
        <p>
            <label for="EmailTextBox">Email</label>
            <asp:TextBox ID="EmailTextBox" runat="server" TextMode="Email" autocomplete="email" MaxLength="30"></asp:TextBox>

            <label for="PasswordTextBox">Password</label>
            <asp:TextBox ID="PasswordTextBox" TextMode="Password" runat="server" autocomplete="new-password"></asp:TextBox>
        </p>
        <p>
            <label for="CountryDropDownList">Country</label>
            <asp:DropDownList ID="CountryDropDownList" runat="server"></asp:DropDownList>

            <label for="CityTextBox">City</label>
            <asp:TextBox ID="CityTextBox" runat="server" autocomplete="address-level2" MaxLength="50"></asp:TextBox>

            <label for="AddressTextBox">Address</label>
            <asp:TextBox ID="AddressTextBox" runat="server" autocomplete="address-line1" MaxLength="20"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="RegisterButton" runat="server" Text="Register" OnClick="RegisterButton_Click" />
        </p>
    </div>
</asp:Content>

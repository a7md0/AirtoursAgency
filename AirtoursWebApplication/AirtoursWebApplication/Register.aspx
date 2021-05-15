<%@ Page Title="Register" Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" MasterPageFile="~/Site.Master" Inherits="AirtoursWebApplication.Register" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <form class="needs-validation">
        <div id="legend">
            <legend class="">Register</legend>
        </div>

        <div class="container">
            <asp:ValidationSummary ID="ValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" HeaderText="Errors:" />

            <div class="row">
                <div class="col-6 form-group">
                    <label class="form-label" for="FirstNameTextBox">First Name<span class="required">*</span></label>
                    <asp:TextBox ID="FirstNameTextBox" runat="server" class="form-control" autocomplete="given-name" placeholder="First name" autofocus="true" CausesValidation="true"></asp:TextBox>

                    <asp:RequiredFieldValidator ControlToValidate="FirstNameTextBox" runat="server" ErrorMessage="Please enter your first name" CssClass="invalid-feedback" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ControlToValidate="FirstNameTextBox" runat="server" ValidationExpression="^\S{2,15}$" ErrorMessage="Name must be from 2 to 15 characters long" CssClass="invalid-feedback" Display="Dynamic" ValidateRequestMode="Inherit"></asp:RegularExpressionValidator>
                </div>
                <div class="col-6 form-group">
                    <label class="form-label" for="LastNameTextBox">Last Name<span class="required">*</span></label>
                    <asp:TextBox ID="LastNameTextBox" runat="server" class="form-control" autocomplete="family-name" MaxLength="20" placeholder="Family name"></asp:TextBox>

                    <asp:RequiredFieldValidator ControlToValidate="LastNameTextBox" runat="server" ErrorMessage="Please enter your last name" CssClass="invalid-feedback" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ControlToValidate="LastNameTextBox" runat="server" ValidationExpression="^\S{2,20}$" ErrorMessage="Name must be from 2 to 20 characters long" CssClass="invalid-feedback" Display="Dynamic" ValidateRequestMode="Inherit"></asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="row">
                <div class="col-6 form-group">
                    <label class="form-label" for="EmailTextBox">Email<span class="required">*</span></label>
                    <asp:TextBox ID="EmailTextBox" runat="server" class="form-control" TextMode="Email" autocomplete="email" MaxLength="30" placeholder="user@email.com"></asp:TextBox>

                    <asp:RequiredFieldValidator ControlToValidate="EmailTextBox" runat="server" ErrorMessage="Please enter your email address" CssClass="invalid-feedback" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ControlToValidate="EmailTextBox" runat="server" ValidationExpression="^(?=\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)(?>\S{2,30}$)$" ErrorMessage="Email must be valid and maximum of 30 characters long" CssClass="invalid-feedback" Display="Dynamic" ValidateRequestMode="Inherit"></asp:RegularExpressionValidator>
                </div>
                <div class="col-6 form-group">
                    <label class="form-label" for="PasswordTextBox">Password<span class="required">*</span></label>
                    <asp:TextBox ID="PasswordTextBox" TextMode="Password" runat="server" class="form-control" autocomplete="new-password" placeholder="Your password"></asp:TextBox>

                    <asp:RequiredFieldValidator ControlToValidate="PasswordTextBox" runat="server" ErrorMessage="Please enter your password" CssClass="invalid-feedback" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ControlToValidate="PasswordTextBox" runat="server" ValidationExpression="^\S{3,32}$" ErrorMessage="Password must be from 3 to 32 characters long" CssClass="invalid-feedback" Display="Dynamic" ValidateRequestMode="Inherit"></asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="row">
                <div class="col-6 form-group">
                    <label class="form-label" for="CountryDropDownList">Country<span class="required">*</span></label>
                    <asp:DropDownList ID="CountryDropDownList" runat="server" class="form-control"></asp:DropDownList>

                    <asp:RegularExpressionValidator ControlToValidate="CountryDropDownList" runat="server" ValidationExpression="^\S{2,20}$" ErrorMessage="Country must be from 3 to 32 characters long" CssClass="invalid-feedback" Display="Dynamic" ValidateRequestMode="Inherit"></asp:RegularExpressionValidator>
                </div>
                <div class="col-6 form-group">
                    <label class="form-label" for="CityTextBox">City</label>
                    <asp:TextBox ID="CityTextBox" runat="server" class="form-control" autocomplete="address-level2" MaxLength="50" placeholder="Your city"></asp:TextBox>

                    <asp:RegularExpressionValidator ControlToValidate="CityTextBox" runat="server" ValidationExpression="^\S{2,50}$" ErrorMessage="City must be from 2 to 50 characters long" CssClass="invalid-feedback" Display="Dynamic" ValidateRequestMode="Inherit"></asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="row">
                <div class="col-6 form-group">
                    <label class="form-label" for="AddressTextBox">Address</label>
                    <asp:TextBox ID="AddressTextBox" runat="server" class="form-control" autocomplete="address-line1" MaxLength="20" placeholder="Address 1"></asp:TextBox>
                    
                    <asp:RegularExpressionValidator ControlToValidate="AddressTextBox" runat="server" ValidationExpression="^\S{2,20}$" ErrorMessage="Address must be from 3 to 20 characters long" CssClass="invalid-feedback" Display="Dynamic" ValidateRequestMode="Inherit"></asp:RegularExpressionValidator>
                </div>
                <div class="col-6 form-group">
                    <label class="form-label" for="PhoneTextBox">Phone</label>
                    <asp:TextBox ID="PhoneTextBox" runat="server" class="form-control" autocomplete="tel" MaxLength="25" placeholder="+973xxxxxxxx"></asp:TextBox>

                    <asp:RegularExpressionValidator ControlToValidate="PhoneTextBox" runat="server" ValidationExpression="^\S{2,25}$" ErrorMessage="Phone must be from 3 to 25 characters long" CssClass="invalid-feedback" Display="Dynamic" ValidateRequestMode="Inherit"></asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="form-group">
                <!-- Button -->
                <div class="controls">
                    <asp:Button ID="RegisterButton" runat="server" class="btn btn-primary btn-lg btn-block" Text="Register" OnClick="RegisterButton_Click" />
                </div>
            </div>
        </div>
    </form>
</asp:Content>

<%@ Page Title="Login" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" MasterPageFile="~/Site.Master" Inherits="AirtoursWebApplication.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-signin">
        <div class="text-center mb-4">
            <h1 class="h3 mb-3 font-weight-normal">Login Page</h1>
            <asp:Label ID="Label1" ForeColor="red" Font-Name="Verdana" Font-Size="10" runat="server" />
        </div>
        <div class="form-group">
            <label class="form-label" for="txtUserName">Email address</label>
            <asp:TextBox ID="txtUserName" runat="server" type="email" class="form-control" placeholder="Email address" required="true" autofocus="true" autocomplete="email"></asp:TextBox>
        </div>
        <div class="form-group">
            <label class="form-label" for="txtUserPass">Password</label>
            <asp:TextBox ID="txtUserPass" runat="server" type="password" class="form-control" placeholder="Password" required="true" autocomplete="current-password"></asp:TextBox>
        </div>
        <asp:Button ID="Button1" runat="server" Text="Log in" class="btn btn-lg btn-primary btn-block" OnClick="cmdLogin_Click" />
    </div>
</asp:Content>

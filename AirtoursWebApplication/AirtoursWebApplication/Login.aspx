<%@ Page Title="Login" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" MasterPageFile="~/Site.Master" Inherits="AirtoursWebApplication.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-signin">
        <div class="text-center mb-4">
            <h1 class="h3 mb-3 font-weight-normal">Login Page</h1>
            <asp:Label ID="Label1" ForeColor="red" Font-Name="Verdana" Font-Size="10" runat="server" />
        </div>
        <div class="form-label-group">
            <asp:TextBox ID="txtUserName" runat="server" type="email" class="form-control" placeholder="Email address" required="true" autofocus="true"></asp:TextBox>
            <label for="txtUserName">Email address</label>
        </div>
        <div class="form-label-group">
            <asp:TextBox ID="txtUserPass" runat="server" type="password" class="form-control" placeholder="Password" required="true"></asp:TextBox>
            <label for="txtUserPass">Password</label>
        </div>
        <asp:Button ID="Button1" runat="server" Text="Sign in" class="btn btn-lg btn-primary btn-block" OnClick="cmdLogin_Click" />
    </div>
</asp:Content>

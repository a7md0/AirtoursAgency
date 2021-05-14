<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AirtoursWebApplication.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h3>
            <span>Login Page</span>
        </h3>
        <table>
            <tr>
                <td>Email:</td>
                <td>
                    <input id="txtUserName" type="text" runat="server" /></td>
                <td>
                    <asp:RequiredFieldValidator ControlToValidate="txtUserName"
                        Display="Static" ErrorMessage="*" runat="server"
                        ID="vUserName" /></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td>
                    <input id="txtUserPass" type="password" runat="server" /></td>
                <td>
                    <asp:RequiredFieldValidator ControlToValidate="txtUserPass"
                        Display="Static" ErrorMessage="*" runat="server"
                        ID="vUserPass" />
                </td>
            </tr>
        </table>
        <asp:Button ID="cmdLogin" runat="server" Text="Login" OnClick="cmdLogin_Click" /><p></p>
        <asp:Label ID="lblMsg" ForeColor="red" Font-Name="Verdana" Font-Size="10" runat="server" />
    </form>
</body>
</html>

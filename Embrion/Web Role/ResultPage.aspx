<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResultPage.aspx.cs" Inherits="Web_Role.ResultPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="height: 446px">
    
        <asp:Label ID="Label1" runat="server" Text="ID de usuario:"></asp:Label>
        <asp:TextBox ID="TextBoxIdusuario" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="Button" />
        <br />
        <br />
        <br />
        <asp:Repeater ID="repJobResults" runat="server">
            <ItemTemplate>
                <table>
                    <tr><td>Name:</td><td><asp:TextBox ID="txtName" runat="server" Text='<%# Eval("Name") %>' /></td></tr>
                    <tr><td>Last Name:</td><td><asp:TextBox ID="txtLastName" runat="server" Text='<%# Eval("LastName") %>' /></td></tr>
                    <tr><td>Age:</td><td><asp:TextBox ID="txtAge" runat="server" Text='<%# Eval("Age") %>' /></td></tr>
                    <tr><td>Birthdate:</td><td><asp:TextBox ID="txtBirthDate" runat="server" Text='<%# String.Format("{0:d}", Eval("BirthDate")) %>' /></td></tr>                  
                </table>                
            </ItemTemplate>
        </asp:Repeater>    
    </div>
    </form>
</body>
</html>

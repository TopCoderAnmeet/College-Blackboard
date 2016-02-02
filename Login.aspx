<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        Login Here.............</p>
    <table style="width: 50%">
        <tr>
            <td style="width: 144px">
                Email Id:</td>
            <td>
                <asp:TextBox ID="TextBox1" runat="server" Width="167px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 144px">
                Password:</td>
            <td>
                <asp:TextBox ID="TextBox2" runat="server" Width="170px" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 144px">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 144px">
                <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Login..." 
                    Width="120px" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>


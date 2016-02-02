<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="frmdatesheet.aspx.cs" Inherits="frmdatesheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        <strong>Date Sheet:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></p>
    <p>
        <asp:LinkButton ID="LinkButton1" runat="server" 
            PostBackUrl="~/M.B.A.Regular &amp; I.C. Sem 2nd &amp; 4th.doc.pdf">MBA</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="LinkButton2" runat="server" 
            PostBackUrl="~/BCA Part-1,2,3.doc.pdf">BCA</asp:LinkButton>
    </p>
</asp:Content>


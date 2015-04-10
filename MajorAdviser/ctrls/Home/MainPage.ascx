<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainPage.ascx.cs" Inherits="MajorAdviser.ctrls.Home.MainPage" %>
<h1>Select A Major</h1>
<asp:DropDownList ID="ddl_majors" runat="server" OnSelectedIndexChanged="DisplayResults" AutoPostBack="true"></asp:DropDownList>
<asp:Panel ID="Panel1" runat="server" Visible="False">
    <p>Well eventually there will be interesting things here to display about this major</p>
    <p>Stay tuned..</p>
</asp:Panel>

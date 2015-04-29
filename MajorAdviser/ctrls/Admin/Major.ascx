<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Major.ascx.cs" Inherits="MajorAdviser.ctrls.Admin.Major" %>
<h1>Majors</h1>
<asp:SqlDataSource 
    ID="SqlDataSource1" 
    runat="server" 
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
    SelectCommand="SELECT * FROM [Major]"></asp:SqlDataSource>
<asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1"></asp:GridView>
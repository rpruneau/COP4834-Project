<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Degree.ascx.cs" Inherits="MajorAdviser.ctrls.Admin.Degree" %>
<h1>Degrees</h1>
<asp:SqlDataSource 
    ID="SqlDataSource1" 
    runat="server" 
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
    SelectCommand="SELECT * FROM [Degree]"></asp:SqlDataSource>
<asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1"></asp:GridView>

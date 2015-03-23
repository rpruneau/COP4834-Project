<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Courses.ascx.cs" Inherits="MajorAdviser.ctrls.Admin.Courses" %>
<h1>Courses</h1>
<asp:SqlDataSource 
    ID="SqlDataSource1" 
    runat="server" 
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
    SelectCommand="SELECT * FROM [Course]"></asp:SqlDataSource>
<asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1"></asp:GridView>
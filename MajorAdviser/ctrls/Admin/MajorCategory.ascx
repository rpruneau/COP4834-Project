<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MajorCategory.ascx.cs" Inherits="MajorAdviser.ctrls.Admin.MajorCategory" %>
<h1>MajorCategory</h1>
<asp:SqlDataSource 
    ID="SqlDataSource1" 
    runat="server" 
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
    SelectCommand="SELECT m.Title, c.Title FROM [MajorCategory] mc Left Join [Major] m ON  mc.MajorID = m.ID Left Join [Category] c ON mc.CategoryID = c.ID"></asp:SqlDataSource>
<asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1"></asp:GridView>
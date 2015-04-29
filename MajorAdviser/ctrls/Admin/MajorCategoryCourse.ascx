<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MajorCategoryCourse.ascx.cs" Inherits="MajorAdviser.ctrls.Admin.MajorCategoryCourse" %>
<h1>MajorCategoryCourse</h1>
<asp:SqlDataSource
    ID="SqlDataSource1"
    runat="server"
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
    SelectCommand="
SELECT 
(SELECT Title FROM [Major] WHERE ID = (SELECT DISTINCT MajorID FROM MajorCategory WHERE MajorID = mc.MajorID)) AS Major
,(SELECT Title FROM Category WHERE ID = (SELECT DISTINCT CategoryID FROM MajorCategory WHERE CategoryID = mc.CategoryID)) AS Category
,c.Code, c.Title
FROM [MajorCategoryCourse] mcc 
LEFT JOIN MajorCategory mc ON mcc.MajorCategoryID = mc.ID 
LEFT JOIN Course c ON mcc.CourseID = c.ID
    "></asp:SqlDataSource>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowSorting="True" OnSorting="GridView1_Sorting">
    <Columns>
        <asp:BoundField HeaderText="Major" DataField="Major" />
        <asp:BoundField HeaderText="Category" DataField="Category" />
        <asp:BoundField HeaderText="Code" DataField="Code" />
        <asp:BoundField HeaderText="Title" DataField="Title" />
    </Columns>
</asp:GridView>

<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainPage.ascx.cs" Inherits="MajorAdviser.ctrls.Home.MainPage" %>
<h1>Select A Major</h1>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:DropDownList ID="ddlMajors" runat="server" OnSelectedIndexChanged="DisplayResults" AutoPostBack="true"></asp:DropDownList>
        <br /><br />
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" AllowSorting="True" OnSorting="gvCourses_Sorting">
                <Columns>
                    <asp:BoundField HeaderText="Category" DataField="Title2" />
                    <asp:BoundField HeaderText="Course" DataField="Code2" />
                    <asp:BoundField HeaderText="Title" DataField="Title3" />
                    <asp:BoundField HeaderText="Description" DataField="Description" />
                    <asp:BoundField HeaderText="Credit Hours" DataField="CreditHours" />
                </Columns>
            </asp:GridView>
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>

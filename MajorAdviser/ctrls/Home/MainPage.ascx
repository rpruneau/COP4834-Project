<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainPage.ascx.cs" Inherits="MajorAdviser.ctrls.Home.MainPage" %>
<h1>Select A Major</h1>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:DropDownList ID="ddlMajors" runat="server" OnSelectedIndexChanged="DisplayResults" AutoPostBack="true"></asp:DropDownList>
        <br />
        <br />
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <asp:GridView ID="gvCourses" runat="server"
                AutoGenerateColumns="false" AllowSorting="True"
                OnSorting="gvCourses_Sorting"
                OnRowDataBound="gvCourses_OnRowDataBound" DataKeyNames="CourseID">
                <Columns>
                    <asp:BoundField HeaderText="Category" DataField="Title2" />
                    <asp:BoundField HeaderText="Course" DataField="Code2" />
                    <asp:BoundField HeaderText="Title" DataField="Title3" />
                    <asp:BoundField HeaderText="Description" DataField="Description" />
                    <asp:BoundField HeaderText="Credit Hours" DataField="CreditHours" />
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            Completed
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%--<asp:Button ID="Button1" runat="server" Text="" />--%>
                            <asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="CheckBox" AutoPostBack="True" CssClass="checkbox" />
                            <asp:HiddenField ID="CourseID" Value='<%# Eval("CourseID") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>
<asp:HiddenField ID="SelectedCourseId" runat="server" />
<script type="text/javascript">
    function pageLoad() {
        $('.checkbox').click(function () {
            var courseId = $(this).next().val();
            if(courseId !== ""){
                $('#<%= SelectedCourseId.ClientID %>').val(courseId);
            }
        });
    }
</script>

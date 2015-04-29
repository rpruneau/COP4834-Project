<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdminTabs.ascx.cs" Inherits="MajorAdviser.ctrls.Admin.AdminTabs" %>
<%@ Register Src="~/ctrls/Admin/Degree.ascx" TagPrefix="uc1" TagName="Degree" %>
<%@ Register Src="~/ctrls/Admin/Courses.ascx" TagPrefix="uc1" TagName="Courses" %>
<%@ Register Src="~/ctrls/Admin/Category.ascx" TagPrefix="uc1" TagName="Category" %>
<%@ Register Src="~/ctrls/Admin/Major.ascx" TagPrefix="uc1" TagName="Major" %>
<%@ Register Src="~/ctrls/Admin/MajorCategory.ascx" TagPrefix="uc1" TagName="MajorCategory" %>
<%@ Register Src="~/ctrls/Admin/MajorCategoryCourse.ascx" TagPrefix="uc1" TagName="MajorCategoryCourse" %>

<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
    <ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="Category">
        <ContentTemplate>
            <uc1:Category runat="server" id="Category" />
        </ContentTemplate>
    </ajaxToolkit:TabPanel>
    <ajaxToolkit:TabPanel runat="server" ID="TabPanel2" HeaderText="Courses">
        <ContentTemplate>
            <uc1:Courses runat="server" ID="Courses" />
        </ContentTemplate>
    </ajaxToolkit:TabPanel>
    <ajaxToolkit:TabPanel runat="server" ID="TabPanel3" HeaderText="Degree">
        <ContentTemplate>
            <uc1:Degree runat="server" ID="Degree" />
        </ContentTemplate>
    </ajaxToolkit:TabPanel>
    <ajaxToolkit:TabPanel runat="server" ID="TabPanel4" HeaderText="Major">
        <ContentTemplate>
            <uc1:Major runat="server" id="Major" />
        </ContentTemplate>
    </ajaxToolkit:TabPanel>
    <ajaxToolkit:TabPanel runat="server" ID="TabPanel5" HeaderText="MajorCategory">
        <ContentTemplate>
            <uc1:MajorCategory runat="server" id="MajorCategory" />
        </ContentTemplate>
    </ajaxToolkit:TabPanel>
    <ajaxToolkit:TabPanel runat="server" ID="TabPanel6" HeaderText="MajorCategoryCourse">
        <ContentTemplate>
            <uc1:MajorCategoryCourse runat="server" id="MajorCategoryCourse" />
        </ContentTemplate>
    </ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
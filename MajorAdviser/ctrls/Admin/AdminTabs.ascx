<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdminTabs.ascx.cs" Inherits="MajorAdviser.ctrls.Admin.AdminTabs" %>
<%@ Register Src="~/ctrls/Admin/Degree.ascx" TagPrefix="uc1" TagName="Degree" %>
<%@ Register Src="~/ctrls/Admin/Courses.ascx" TagPrefix="uc1" TagName="Courses" %>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
    <ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="Degrees">
        <ContentTemplate>
            <uc1:Degree runat="server" id="Degree" />
        </ContentTemplate>
    </ajaxToolkit:TabPanel>
    <ajaxToolkit:TabPanel runat="server" ID="TabPanel2" HeaderText="Courses">
        <ContentTemplate>
            <uc1:Courses runat="server" ID="Courses" />
        </ContentTemplate>
    </ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
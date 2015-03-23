<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MajorAdviser.Admin.Default" %>
<%@ Register Src="~/ctrls/Admin/AdminTabs.ascx" TagPrefix="uc1" TagName="AdminTabs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Admin Panel</h1>
    <uc1:AdminTabs runat="server" id="AdminTabs" />
</asp:Content>

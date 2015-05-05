<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MajorAdviser.Student.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>Student Page</h1>
    </div>

    <h2>Completed Courses</h2>
    <asp:GridView ID="GridView1" runat="server"></asp:GridView>


</asp:Content>

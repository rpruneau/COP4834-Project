﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Major.ascx.cs" Inherits="MajorAdviser.ctrls.Admin.Major" %>
<h1>Majors</h1>
<asp:Label ID="ErrorMessage" runat="server" Text="Label"></asp:Label>
<asp:SqlDataSource 
    ID="SqlDataSource1" 
    runat="server" 
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
    SelectCommand="SELECT * FROM [Major]" 
    DeleteCommand="Delete From Major Where ID = @id" 
    InsertCommand="Insert Into Major (Code, Title, DegreeID) Values (@code, @title, @degreeId)" 
    UpdateCommand="UPDATE Major SET Code = @code, Title = @title, DegreeID = @degreeId Where ID = @id">
    <DeleteParameters>
        <asp:Parameter Name="id" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="code" />
        <asp:Parameter Name="title" />
        <asp:Parameter Name="degreeId" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="code" />
        <asp:Parameter Name="title" />
        <asp:Parameter Name="degreeId" />
        <asp:Parameter Name="id" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" 
    AutoGenerateColumns="False" 
    DataKeyNames="ID"
    OnRowCommand="GridView1_RowCommand"
    OnRowUpdated="GridView1_RowUpdated" ShowFooter="True">
    <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="ID">
            <EditItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:Button ID="AddButton" runat="server" Text="Add" CommandName="Add" />
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Code" SortExpression="Code">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Code") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="NewCode" runat="server"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Code") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Title" SortExpression="Title">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="NewTitle" runat="server"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="DegreeID" SortExpression="DegreeID">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("DegreeID") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:DropDownList ID="NewDegreeID" runat="server" DataSourceID="SqlDataSourceDegrees" DataTextField="Title" DataValueField="ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSourceDegrees" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [ID], [Title] FROM [Degree]"></asp:SqlDataSource>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("DegreeID") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
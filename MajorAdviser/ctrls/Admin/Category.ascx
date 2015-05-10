<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Category.ascx.cs" Inherits="MajorAdviser.ctrls.Admin.Category" %>
<h1>Categories</h1>
<asp:Label ID="ErrorMessage" runat="server" Text=""></asp:Label>
<asp:SqlDataSource 
    ID="SqlDataSource1" 
    runat="server" 
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
    SelectCommand="SELECT * FROM [Category]" 
    DeleteCommand="DELETE FROM Category WHERE (ID = @id)" 
    InsertCommand="INSERT INTO Category(Title) VALUES (@title)" 
    UpdateCommand="Update Category SET Title = @title Where ID = @id">
    <DeleteParameters>
        <asp:Parameter Name="id" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="title" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="title" />
        <asp:Parameter Name="id" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:GridView ID="GridView1" runat="server" 
    DataSourceID="SqlDataSource1" 
    AutoGenerateColumns="False" 
    DataKeyNames="ID"
    OnRowCommand="GridView1_RowCommand"
    OnRowUpdated="GridView1_RowUpdated" ShowFooter="True">
    <Columns>
        <asp:TemplateField ShowHeader="False">
            <EditItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="ID">
            <EditItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:Button ID="AddButton" runat="server" Text="Add" CommandName="Add" />
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Title" SortExpression="Title">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="NewTitle" runat="server"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
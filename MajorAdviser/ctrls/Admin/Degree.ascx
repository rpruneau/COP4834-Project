<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Degree.ascx.cs" Inherits="MajorAdviser.ctrls.Admin.Degree" %>
<h1>Degrees</h1>
<asp:Label ID="ErrorMessage" runat="server"></asp:Label>
<asp:SqlDataSource
    ID="SqlDataSource1"
    runat="server"
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
    SelectCommand="SELECT * FROM [Degree]" 
    DeleteCommand="DELETE FROM DEGREE WHERE ID = @id" 
    InsertCommand="INSERT INTO Degree(Code, Title) VALUES (@code, @title)" 
    UpdateCommand="UPDATE Degree SET Code = @code, Title = @title WHERE ID = @id">
    <DeleteParameters>
        <asp:Parameter Name="id" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="code" />
        <asp:Parameter Name="title" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="code" />
        <asp:Parameter Name="title" />
        <asp:Parameter Name="id" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:GridView ID="GridView1" runat="server" 
    DataSourceID="SqlDataSource1" 
    AutoGenerateColumns="False" 
    DataKeyNames="ID" 
    ShowFooter="True" 
    OnRowCommand="GridView1_RowCommand" 
    OnRowUpdated="GridView1_RowUpdated">
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
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Code" SortExpression="Code">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Code") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="NewCode" runat="server" Columns="10"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Code") %>'></asp:Label>
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
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

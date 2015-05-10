<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Courses.ascx.cs" Inherits="MajorAdviser.ctrls.Admin.Courses" %>
<h1>Courses</h1>
<asp:Label ID="ErrorMessage" runat="server" Text="Label"></asp:Label>
<asp:SqlDataSource 
    ID="SqlDataSource1" 
    runat="server" 
    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" 
    SelectCommand="SELECT * FROM [Course]" 
    DeleteCommand="Delete From Course Where ID = @id" 
    InsertCommand="Insert Into Course (Code, Title, Description, CreditHours) Values (@code, @title, @description, @creditHours)" 
    UpdateCommand="UPDATE Course SET Code = @code, Title = @title, Description = @description, CreditHours = @creditHours WHERE (ID = @id)">
    <DeleteParameters>
        <asp:Parameter Name="id" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="code" />
        <asp:Parameter Name="title" />
        <asp:Parameter Name="description" />
        <asp:Parameter Name="creditHours" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="code" />
        <asp:Parameter Name="title" />
        <asp:Parameter Name="description" />
        <asp:Parameter Name="creditHours" />
        <asp:Parameter Name="id" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" 
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
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
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
        <asp:TemplateField HeaderText="Description" SortExpression="Description">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Description") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="NewDescription" runat="server"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="CreditHours" SortExpression="CreditHours">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("CreditHours") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="NewCreditHours" runat="server"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label5" runat="server" Text='<%# Bind("CreditHours") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <%--<asp:BoundField DataField="ConcReqID" HeaderText="ConcReqID" SortExpression="ConcReqID" />--%>
    </Columns>
</asp:GridView>
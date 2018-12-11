<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Operations.aspx.cs" Inherits="WebFormExample.Operations" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    Найти топливо:<asp:TextBox ID="TextBoxFuel" runat="server" ></asp:TextBox>
    Найти емкость: <asp:DropDownList ID="DropDownListTank" runat="server" DataSourceID="SqlDataSourceTank" DataTextField="TankType" DataValueField="TankID" AutoPostBack="True"></asp:DropDownList>
    <br />
    <asp:Label ID="GridViewLabel" runat="server" Text="Операции" Font-Bold="true"/>

    <asp:GridView ID="GridViewOperations" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="OperationID" DataSourceID="SqlDataSourceOperation">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="OperationID" HeaderText="OperationID" InsertVisible="False" ReadOnly="True" SortExpression="OperationID" Visible="False" />
            <asp:TemplateField HeaderText="Топливо" SortExpression="FuelType">
                <EditItemTemplate>
                    <asp:DropDownList ID="FuelID" runat="server" DataSourceID="SqlDataSourceFuel" DataTextField="FuelType" DataValueField="FuelID" SelectedValue='<%# Bind("FuelID") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>                
                <ItemTemplate>
                 <asp:Label ID="FuelId" runat="server"  Text='<%# Eval("FuelType") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Емкость" SortExpression="TankID">
                <EditItemTemplate>
                    <asp:DropDownList ID="TankID" runat="server" DataSourceID="SqlDataSourceTank" DataTextField="TankType" DataValueField="TankID" SelectedValue='<%# Eval("TankID") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                 <asp:Label ID="TankId" runat="server"  Text='<%# Eval("TankType") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="Inc_Exp" HeaderText="Приход_Расход" SortExpression="Inc_Exp" />
            <asp:BoundField DataField="Date" HeaderText="Дата" SortExpression="Date" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSourceFuel" runat="server" 
        ConnectionString="<%$ ConnectionStrings:toplivoConnectionString %>" 
        SelectCommand="SELECT [FuelID], [FuelType] FROM [Fuels]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTank" runat="server" 
        ConnectionString="<%$ ConnectionStrings:toplivoConnectionString %>" 
        SelectCommand="SELECT [TankID], [TankType] FROM [Tanks]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceOperation" runat="server" 
        ConnectionString="<%$ ConnectionStrings:toplivoConnectionString %>"
        DeleteCommand="DELETE FROM [Operations] WHERE [OperationID] = @OperationID"
        InsertCommand="INSERT INTO [Operations] ([FuelID], [TankID], [Inc_Exp], [Date]) VALUES (@FuelID, @TankID, @Inc_Exp, @Date)"
        SelectCommand="SELECT Operations.OperationID, Operations.FuelID, Operations.TankID, Operations.Inc_Exp, Operations.Date, Tanks.TankType, Fuels.FuelType 
        FROM Operations INNER JOIN Tanks ON Operations.TankID = Tanks.TankID INNER JOIN Fuels ON Operations.FuelID = Fuels.FuelID 
        WHERE (Operations.TankID = @TankID) AND (Fuels.FuelType Like  '%'+@FuelType+'%')"
        UpdateCommand="UPDATE [Operations] SET [FuelID] = @FuelID, [TankID] = @TankID, [Inc_Exp] = @Inc_Exp, [Date] = @Date WHERE [OperationID] = @OperationID">
        <DeleteParameters>
            <asp:Parameter Name="OperationID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="FuelID" Type="Int32" />
            <asp:Parameter Name="TankID" Type="Int32" />
            <asp:Parameter Name="Inc_Exp" Type="Single" />
            <asp:Parameter DbType="Date" Name="Date" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListTank" DefaultValue="1" Name="TankID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="TextBoxFuel" DefaultValue="A" Name="FuelType" PropertyName="Text"/>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FuelID" Type="Int32" />
            <asp:Parameter Name="TankID" Type="Int32" />
            <asp:Parameter Name="Inc_Exp" Type="Single" />
            <asp:Parameter DbType="Date" Name="Date"/>
            <asp:Parameter Name="OperationID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

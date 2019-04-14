<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Operations.aspx.cs" Inherits="WebFormExample.Operations" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    Найти топливо:<asp:TextBox ID="TextBoxFuel" runat="server"></asp:TextBox>
    Найти емкость: <asp:DropDownList ID="DropDownListTank" runat="server" DataSourceID="SqlDataSourceTank" DataTextField="TankType" DataValueField="TankID" AutoPostBack="True"></asp:DropDownList>
    <asp:FormView ID="FormViewInsert" runat="server" DataSourceID="SqlDataSourceOperations" DataKeyNames="OperationID">       
        <InsertItemTemplate>
            <h4>Добавить:</h4>
            Топливо:
            <asp:DropDownList ID="FuelIDDropDownList" runat="server"  DataSourceID="SqlDataSourceFuel" DataTextField="FuelType" DataValueField="FuelID" SelectedValue='<%# Bind("FuelID") %>'>
            </asp:DropDownList>
            <br />
            Емкость:
            <asp:DropDownList ID="TankIDDropDownList" runat="server"  DataSourceID="SqlDataSourceTank" DataTextField="TankType" DataValueField="TankID" SelectedValue='<%# Bind("TankID") %>'>
            </asp:DropDownList>
            <br />
            Приход_Расход:
            <asp:TextBox ID="Inc_ExpTextBox" runat="server" Text='<%# Bind("Inc_Exp") %>' />
            <br />
            Дата:
            <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Вставка" />
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
        </InsertItemTemplate>
           <ItemTemplate>
           <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="Добавить операцию" />
        </ItemTemplate>
</asp:FormView>

    <asp:Label ID="GridViewLabel" runat="server" Text="Операции" Font-Bold="true"/>

    <asp:GridView ID="GridViewOperations" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="OperationID" DataSourceID="SqlDataSourceOperations">
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

            <asp:BoundField DataField="Inc_Exp" HeaderText="Inc_Exp" SortExpression="Inc_Exp" />
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
    <asp:SqlDataSource ID="SqlDataSourceOperations" runat="server" 
        ConnectionString="<%$ ConnectionStrings:toplivoConnectionString %>"
        DeleteCommand="DELETE FROM [Operations] WHERE [OperationID] = @OperationID"
        InsertCommand="INSERT INTO [Operations] ([FuelID], [TankID], [Inc_Exp], [Date]) VALUES (@FuelID, @TankID, @Inc_Exp, @Date)"
        SelectCommand="SELECT Operations.OperationID, Operations.FuelID, Operations.TankID, Operations.Inc_Exp, Operations.Date, Tanks.TankType, Fuels.FuelType 
        FROM Operations INNER JOIN Tanks ON Operations.TankID = Tanks.TankID INNER JOIN Fuels ON Operations.FuelID = Fuels.FuelID 
        WHERE (Operations.TankID = @TankID) AND (Fuels.FuelType Like '%'+ISNULL(@FuelType,'')+'%')"
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
            <asp:ControlParameter ControlID="TextBoxFuel"  Name="FuelType" PropertyName="Text" DefaultValue="" ConvertEmptyStringToNull="False" DbType="String"/>

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

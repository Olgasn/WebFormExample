<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tanks.aspx.cs" Inherits="WebFormExample.Tanks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    Найти емкость:<asp:TextBox ID="TextBoxTank" runat="server" Width="15%" Text=""></asp:TextBox>
    <asp:FormView ID="FormViewInsert" runat="server" DataKeyNames="TankID" DataSourceID="SqlDataSourceTanks">
        <InsertItemTemplate>
           <h4>Добавить:</h4>
            Емкость:
            <asp:TextBox ID="TankTypeTextBox" runat="server" Text='<%# Bind("TankType") %>' />
            <br />
            Объем:
            <asp:TextBox ID="TankVolumeTextBox" runat="server" Text='<%# Bind("TankVolume") %>' />
            <br />
            Вес:
            <asp:TextBox ID="TankWeightTextBox" runat="server" Text='<%# Bind("TankWeight") %>' />
            <br />
            Материал:
            <asp:TextBox ID="TankMaterialTextBox" runat="server" Text='<%# Bind("TankMaterial") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Вставка" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
        </InsertItemTemplate>
        <ItemTemplate>
            <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="Добавить емкость" />
        </ItemTemplate>
    </asp:FormView>
                <br />

    <asp:Label ID="GridViewLabel" runat="server" Text="Емкости" Font-Bold="true"></asp:Label>

<asp:GridView ID="GridViewTank" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="TankID" DataSourceID="SqlDataSourceTanks">
    <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        <asp:BoundField DataField="TankID" HeaderText="Код" InsertVisible="False" ReadOnly="True" SortExpression="TankID" />
        <asp:BoundField DataField="TankType" HeaderText="Наименование" SortExpression="TankType" />
        <asp:BoundField DataField="TankVolume" HeaderText="Объем" SortExpression="TankVolume" />
        <asp:BoundField DataField="TankWeight" HeaderText="Вес" SortExpression="TankWeight" />
        <asp:BoundField DataField="TankMaterial" HeaderText="Материал" SortExpression="TankMaterial" />
        <asp:BoundField DataField="TankPicture" HeaderText="Изображение" SortExpression="TankPicture" />
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSourceTanks" runat="server" 
    ConnectionString="<%$ ConnectionStrings:toplivoConnectionString %>" 
    SelectCommand="SELECT * FROM [Tanks] WHERE ((TankType LIKE '%'+ ISNULL(@TankType,'')+'%'))" 
    DeleteCommand="DELETE FROM [Tanks] WHERE [TankID] = @TankID" 
    UpdateCommand="UPDATE [Tanks] SET [TankType] = @TankType, [TankVolume] = @TankVolume, [TankWeight] = @TankWeight, [TankMaterial] = @TankMaterial, [TankPicture] = @TankPicture WHERE [TankID] = @TankID" 
    InsertCommand="INSERT INTO [Tanks] ([TankType], [TankVolume], [TankWeight], [TankMaterial], [TankPicture]) VALUES (@TankType, @TankVolume, @TankWeight, @TankMaterial, @TankPicture)">
    <DeleteParameters>
        <asp:Parameter Name="TankID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="TankType" Type="String" />
        <asp:Parameter Name="TankVolume" Type="Single" />
        <asp:Parameter Name="TankWeight" Type="Single" />
        <asp:Parameter Name="TankMaterial" Type="String" />
        <asp:Parameter Name="TankPicture" Type="String" />
    </InsertParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="TextBoxTank"  Name="TankType" PropertyName="Text" DefaultValue="" ConvertEmptyStringToNull="False" DbType="String"/>
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="TankType" Type="String" />
        <asp:Parameter Name="TankVolume" Type="Single" />
        <asp:Parameter Name="TankWeight" Type="Single" />
        <asp:Parameter Name="TankMaterial" Type="String" />
        <asp:Parameter Name="TankPicture" Type="String" />
        <asp:Parameter Name="TankID" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>

</asp:Content>

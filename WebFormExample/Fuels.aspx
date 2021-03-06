﻿<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Fuels.aspx.cs" Inherits="WebFormExample.Fuels" %>
   <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   <asp:FormView ID="FormViewInsert" runat="server" DataKeyNames="FuelID" DataSourceID="SqlDataSourceFuels">
       <InsertItemTemplate>
            <h4>Добавить:</h4>
            Топливо:
            <asp:TextBox ID="FuelTypeTextBox" runat="server" Text='<%# Bind("FuelType") %>' />
            <br />
            Плотность:
            <asp:TextBox ID="FuelDensityTextBox" runat="server" Text='<%# Bind("FuelDensity") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Вставка" />
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
        </InsertItemTemplate>
        <ItemTemplate>
            <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="Добавить топливо" />
        </ItemTemplate>
    </asp:FormView>
        
    <asp:Label ID="GridViewLabel" runat="server" Text="Виды топлива" Font-Bold="true" />
    <asp:GridView ID="GridViewFuel" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="FuelID" 
        DataSourceID="SqlDataSourceFuels">
    <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        <asp:BoundField DataField="FuelID" HeaderText="Код" InsertVisible="False" ReadOnly="True" SortExpression="FuelID" />
        <asp:BoundField DataField="FuelType" HeaderText="Наименование" SortExpression="FuelType" />
        <asp:BoundField DataField="FuelDensity" HeaderText="Плотность" SortExpression="FuelDensity" />
    </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSourceFuels" runat="server" 
        ConnectionString="<%$ ConnectionStrings:toplivoConnectionString %>" 
        DeleteCommand="DELETE FROM [Fuels] WHERE [FuelID] = @FuelID" 
        InsertCommand="INSERT INTO [Fuels] ([FuelType], [FuelDensity]) VALUES (@FuelType, @FuelDensity)" 
        SelectCommand="SELECT * FROM [Fuels]" 
        UpdateCommand="UPDATE [Fuels] SET [FuelType] = @FuelType, [FuelDensity] = @FuelDensity WHERE [FuelID] = @FuelID">
        <DeleteParameters>
            <asp:Parameter Name="FuelID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="FuelType" Type="String" />
            <asp:Parameter Name="FuelDensity" Type="Single" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="FuelType" Type="String" />
            <asp:Parameter Name="FuelDensity" Type="Single" />
            <asp:Parameter Name="FuelID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    </asp:Content>

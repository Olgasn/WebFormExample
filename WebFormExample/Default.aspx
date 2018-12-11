<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebFormExample._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<asp:Label ID="GridViewLabel" runat="server" Text="Топливная база" Font-Bold="true" />

<asp:GridView ID="GridViewFuel" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="FuelID" DataSourceID="SqlDataSourceFuel">
    <Columns>
        <asp:BoundField DataField="FuelID" HeaderText="Код" InsertVisible="False" ReadOnly="True" SortExpression="FuelID" />
        <asp:BoundField DataField="FuelType" HeaderText="Название" SortExpression="FuelType" />
        <asp:BoundField DataField="FuelDensity" HeaderText="Плотность" SortExpression="FuelDensity" />
    </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSourceFuel" runat="server" ConnectionString="<%$ ConnectionStrings:toplivoConnectionString %>" 
        SelectCommand="SELECT * FROM [Fuels]">
    </asp:SqlDataSource>

    </asp:Content>

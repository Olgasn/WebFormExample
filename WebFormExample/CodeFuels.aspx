﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CodeFuels.aspx.cs" Inherits="WebFormExample.CodeFuels" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <br />
<table border="0">
    <tr>
    <td>

    <asp:Label ID="LabelFindFuel" runat="server" Text="Label">Топливо</asp:Label><asp:TextBox ID="TextBoxFindFuel" runat="server"></asp:TextBox>
        <asp:Button ID="ButtonFindFuel" runat="server" Text="Найти" OnClick="ButtonFindFuel_Click" />
    <br />
        <strong>Виды топлива</strong>
        <asp:GridView ID="GridViewFuel" runat="server" AutoGenerateColumns="False"
            AllowPaging="True" 
            AllowSorting="True" 
            AutoGenerateDeleteButton="True" 
            AutoGenerateEditButton="True" 
            EnableSortingAndPagingCallbacks="True" 
            OnRowCancelingEdit="GridViewFuel_RowCancelingEdit" 
            OnRowDeleting="GridViewFuel_RowDeleting" 
            OnRowEditing="GridViewFuel_RowEditing" 
            OnRowUpdating="GridViewFuel_RowUpdating" PageSize="15" >
            <Columns>
                <asp:BoundField DataField="FuelId" HeaderText="Код" SortExpression="FuelId" />
                <asp:BoundField DataField="FuelType" HeaderText="Название" SortExpression="FuelType" />
                <asp:BoundField DataField="FuelDensity" HeaderText="Плотность" SortExpression="FuelDensity" />
            </Columns>

    </asp:GridView>
        </td>
        <td>
        <strong>Добавить новый вид топлива:</strong>
            <br />
            Вид топлива:<asp:TextBox ID="TextBoxFuelType" runat="server"></asp:TextBox>
            <br />
            Плотность топлива:<asp:TextBox ID="TextBoxFuelDensity" runat="server"></asp:TextBox>
            <br />
            <asp:RangeValidator runat="server" ID="ValidateFuelDensity" ControlToValidate="TextBoxFuelDensity" 
                MinimumValue=0 MaximumValue="3" Type="Double" ErrorMessage="Значение плотности не входит в указанный диапазон" Display="dynamic" 
                SetFocusOnError="True">*
            </asp:RangeValidator>
            <asp:ValidationSummary runat="server" ID="Summary" DisplayMode="BulletList"  HeaderText="<b>Пожалуйста, исправьте следующие ошибки: </b>" ShowSummary="true" />
            <br />
            <asp:Button ID="ButtonAddFuel" runat="server" Text="Добавить" OnClick="ButtonAddFuel_Click" />

        </td>
</tr>
</table>
    </asp:Content>

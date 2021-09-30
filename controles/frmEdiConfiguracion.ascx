<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frmEdiConfiguracion.ascx.cs" Inherits="frmEdiConfiguracion" %>
<asp:HiddenField ID="hdnCod_Vehiculo" runat="server" />
<table class="tablaBordeNegro" width="100%">
    <tr>
        <td>
            Vehículo</td>
        <td>
            :</td>
        <td style="text-align: left">
            <asp:Label ID="lblRefVehiculo" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            Cantidad Hora Inicial</td>
        <td>
            :</td>
        <td>
            <asp:TextBox ID="txtCantidadHoraInicial" runat="server" ValidationGroup="GuardarConfiguracion"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RFVtxtCantidadHoraInicial" runat="server" ControlToValidate="txtCantidadHoraInicial"
                ErrorMessage="*" ValidationGroup="GuardarConfiguracion"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="REVtxtCantidadHoraInicial" runat="server" ControlToValidate="txtCantidadHoraInicial"
                ErrorMessage="*" ValidationExpression="\d+" ValidationGroup="GuardarConfiguracion">*</asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td>
            Límite Hora Alerta</td>
        <td>
            :</td>
        <td>
            <asp:TextBox ID="txtLimiteHoraAlerta" runat="server" ValidationGroup="GuardarConfiguracion"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RFVLimiteHoraAlerta" runat="server" ControlToValidate="txtLimiteHoraAlerta"
                ErrorMessage="*" ValidationGroup="GuardarConfiguracion"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="REVLimiteHoraAlerta" runat="server" ControlToValidate="txtLimiteHoraAlerta"
                ErrorMessage="*" ValidationExpression="\d+" ValidationGroup="GuardarConfiguracion">*</asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td>
            Límite Hora Mantención</td>
        <td>
            :</td>
        <td>
            <asp:TextBox ID="txtLimiteHoraMantencion" runat="server" ValidationGroup="GuardarConfiguracion"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RFVLimiteHoraMantencion" runat="server" ControlToValidate="txtLimiteHoraMantencion"
                ErrorMessage="*" ValidationGroup="GuardarConfiguracion"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="REVLimiteHoraMantencion" runat="server" ControlToValidate="txtLimiteHoraMantencion"
                ErrorMessage="*" ValidationExpression="\d+" ValidationGroup="GuardarConfiguracion">*</asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td>
            Cantidad Hora Actual</td>
        <td>
            :</td>
        <td style="text-align: left">
            <asp:Label ID="lblCantidadHoraActual" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            Unidad Medida</td>
        <td>
            :</td>
        <td style="text-align: left">
            <asp:DropDownList ID="ddlUnidadMedida" runat="server" AppendDataBoundItems="True">
                <asp:ListItem Value="0">- Seleccione -</asp:ListItem>
            </asp:DropDownList></td>
    </tr>
    <tr>
        <td>
            Estado</td>
        <td>
            :</td>
        <td>
            <asp:Image ID="imgEstado" runat="server" ImageUrl="~/img/spacer.gif" />
        </td>
    </tr>
    </table>
<asp:CheckBox ID="chkRegistroNuevo" runat="server" Visible="False" />

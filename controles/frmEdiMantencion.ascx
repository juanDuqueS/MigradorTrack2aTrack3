<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frmEdiMantencion.ascx.cs" Inherits="frmEdiMantencion" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v7.3, Version=7.3.20073.38, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v7.3, Version=7.3.20073.38, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %> 
<asp:HiddenField ID="hdnCod_Vehiculo" runat="server" />
<table width="100%">
    <tr>
        <td valign="top" style="width: 200px; text-align: right;" class="textoNormal">Fecha Mantención</td>
        <td valign="top">:</td>
        <td style="text-align: left">
			<igsch:WebDateChooser ID="wdcManFecha" runat="server" DropDownAlignment="Right"
				EnableAppStyling="True" Font-Names="Verdana" Font-Size="X-Small" StyleSetName="Nautilus"
				Value="" Width="90px">
				<CalendarLayout FirstDayOfWeek="Monday">
				</CalendarLayout>
			</igsch:WebDateChooser>
        </td>
    </tr>
    <tr>
        <td valign="top" style="text-align: right" class="textoNormal">Horómetro</td>
        <td valign="top">:</td>
        <td style="text-align: left">
            <igtxt:webnumericedit id="txtManHorometro" runat="server" maxlength="10" minvalue="0" width="80px" DataMode="Int"></igtxt:webnumericedit>
            <asp:RequiredFieldValidator ID="rfvManHorometro" runat="server" ControlToValidate="txtManHorometro" ErrorMessage="*" ValidationGroup="GuardarMantencion">*</asp:RequiredFieldValidator></td>
    </tr>
    <tr>
        <td valign="top" style="text-align: right" class="textoNormal">Comentario</td>
        <td valign="top">:</td>
        <td style="text-align: left">
            <asp:TextBox ID="txtManComentario" runat="server" Rows="5" TextMode="MultiLine" Width="350" ValidationGroup="GuardarMantencion"></asp:TextBox></td>
    </tr>
    <tr>
        <td valign="top" style="text-align: right" class="textoNormal">Informe</td>
        <td valign="top">:</td>
        <td style="text-align: left">
            <asp:FileUpload ID="fuplManInforme" runat="server" Width="350px" /></td>
    </tr>
    <tr>
        <td valign="top" style="text-align: right" class="textoNormal">Horómetro Actual</td>
        <td valign="top">:</td>
        <td style="text-align: left">
            <igtxt:webnumericedit id="txtHorometroActualPrevio" runat="server" maxlength="10" minvalue="0" width="80px" DataMode="Int"></igtxt:webnumericedit>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtHorometroActualPrevio" ErrorMessage="*" ValidationGroup="GuardarMantencion">*</asp:RequiredFieldValidator>
            <asp:Label ID="lblHorometroActual" runat="server"></asp:Label>                
        </td>
    </tr>   
</table>
<asp:CheckBox ID="chkRegistroNuevo" runat="server" Visible="False" />

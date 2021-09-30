<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frmModuloUsuario.ascx.cs" Inherits="frmModuloUsuario" %>
<link href="../css/menuTabUser.css" rel="stylesheet" type="text/css" />
<table width="100%" cellspacing="0" cellpadding="0" border="0" id="barraNavegacion" style="position:absolute;top:0px;left:0px;height:31px;" class="hidden">
    <tr style="background-image:url(../img/topbg.png)">
	    <td>
		    <table width="100%" cellspacing="0" cellpadding="0" border="0">
			    <tr style="background-image:url(../img/topbg.png)">
				    <td style="text-align:left;padding-left:0px"><asp:Literal ID="ltModulosUsuario" runat="server"></asp:Literal></td>
				    <td style="text-align:right; border-bottom:2px solid black; padding:0px 15px 0px 0px"><div id="dvnomModulo"><asp:Literal ID="ltNomModulo" runat="server"></asp:Literal></div></td>
			    </tr>
		    </table>
	    </td>
    </tr>
</table>
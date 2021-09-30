<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Online GPSChile</title>
    <link rel="SHORTCUT ICON" href="http://online.gpschile.com/img/favicongps.ico"/>
    <link href="../css/GPSChile.css" rel="stylesheet" type="text/css" />

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<!--Reset-->
    <link href="css/normalize.css" rel="stylesheet">
    <!--Fuente-->
    <link href='http://fonts.googleapis.com/css?family=Pontano+Sans' rel='stylesheet' type='text/css'>
    <!--Iconos-->
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">
    <!--Bootstrap 3-->
    <link href="css/bootstrap.css" rel="stylesheet">
    <!--CSS Personalizado-->
    <link href="css/style.css" rel="stylesheet">

    <%--<style type="text/css">body{background-color:#063e61;font-size:10px;font-family:Verdana;margin-top:2px;margin-bottom:0px;margin-left:0px;margin-right:0px;}</style>--%>
    <script src="../javascript/jquery.core.js" language="javascript" type="text/javascript"></script>
    <script src="../javascript/jquery.ui.js" language="javascript" type="text/javascript"></script> 
    <script type="text/javascript" src="../javascript/login/general.js"></script>  
	<script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

	  ga('create', 'UA-45951920-1', 'gpschile.com');
	  ga('send', 'pageview');

	</script>
		
</head>
<%--<body>
    <form id="form1" runat="server">
    <div>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="height: 100px">
                    <asp:ScriptManager ID="smLogin" runat="server"></asp:ScriptManager>
                </td>
                <td>
                </td>
                <td style="width: 157px">
                </td>
                <td style="width: 157px">
                </td>
            </tr>
            <tr>
                <td class="fondoImagenCeldaLogin">
                </td>
                <td class="fondoImagenCeldaLogin">
                    <img src="../img/logoGrande.jpg" alt="GPS Chile" />
                </td>
                <td class="fondoImagenCeldaLogin" style="width: 157px">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                    <table style="width: 120px">
                        <tr>
                            <td style="text-align: right" class="textoNormal">
                                Usuario
                            </td>
                            <td class="textoNormal" style="text-align: right">
                                :</td>
                            <td>
                                <asp:TextBox ID="textbox_login" runat="server" ValidationGroup="validaLogin"></asp:TextBox></td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvLogin" runat="server" ControlToValidate="textbox_login"
                                    ErrorMessage="*" SetFocusOnError="True" ValidationGroup="validaLogin">*</asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td style="text-align: right" class="textoNormal">
                                Clave</td>
                            <td class="textoNormal" style="text-align: right">
                                :</td>
                            <td>
                                <asp:TextBox ID="textbox_password" runat="server" TextMode="Password" ValidationGroup="validaLogin"></asp:TextBox></td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="textbox_password"
                                    ErrorMessage="*" SetFocusOnError="True" ValidationGroup="validaLogin">*</asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td class="textoNormal" style="text-align: right">
                            </td>
                            <td class="textoNormal" style="text-align: right">
                            </td>
                            <td style="text-align: right">
                                <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Entrar" ValidationGroup="validaLogin" /></td>
                            <td style="text-align: right">
                            </td>
                        </tr>
                        <tr>
                            <td class="textoNormal" colspan="3" style="text-align: center">
                                    <div class="titulo" style="width:100%;text-align:right" id="divLabel_login">
                                        <asp:Label ID="label_login" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small" ForeColor="#C00000"></asp:Label>
                                    </div>                                
                             </td>
                            <td class="textoNormal" colspan="1" style="text-align: center">
                            </td>
                        </tr>
                    </table>
        <asp:HiddenField ID="hdnPageWidth" runat="server" />
                            <asp:HiddenField ID="hdnPageHeight" runat="server" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td class="fondoImagenCeldaLogin" style="width: 157px">
                </td>
            </tr>
            <tr>
                <td style="width: 20%">
                </td>
                <td>
                </td>
                <td style="width: 20%">
                </td>
                <td style="width: 40%">
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 19px; text-align: center">
                    <asp:HyperLink ID="hplGpsChile" runat="server" CssClass="textoNormalBlanco" NavigateUrl="http://www.gpschile.com">www.gpschile.com</asp:HyperLink></td>
            </tr>
        </table>
    </div>
    </form>
    <%--<script language="javascript" type="text/javascript">document.getElementById('textbox_login').focus();</script>--%>
<%--</body>--%>

<%-- Se modificaron: D:\Proyectos\CodigoFuente\UI\App_Themes\GPSkin\GPSChile.skin --%>

<body runat="server">
	<!--CONTAINER PRINCIPAL-->
    <form runat="server">
    <div class="container-fluid">
	<!--HEADER-->
		<div class="row row-header hidden-xs" style="padding-top:1%;padding-bottom:1%;">
 			<div class="col-xs-offset-2 col-md-3 col-md-offset-2" >
 				<img src="login-screen/logo-gpschile.png" style="width:90%;max-width: 240px; margin-right:8%;"/>
 				<img src="login-screen/line-logo-separator.png" />
 			</div>
 			<div class="col-md-7 header-text-md" style="">
 				<font color="99ccff">Plataforma de Integración</font>
 			</div>
 		</div>

 		<div class="row row-header visible-xs">
 			<div class="col-xs-4 col-xs-offset-2" >
 				<img src="login-screen/logo-gpschile.png" style="max-width: 240px;"/>
 			</div>
 			<div class="col-xs-12 col-md-7 header-text-xs" style="">
 				<font color="99ccff" size="6">Plataforma de Integración</font>
 			</div>
 		</div>
 	<!--FIN HEADER-->

    
 	    <!-- CONTENEDOR CENTRAL (LOGIN [TABLETS - DESKTOP]) -->
 		<div id="DispositivosXL" class="row hidden-xs login-container-md" style="padding-top:1%;padding-bottom:1%;" >
 			<div class="col-md-4 col-md-offset-4" style="padding:0" >
 				<div class="jumbotron jumbo-fix">
	 				<div class="text-center">
	 					<img src="login-screen/thumbnail-user.png" style="margin-bottom:10px;"/>
	 				</div>
				    <%--<form role="form">--%>
				    	<div class="form-group">

						    <div class="input-group">
						      <div class="input-group-addon bk-almost border-almost"><i class="fa fa-user"  style="width:14px"></i></div>
						      <img src="login-screen/arrow-pick.png" style="position:absolute;top: 13px; left: 36px;"/>
						      <asp:TextBox ID="textbox_login" runat="server" ValidationGroup="validaLogin" placeholder="Ingrese Usuario" class="form-control border-almost" style="position:static;"/>
                              <%--<input class="form-control border-almost" type="text" placeholder="Ingrese Usuario" style="position:static;">--%>
						    </div>
						 </div>
						 <div class="form-group">
						    <div class="input-group">
						      <div class="input-group-addon bk-almost border-almost"><i class="fa fa-key"></i></div>
						      <img src="login-screen/arrow-pick.png" style="position:absolute;top: 13px; left: 36px;"/>
						      <asp:TextBox ID="textbox_password" runat="server" TextMode="Password" ValidationGroup="validaLogin" placeholder="Ingrese Contraseña" class="form-control border-almost" style="position:static;" ></asp:TextBox>
                                <%--<input class="form-control border-almost" type="password" placeholder="Ingrese Contraseña" style="position:static;">--%>
						    </div>
						 </div>
						 <%--<a href="" style="text-decoration:none;">¿Olvido su contraseña?</a>--%>
						  <div class="checkbox text-right">
						    <%--<label>
						      <input type="checkbox"> Recordarme&nbsp;
						    </label>--%>
						    <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Entrar" class="btn btn-primary btn-blue" />
                              <%--<button type="submit" class="btn btn-primary btn-blue">Entrar</button>--%>
						  </div>
                        <asp:Label ID="label_login" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
					<%--</form>--%>

				</div >
				<div class="col-md-12">
	 				<img src="login-screen/shadow-form.png" style="width:100%;">
	 			</div>
 			</div>
 		</div>
 		<!-- FIN CONTENEDOR CENTRAL (LOGIN [TABLETS - DESKTOP]) -->

 		<!-- CONTENEDOR CENTRAL (LOGIN [DISPOSITIVOS PEQUEÑOS]) -->
 		<div id="DispositivosXS" class="row visible-xs login-container-xs" >
 			<div class="col-xs-12" style="padding:0" >
 				<div class="jumbotron jumbo-fix">
	 				<div class="text-center">
	 					<img src="login-screen/thumbnail-user.png" style="margin-bottom:10px;">
	 				</div>
				    <%--<form role="form">--%>
					    <div class="form-group">
						    <div class="input-group">
						      <div class="input-group-addon bk-almost border-almost"><i class="fa fa-user"  style="width:14px"></i></div>
						      <img src="login-screen/arrow-pick.png" style="position:absolute;top: 13px; left: 36px;">
                                <asp:TextBox ID="textbox_login1" runat="server" ValidationGroup="validaLogin" placeholder="Ingrese Usuario" class="form-control border-almost" style="position:static;"/>
						      <%--<input class="form-control border-almost" type="text" placeholder="Ingrese Usuario" style="position:static;">--%>
						    </div>
						 </div>
						 <div class="form-group">
						    <div class="input-group">
						      <div class="input-group-addon bk-almost border-almost"><i class="fa fa-key"></i></div>
						      <img src="login-screen/arrow-pick.png" style="position:absolute;top: 13px; left: 36px;">
                                <asp:TextBox ID="textbox_password1" runat="server" TextMode="Password" ValidationGroup="validaLogin" placeholder="Ingrese Contraseña" class="form-control border-almost" style="position:static;" ></asp:TextBox>
						      <%--<input class="form-control border-almost" type="password" placeholder="Ingrese Contraseña" style="position:static;">--%>
						    </div>
						 </div>
						 <%--<a href="" style="text-decoration:none;">¿Olvido su contraseña?</a>--%>
						  <div class="checkbox text-right">
						    <%--<label>
						      <input type="checkbox"> Recordarme&nbsp;
						    </label>--%>
                            <%--<asp:Button ID="btnLogin1" runat="server" OnClick="btnLogin1_Click" Text="Entrar" class="btn btn-primary btn-blue" />--%>
						    <asp:Button ID="btnLogin1" runat="server" Text="Entrar" class="btn btn-primary btn-blue" OnClick="btnLogin1_Click" /><%--<button type="submit" class="btn btn-primary btn-blue">Entrar</button>--%>
						  </div>
                        <asp:Label ID="label_login1" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
					<%--</form>--%>

				</div >
				<div class="col-xs-12">
	 				<img src="login-screen/shadow-form.png" style="width:100%">
	 			</div>
 			</div>
 		</div>
 		<!-- FIN CONTENEDOR CENTRAL (LOGIN [DISPOSITIVOS PEQUEÑOS]) -->

 		<!-- CONTENEDOR FINAL ([TABLETS - DESKTOP]) -->
 		<div class="row hidden-xs" style="margin-top:20px;">
 			<div class="col-xs-12 col-md-2 col-md-offset-2 text-center">
 				<button type="button" class="btn btn-primary btn-blue" onclick="window.open('http://ssl7.net/chat/es/341792aab54b73221bd293e3cfdd/'+document.location.href,'','height=400,width=300,menubar=no, location=no,resizable=yes,scrollbars=no,status=yes');">
 				<i class="fa fa-comment" style="color:white"></i> Chat On-Line</button>
 				<p class="text-muted">(Lun-Vie 8:30am-6:30pm.)</p>
 			</div>
 			<div class="col-xs-12 col-md-5 col-md-offset-1 text-right ">
 				<font color="#999999" size="4">Atenci&oacute;n Clientes: </font>
 				<font color="357ebd" size="4">&#09; +56 02 29404911</font><br>
 				<font color="#999999" size="4">Cont&aacute;ctenos: </font>
                <font color="357ebd" size="4">&#09; info@gpschile.com</font><br>
 				<%--<a href="" style="color:#999999; text-decoration:none;"><font size="4">Preguntas Frecuentes   </font><i class="fa fa-arrow-circle-left"></i></a>--%>
 			</div>
 		</div>
 		<!-- FIN CONTENEDOR FINAL ([TABLETS - DESKTOP]) -->

 		<!-- CONTENEDOR FINAL ([DISPOSITIVOS PEQUEÑOS]) -->
 		<div class="row visible-xs" style="margin-top:20px; margin-bottom:50px;">
 			<div class="col-xs-12 text-center">
 				<button type="button" class="btn btn-primary btn-blue" onclick="window.open('http://ssl7.net/chat/es/341792aab54b73221bd293e3cfdd/'+document.location.href,'','height=400,width=300,menubar=no, location=no,resizable=yes,scrollbars=no,status=yes');">
 				<i class="fa fa-comment" style="color:white"></i> Chat On-Line</button>
 				<p class="text-muted">(Lun-Vie 8:30am-6:30pm.)</p>
 			</div>
 			<div class="col-xs-12 text-center">
 				<font color="#999999" size="4">Atención Cliente: </font><br>
 				<font color="357ebd" size="4">+56 02 29404911</font><br>
 				<font color="#999999" size="4">Cont&aacute;ctenos: </font><br>
                 <font color="357ebd" size="4">info@gpschile.com</font><br>
 				<%--<a href="#" style="color:#999999; text-decoration:none;"><font size="4">Preguntas Frecuentes   </font></a>--%>
 			</div>
 		</div>
		<!-- FIN CONTENEDOR FINAL ([DISPOSITIVOS PEQUEÑOS]) -->
	    
        </div>
        </form>
	<!-- FIN CONTAINER PRINCIPAL-->

	<!-- FOOTER [TABLETS - DESKTOP] -->
	<div class="footer hidden-xs" style="position:absolute;">
      <div class="container">
        <p class="text-muted footer-text" ><a href="http://www.gpschile.com" style="color:#777;"> www.gpschile.com</a> Copyright 2014. Todos los derechos reservados.</p>
      </div>
    </div>
    <!-- FIN FOOTER [TABLETS - DESKTOP] -->

    <!-- FOOTER [DISPOSITIVOS PEQUEÑOS] -->
    <div class="footer visible-xs" style="height:47px">
      <div class="container">
        <p class="text-muted footer-text"><a href="http://www.gpschile.com" style="color:#777;"> www.gpschile.com</a> Copyright 2014. <br>Todos los derechos reservados.</p>
      </div>
    </div>
    <!-- FIN FOOTER [DISPOSITIVOS PEQUEÑOS] -->

    <!-- CHAT [CODIGO WEBSITECHAT] -->
    <script type="text/javascript">
        var xCtD = new Date(); var xCtURL = (("https:" == document.location.protocol) ? "https://static.ssl7.net/" : "http://static.ssl7.net/");
        document.write(unescape("%3Cscript src='" + xCtURL + "b/3bf77f837989a17bfd9bfb1955.js?dc=" + xCtD.getTime() + "' type='text/javascript'%3E%3C/script%3E"));
    </script>
    <script src="http://static.ssl7.net/b/3bf77f837989a17bfd9bfb1955.js?dc=1415382791477" type="text/javascript"></script>
    <!-- FIN CHAT [CODIGO WEBSITECHAT] -->
</body>
</html>

using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using FWKgpschile.SqlServer;

public partial class Login : System.Web.UI.Page
{
    public string _sistema = "online.gpschile.com";

    protected void Page_Load(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, typeof(string), "widthPage", "setTimeout('hdnPageWidth();',1000);", true);
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        //se crea objeto usuario...  codUsuario = 0
        clsUsuario usuario = new clsUsuario();

        if (textbox_login1.Text != "" || textbox_password1.Text != "")
        {
            btnLogin1_Click(sender, e);
        }
        else
        {

            if (textbox_login.Text == "")
            {
                label_login.Text = "<img src='../img/error.png' alt=''>&nbsp;Debe ingresar nombre de usuario.";
                ScriptManager.RegisterStartupScript(this, typeof(string), "fadeout", "fadeOut();", true);
            }
            else if (textbox_password.Text == "")
            {
                label_login.Text = "<img src='../img/error.png' alt=''>&nbsp;Debe ingresar contraseña. ";
                ScriptManager.RegisterStartupScript(this, typeof(string), "fadeout", "fadeOut();", true);
            }
            else
            {
                string msjeIngreso = usuario.validaAccesoSistema(textbox_login.Text, textbox_password.Text, _sistema);

                if (msjeIngreso == "OK")
                {
                    usuario.valoresUsuarioPorCodigoInterno();
                    usuario.valoresUsuarioMapa(usuario.codUsuario);
                    usuario.IPOrigen = Request.ServerVariables["REMOTE_ADDR"];
                    string __PAGENAME__ = System.IO.Path.GetFileName(Request.ServerVariables["SCRIPT_NAME"]);
                    usuario.GrabaRegistroUsuario(usuario.IPOrigen, __PAGENAME__);
                    sesiones.clsSesiones.Cod_Usuario = usuario.codUsuario;
                    sesiones.clsSesiones.LlaveAutorizacion = ConfigurationManager.AppSettings["llaveAutorizacion"].ToString();
                    sesiones.clsSesiones.Id_Cliente = usuario.idCliente;
                    setModulos(usuario.codUsuario);
                    Session["clsUsuario"] = usuario;
                    Session.Timeout = 15;
                    string[,] iMod = (string[,])Session["arrayModulos"];
                    string redirectTo = iMod[0, 0];
                    Response.Redirect(redirectTo);

                }
                else
                {
                    if (msjeIngreso.Equals("NO"))
                    {
                        label_login.Text = "<img src='../img/error.png' alt=''>&nbsp;Nombre de usuario o contraseña incorrecto.";
                        ScriptManager.RegisterStartupScript(this, typeof(string), "fadeout", "fadeOut();", true);
                    }
                    else
                    {
                        label_login.Text = "<img src='../img/error.png' alt=''>&nbsp;" + msjeIngreso;
                        ScriptManager.RegisterStartupScript(this, typeof(string), "fadeout", "fadeOut();", true);
                    }
                }
            }
        }
    }

    /// <summary>
    /// Guardar en variable de sesion los modulos a los que puede acceder el usuario
    /// </summary>
    public void setModulos(int codUser)
    {
        sqlserver sqlMonitor = new sqlserver("Corporativo");
        sqlMonitor.addParametro("@Cod_Sistema", "1");
        sqlMonitor.addParametro("@Cod_User", codUser.ToString());
        DataSet dsOpciones = sqlMonitor.querySPDataset("SVC_QRY_MODULOUSUARIO");
        sqlMonitor.Desconectar();
        int lenMod = dsOpciones.Tables[0].Rows.Count;
        string[,] sessionMods = new string[lenMod, 4];
        int countMods = 0;

        foreach (DataRow entrada in dsOpciones.Tables[0].Rows)
        {
            string href = entrada["LinkModulo"].ToString();
            string _src = entrada["ImagenModulo"].ToString();
            string _alt = entrada["DesModulo"].ToString();
            string file = entrada["ArchivoModulo"].ToString();

            sessionMods[countMods, 0] = href;
            sessionMods[countMods, 1] = _src;
            sessionMods[countMods, 2] = _alt;
            sessionMods[countMods, 3] = file;

            countMods += 1;
        }
        Session["arrayModulos"] = sessionMods;
    }
    protected void btnLogin1_Click(object sender, EventArgs e)
    {
        //se crea objeto usuario...  codUsuario = 0
        clsUsuario usuario = new clsUsuario();
        if (textbox_login1.Text == "")
        {
            label_login1.Text = "<img src='../img/error.png' alt=''>&nbsp;Debe ingresar nombre de usuario.";
            ScriptManager.RegisterStartupScript(this, typeof(string), "fadeout", "fadeOut();", true);
        }
        else if (textbox_password1.Text == "")
        {
            label_login1.Text = "<img src='../img/error.png' alt=''>&nbsp;Debe ingresar contraseña. ";
            ScriptManager.RegisterStartupScript(this, typeof(string), "fadeout", "fadeOut();", true);
        }
        else
        {
            string msjeIngreso = usuario.validaAccesoSistema(textbox_login1.Text, textbox_password1.Text, _sistema);

            if (msjeIngreso == "OK")
            {
                usuario.valoresUsuarioPorCodigoInterno();
                usuario.valoresUsuarioMapa(usuario.codUsuario);
                usuario.IPOrigen = Request.ServerVariables["REMOTE_ADDR"];
                string __PAGENAME__ = System.IO.Path.GetFileName(Request.ServerVariables["SCRIPT_NAME"]);
                usuario.GrabaRegistroUsuario(usuario.IPOrigen, __PAGENAME__);
                sesiones.clsSesiones.Cod_Usuario = usuario.codUsuario;
                sesiones.clsSesiones.LlaveAutorizacion = ConfigurationManager.AppSettings["llaveAutorizacion"].ToString();
                sesiones.clsSesiones.Id_Cliente = usuario.idCliente;
                setModulos(usuario.codUsuario);
                Session["clsUsuario"] = usuario;
                Session.Timeout = 15;
                string[,] iMod = (string[,])Session["arrayModulos"];
                string redirectTo = iMod[0, 0];
                Response.Redirect(redirectTo);

            }
            else
            {
                if (msjeIngreso.Equals("NO"))
                {
                    label_login1.Text = "<img src='../img/error.png' alt=''>&nbsp;Nombre de usuario o contraseña incorrecto.";
                    ScriptManager.RegisterStartupScript(this, typeof(string), "fadeout", "fadeOut();", true);
                }
                else
                {
                    label_login1.Text = "<img src='../img/error.png' alt=''>&nbsp;" + msjeIngreso;
                    ScriptManager.RegisterStartupScript(this, typeof(string), "fadeout", "fadeOut();", true);
                }
            }
        }
    }
}

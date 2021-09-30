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
using System.Text;

public partial class frmModuloUsuario : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string[,] iModulos = (string[,])Session["arrayModulos"];
            string currentPage = new System.IO.FileInfo(Request.ServerVariables["SCRIPT_NAME"].ToString()).Name;
            int len = iModulos.Length;
            int tope = (len / 4) - 1;
            StringBuilder opc = new StringBuilder();
            bool isAuthorized = false;

            opc.Append("<ul id=\"tabmenu\">");
            for (int ind = 0; ind <= tope; ind++)
            {
                string href = iModulos[ind, 0].Replace("~/","../");
                string src = iModulos[ind, 1];
                string alt = iModulos[ind, 2];
                string page = iModulos[ind, 3];
                
                if (currentPage == page)
                {
                    isAuthorized = true;
                    opc.AppendFormat("<li><a class=\"active\" href=\"{0}\" target=\"_self\">{1}</a></li>", href, alt);                    
                    opc.Append("\n");
                    ltNomModulo.Text = alt;
                }
                else
                {
                    opc.AppendFormat("<li><a href=\"{0}\" target=\"_self\">{1}</a></li>", href, alt);
                    opc.Append("\n");
                }                
            }
            opc.AppendFormat("<li><a class=\"close\" href=\"{0}\" target=\"_self\">{1}</a></li>", "../Error/frmBrwMensaje.aspx?errCode=4000", "Cerrar Sesi&oacute;n");            
            opc.Append("</ul>");

			ltModulosUsuario.Text = opc.ToString();
			/*
			if (isAuthorized)
            {
                ltModulosUsuario.Text = opc.ToString();
            }
            else
            {
                Response.Redirect("../Error/frmBrwMensaje.aspx?errCode=1000");
            }
			*/
        }
        catch(Exception exp)
        {
        }
        
    }
}

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


public partial class frmEdiBarraNavegacion : System.Web.UI.UserControl
{
    string IdUsuario;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Session.IsNewSession)
        {
            IdUsuario = Session["Cod_Usuario"].ToString();
        }
        else
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");            
        }
        if (!IsPostBack)
        {
            
            DataSet ds = new DataSet();
            ds = clsMenu.ListaMenu(IdUsuario);
            if (ds.Tables[0].Rows.Count != 0)
            {
                foreach (DataRow fila in ds.Tables[0].Rows)
                {
                    string iocodMenu = fila[0].ToString();
                    string ionomOpcionMenu = fila[1].ToString();
                    string iolinkOpcionMenu = fila[2].ToString();

                    MenuItem mItem = new MenuItem();
                    mItem.Text = ionomOpcionMenu;
                    mItem.NavigateUrl = iolinkOpcionMenu;
                    //mItem.SeparatorImageUrl = "~/img/separador.png";
                    mItem.ToolTip = ionomOpcionMenu;
                    menuPrincipal.Items.Add(mItem);
                    menuPrincipal.Items.Add( new MenuItem(" - "));
                }
            }
            
        }
    }
    protected void menuPrincipal_MenuItemClick(object sender, MenuEventArgs e)
    {
        if (e.Item.Text == "Cerrar Sesión")
        {
            clsSession _session = new clsSession();
            clsUsuario usuario = new clsUsuario(); 
            usuario.GrabaRegistroUsuario(_session.IPOrigen, "CLOSE:Click sobre botón cerrar session.(frmBrwAlerta)");
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}

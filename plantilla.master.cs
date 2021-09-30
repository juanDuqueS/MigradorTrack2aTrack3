using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using FWKgpschile.SqlServer;

public partial class formularios_plantilla : System.Web.UI.MasterPage
{
    int IdUsuario;
    public string Id_Cliente;
    clsUsuario usuario;
    protected void Page_Load(object sender, EventArgs e)
    {


        try
        {

            usuario = (clsUsuario)Session["clsUsuario"];
            IdUsuario = Convert.ToInt32(usuario.codUsuario);
            Id_Cliente = usuario.idCliente;
            this.hdnCod_Usuario.Value = IdUsuario.ToString();
        }
        catch (Exception)
        {
            Response.Redirect("../login/Login.aspx");
        }
    }

    //public void retornaPerfil(int Cod_Usuario)
    //{
       
    //    try
    //    {
    //        List<Parametro> Parametros = new List<Parametro>();
    //        Parametros.Add(new Parametro("@Cod_Usuario", DbType.String, Cod_Usuario));

    //        DataSet ds = new DataSet();

    //        ds = SqlQuery.ObtieneDataSet(Parametros, "SVC_QRY_ROLPERFILPORUSUARIO", ConfigurationManager.AppSettings["Monitor"]);

    //        if (ds != null)
    //        {
    //            foreach (DataRow item in ds.Tables[0].Rows)
    //            {
    //                hdnCodUsuario.Value = item["Cod_RolPerfil"].ToString();
                    
    //            }
    //        }

           
    //    }
    //    catch (Exception)
    //    {
    //        hdnCodUsuario.Value = "0";
    //    }

       

    //}

  

   
    
}

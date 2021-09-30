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

public partial class controlPopupListaSitios : System.Web.UI.UserControl
{
    string _codFlota;
    public System.String cod_Flota
    {
        get {
            _codFlota = hdncod_Flota.Value;            
            return _codFlota; }
        set {            
            _codFlota = value;
            hdncod_Flota.Value = _codFlota;
        }
    }
    public void cargaGrilla()
    {

        DataSet dsSitios = clsSitio.ListarSitiosPorFlota(Convert.ToInt32(hdncod_Flota.Value));        
        uwgSitios.DataSource = dsSitios;
        uwgSitios.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        cargaGrilla();
    }
}

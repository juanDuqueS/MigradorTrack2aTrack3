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

public partial class frmEdiConfiguracion : System.Web.UI.UserControl
{
    string _Cod_vehiculo;
    string _refVehiculo;
    int _cantHoraInicial;
    int _limHoraAlerta;
    int _limHoraMantencion;
    string _TipoAlertaMantencion;
    decimal _cantHoraActual;
    string _estado;    
    bool _registroNuevo;


    public System.String Cod_Vehiculo
    {
        get
        {
            _Cod_vehiculo = hdnCod_Vehiculo.Value;
            return _Cod_vehiculo;
        }
        set
        {
            _Cod_vehiculo = value;
            hdnCod_Vehiculo.Value = _Cod_vehiculo;
        }
    }

    public System.String refVehiculo
    {
        get
        {
            _refVehiculo = lblRefVehiculo.Text;
            return _refVehiculo;
        }
        set
        {
            _refVehiculo = value;
            lblRefVehiculo.Text = _refVehiculo.ToString();
        }
    }
    public System.Int32 CantidadHoraInicial
    {
        get
        {
            _cantHoraInicial = Convert.ToInt32(txtCantidadHoraInicial.Text);
            return _cantHoraInicial;
        }
        set
        {
            _cantHoraInicial = value;
            txtCantidadHoraInicial.Text = _cantHoraInicial.ToString();
        }
    
    }
    public System.Int32 LimiteHoraAlerta
    {
        get
        {
            _limHoraAlerta = Convert.ToInt32(txtLimiteHoraAlerta.Text);
            return _limHoraAlerta;
        }
        set
        {
            _limHoraAlerta = value;
            txtLimiteHoraAlerta.Text = _limHoraAlerta.ToString();
        }
    }
    public System.Int32 LimiteHoraMantencion
    {
        get
        {
            _limHoraMantencion = Convert.ToInt32(txtLimiteHoraMantencion.Text);
            return _limHoraMantencion;
        }
        set
        {
            _limHoraMantencion = value;
            txtLimiteHoraMantencion.Text = _limHoraMantencion.ToString();
        }
    } 
    public System.Decimal CantidadHoraActual
    {
        get
        {
            _cantHoraActual = Convert.ToDecimal(lblCantidadHoraActual.Text);
            return _cantHoraActual;
        }
        set
        {
            _cantHoraActual = value;
            lblCantidadHoraActual.Text = _cantHoraActual.ToString();
        }
    }
    public System.String Estado
    {
        get
        {
            _estado = imgEstado.ImageUrl ;
            return _estado;
        }
        set
        {
            _estado = value;
            imgEstado.ImageUrl = _estado.ToString();
        }
    } 

    public System.Boolean RegistroNuevo
    {
        get
        {
            _registroNuevo = chkRegistroNuevo.Checked;
            return _registroNuevo;
        }
        set
        {
            _registroNuevo = value;
            chkRegistroNuevo.Checked = _registroNuevo;
        }
    }
    public System.String TipoAlertaMantencion
    {
        get
        {
            _TipoAlertaMantencion = ddlUnidadMedida.SelectedValue;
            return _TipoAlertaMantencion;
        }
        set
        {
            _TipoAlertaMantencion = value;
            ddlUnidadMedida.SelectedValue = _TipoAlertaMantencion;
        }
    } 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            sqlserver sqlMonitor = new sqlserver("Alerta");
            sqlMonitor.Conectar();            
            ddlUnidadMedida.DataSource = sqlMonitor.querySPDataset("SVC_BRW_TIPOALERTAMANTENCION");
            ddlUnidadMedida.DataTextField = "NomTipoAlertaMantencion";
            ddlUnidadMedida.DataValueField = "Cod_TipoAlertaMantencion";
            ddlUnidadMedida.DataBind();
            sqlMonitor.Desconectar();
        }

    }
}

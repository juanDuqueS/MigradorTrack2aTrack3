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

public partial class frmEdiMantencion : System.Web.UI.UserControl
{
    string _Cod_vehiculo;
    DateTime _fechaMantencion;
    int _horometro;
    int _horometroActual;
    int _horometroActualPrevio;
    string _comentario;
    FileUpload _informe;
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


    public System.DateTime FechaMantencion
    {
        get
        {
            _fechaMantencion = Convert.ToDateTime(wdcManFecha.Value);
            return _fechaMantencion;
        }
        set
        {
            _fechaMantencion = value;
            wdcManFecha.Value = _fechaMantencion;            
        }
    }


    public System.Int32 Horometro
    {
        get
        {
            _horometro = Convert.ToInt32(txtManHorometro.Value);
            return _horometro;
        }
        set
        {
            _horometro = value;
            txtManHorometro.Value = _horometro.ToString();            
        }
    }

    public System.Int32 HorometroActual
    {
        get
        {
            _horometroActual = Convert.ToInt32(lblHorometroActual.Text);
            return _horometroActual;
        }
        set
        {
            _horometroActual = value;
            lblHorometroActual.Text = _horometroActual.ToString();
        }
    }

    public System.Int32 HorometroActualPrevio
    {
        get
        {
            _horometroActualPrevio = txtHorometroActualPrevio.Text==""?0:Convert.ToInt32(txtHorometroActualPrevio.Value);
            return _horometroActualPrevio;
        }
        set
        {
            _horometroActualPrevio = value;
            txtHorometroActualPrevio.Text = _horometroActualPrevio.ToString();
        }
    }


    public System.String Comentario
    {
        get
        {
            _comentario = txtManComentario.Text;
            return _comentario;
        }
        set
        {
            _comentario = value;
            txtManComentario.Text = _comentario;            
        }
    }

    public FileUpload Informe
    {
        get
        {
            _informe = fuplManInforme;            
            return _informe;
        }
        set
        {
            _informe = value;
            fuplManInforme = _informe;            
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




    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            wdcManFecha.Value = DateTime.Now.Date.ToString();
        }
    }

    public void LimpiarFormulario()
    {
        Horometro = 0;
        Comentario = "";
        Informe = null;
        FechaMantencion = DateTime.Now.Date;
        RegistroNuevo = true;
    }
}

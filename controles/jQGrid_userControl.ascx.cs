using System;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Services;
using System.Web.Script.Services;


//using jQGrid;

[ScriptService]
public partial class jQGrid_userControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.setDefaults();
        this.columnsMapping();
        //this.ValidaDefaults();
        //this.recibirBusqueda();
        this.CodUsuario = "61";

    }

    #region Variables
    private bool _MostrarPaginacion;
    public bool MostrarPaginacion
    {
        set { _MostrarPaginacion = value; }
        get { return _MostrarPaginacion; }
    }

    private string _Alto;
    public string Alto
    {
        set { _Alto = value; }
        get { return _Alto.Replace("px", ""); }
    }

    private string _Ancho;
    public string Ancho
    {
        set { _Ancho = value; }
        get { return _Ancho.Replace("px", ""); }
    }

    private string _ColumnasTitulo;
    public string ColumnasTitulo
    {
        set { _ColumnasTitulo = value; }
        get { return _ColumnasTitulo; }
    }

    private string _ColumnasCampo;
    public string ColumnasCampo
    {
        set { _ColumnasCampo = value; }
        get { return _ColumnasCampo; }
    }

    private string _ColumnasAlineacion;
    public string ColumnasAlineacion
    {
        set { _ColumnasAlineacion = value; }
        get { return _ColumnasAlineacion; }
    }

    private string _ColumnasOculta;
    public string ColumnasOculta
    {
        set { _ColumnasOculta = value; }
        get { return _ColumnasOculta; }
    }

    private string _ColumnasAncho;
    public string ColumnasAncho
    {
        set { _ColumnasAncho = value; }
        get { return _ColumnasAncho; }
    }

    private string _TipoDato;
    public string TipoDato
    {
        set { _TipoDato = value; }
        get { return _TipoDato; }
    }

    private string _ColumnasEditable;
    public string ColumnasEditable
    {
        set { _ColumnasEditable = value; }
        get { return _ColumnasEditable; }
    }

    private string _TamanoPagina;
    public string TamanoPagina
    {
        set { _TamanoPagina = value; }
        get { return _TamanoPagina; }
    }    
    
    private string _FilasPorPagina;
    public string FilasPorPagina
    {
        set { _FilasPorPagina = "["+value+"]"; }
        get { return _FilasPorPagina; }
    }

    private string _Titulo;
    public string Titulo
    {
        set { _Titulo = "\"" + value + "\""; }
        get { return _Titulo; }
    }
    
    private string _Edicion;
    public string Edicion
    {
        set { _Edicion = value; }
        get { return _Edicion; }
    }

    private string _Insercion;
    public string Insercion
    {
        set { _Insercion = value; }
        get { return _Insercion; }
    }

    private string _Busqueda;
    public string Busqueda
    {
        set { _Busqueda = value; }
        get { return _Busqueda; }
    }

    private string _Eliminacion;
    public string Eliminacion
    {
        set { _Eliminacion = value; }
        get { return _Eliminacion; }
    }

    public string mapeoColumnas;
    public string colNames;

    public string ColumnasCampos
    {
        get { return "\"" + _ColumnasCampo + "\""; }
    }

    private string _OnCellSelect;
    public string OnCellSelect
    {
        set { _OnCellSelect = value; }
        get { return _OnCellSelect; }
    }

    private string _MetodoCargaDatos;
    public string MetodoCargaDatos
    {
        set { _MetodoCargaDatos = value; }
        get { return _MetodoCargaDatos; }
    }

    private string _MetodoInicio;
    public string MetodoInicio
    {
        set { _MetodoInicio = value; }
        get { return _MetodoInicio; }
    }

    private string _TextoSinRegistros;
    public string TextoSinRegistros
    {
        set { _TextoSinRegistros = value; }
        get { return _TextoSinRegistros; }
    }

    private string _ColumnaID;
    public string ColumnaID
    {
        set { _ColumnaID = value; }
        get { return _ColumnaID; }
    }

    private string _ColumnaOrden;
    public string ColumnaOrden
    {
        set { _ColumnaOrden = value; }
        get { return _ColumnaOrden; }
    }

    private string _DireccionOrden;
    public string DireccionOrden
    {
        set { _DireccionOrden = value; }
        get { return _DireccionOrden; }
    }


    private string _ColumnaCampoRequerido;
    public string ColumnaCampoRequerido
    {
        set { _ColumnaCampoRequerido = value; }
        get { return _ColumnaCampoRequerido; }
    }

    private string _CodUsuario;
    public string CodUsuario
    {
        set { _CodUsuario = value; }
        get { return _CodUsuario; }
    }
    private string _CodFlota;
    public string CodFlota
    {
        set { _CodFlota = value; }
        get { return _CodFlota; }
    }


    #endregion Variables

    private void columnsMapping()
    {

        StringBuilder rtn_mapeoColumnas = new StringBuilder();
        String[] field = this.ColumnasCampo.Split(',');
        String[] width = this.ColumnasAncho.Split(',');
        String[] align = this.ColumnasAlineacion.Split(',');
        String[] label = this.ColumnasTitulo.Split(',');
        String[] type = this.TipoDato.Split(',');
        String[] editable = this.ColumnasEditable.Split(',');
        String[] required = this.ColumnaCampoRequerido.Split(',');
        String[] oculta = this.ColumnasOculta.Split(',');

        rtn_mapeoColumnas.Append("[");
        colNames = "[";
        for (int iCol = 0; iCol < field.Length; iCol++)
        {
            colNames += "\"" + field[iCol].Trim() + "\",";
            if (iCol == 3)
            {
                rtn_mapeoColumnas.Append("{name:'" + field[iCol].Trim() + "',width:" + width[iCol].Trim() + ", label:'" + label[iCol].Trim() + "',align:'" + align[iCol].Trim() + "',searchoptions:{sopt:" + filtrosByDataType(type[iCol].Trim()) + "},editable:" + editable[iCol].Trim() + "," + validacionesEdicion(type[iCol].Trim(), required[iCol].Trim()) + ",hidden:" + oculta[iCol].Trim() + ",formatter: highlight}");
            }
            else if (iCol == 12)
            {
                rtn_mapeoColumnas.Append("{name:'" + field[iCol].Trim() + "',width:" + width[iCol].Trim() + ", label:'" + label[iCol].Trim() + "',align:'" + align[iCol].Trim() + "',searchoptions:{sopt:" + filtrosByDataType(type[iCol].Trim()) + "},editable:" + editable[iCol].Trim() + "," + validacionesEdicion(type[iCol].Trim(), required[iCol].Trim()) + ",hidden:" + oculta[iCol].Trim() + ",formatter: highlight}");
            }
            else
                rtn_mapeoColumnas.Append("{name:'" + field[iCol].Trim() + "',width:" + width[iCol].Trim() + ", label:'" + label[iCol].Trim() + "',align:'" + align[iCol].Trim() + "',searchoptions:{sopt:" + filtrosByDataType(type[iCol].Trim()) + "},editable:" + editable[iCol].Trim() + "," + validacionesEdicion(type[iCol].Trim(), required[iCol].Trim()) + ",hidden:" + oculta[iCol].Trim() + "}");
            //rtn_mapeoColumnas.Append("{label:'" + label[iCol].Trim() + "',width:" + width[iCol].Trim() + ", index:'" + field[iCol].Trim() + "',align:'" + align[iCol].Trim() + "',searchoptions:{sopt:" + filtrosByDataType(type[iCol].Trim()) + "},editable:" + editable[iCol].Trim() + "}");
            if (iCol < field.Length) rtn_mapeoColumnas.Append(",");
        }
        colNames += "]";
        colNames = colNames.Replace(",]","]");
        rtn_mapeoColumnas.Append("]");
        //[
        // { index: 'Name', width: 200, align: 'Left',label: 'Nombre' },
        // { index: 'Name', width: 200, align: 'Left',label: 'Nombre' }
        //]
        mapeoColumnas = rtn_mapeoColumnas.ToString();
    }
    
    private String filtrosByDataType(String type)
    {
        String retorno = "";
        if (type == "texto")
        {
            retorno = "['eq','ne','cn','nc','bw','bn','ew','en']";
        }
        else if (type == "numero")
        {
            retorno = "['eq','ne','lt','le','gt','ge','in','ni']";
        }

        return retorno;
    }

    private String validacionesEdicion(String type, String required)
    {
        String retorno = "";

            if (type == "texto")
            {
                retorno = "editrules:{required:"+required+"}";
            }
            else if (type == "numero")
            {
                retorno = "editrules:{required:" + required + ",number:true }";
            }

        return retorno;
    }

    private void setDefaults()
    {
        int cantidadColumnas=0;
        
        if(ColumnasCampo!=null)
            cantidadColumnas = ColumnasCampo.Split(',').Length;
        else
            ColumnasCampo = ""; ;

        
        if (TipoDato == null || TipoDato.Split(',').Length < cantidadColumnas)
        {
            for (int i = 0; i < cantidadColumnas; i++)
            {
                TipoDato = TipoDato +"text";
                if (i < (cantidadColumnas - 1))
                    TipoDato = TipoDato + ",";
            }
        }
        if (ColumnasEditable == null || ColumnasEditable.Split(',').Length < cantidadColumnas)
        {
            for (int i = 0; i < cantidadColumnas; i++)
            {
                ColumnasEditable = ColumnasEditable + "false";
                if (i < (cantidadColumnas - 1))
                    ColumnasEditable = ColumnasEditable + ",";
            }
        }

        if (ColumnaCampoRequerido == null || ColumnaCampoRequerido.Split(',').Length < cantidadColumnas)
        {
            for (int i = 0; i < cantidadColumnas; i++)
            {
                ColumnaCampoRequerido = ColumnaCampoRequerido + "false";
                if (i < (cantidadColumnas - 1))
                    ColumnaCampoRequerido = ColumnaCampoRequerido + ",";
            }
        }

        if (ColumnasAlineacion == null || ColumnasAlineacion.Split(',').Length < cantidadColumnas)
        {
            for (int i = 0; i < cantidadColumnas; i++)
            {
                ColumnasAlineacion = ColumnasAlineacion + "center";
                if (i < (cantidadColumnas - 1))
                    ColumnasAlineacion = ColumnasAlineacion + ",";
            }
        }

        if (ColumnasOculta == null || ColumnasOculta.Split(',').Length < cantidadColumnas)
        {
            for (int i = 0; i < cantidadColumnas; i++)
            {
                ColumnasOculta = ColumnasOculta + "true";
                if (i < (cantidadColumnas - 1))
                    ColumnasOculta = ColumnasOculta + ",";
            }
        }


        if (ColumnasAncho == null || ColumnasAncho.Split(',').Length < cantidadColumnas)
        {
            for (int i = 0; i < cantidadColumnas; i++)
            {
                ColumnasAncho = ColumnasAncho + "100";
                if (i < (cantidadColumnas - 1))
                    ColumnasAncho = ColumnasAncho + ",";
            }
        }

        if (ColumnasTitulo == null)
            ColumnasTitulo = ColumnasCampo;
        if (this.MostrarPaginacion == false)
            this.MostrarPaginacion = false;
        if (this.Busqueda == null)
            this.Busqueda = "false";
        if (this.Insercion == null)
            this.Insercion = "false";
        if (this.Edicion == null)
            this.Edicion = "false";
        if (this.Edicion == null)
            this.Edicion = "false";
        if (this.Eliminacion == null)
            this.Eliminacion = "false";
        if (this.TamanoPagina == null)
            this.TamanoPagina = "10";
        if (this.Titulo == null)
            this.Titulo = "";
        if (this.FilasPorPagina == null)
            this.FilasPorPagina = "10,20,30";
        if (this.OnCellSelect == null)
            this.OnCellSelect = "";
        if (this.TextoSinRegistros == null)
            this.TextoSinRegistros = "No hay resultados";
        if (this.MetodoInicio == null)
            this.MetodoInicio = "";
        if (this.ColumnaID == null)
            this.ColumnaID = "0";
        if (this.ColumnaOrden == null)
            this.ColumnaOrden = "1";
        if (this.DireccionOrden == null)
            this.DireccionOrden = "asc";

    }


}





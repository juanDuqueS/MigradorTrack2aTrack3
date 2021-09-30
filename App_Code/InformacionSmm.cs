using FWKgpschile.SqlServer;
using Omu.AwesomeWebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Web;

[ServiceContract(Namespace = "")]
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
public class InformacionSmm
{
    [WebGet]
    [OperationContract]
    public KeyContent ObtenerSitio(string v)
    {
        if (HttpContext.Current.Session["RstSitios"] != null)
        {
            var listado = (List<SitioSmm>)HttpContext.Current.Session["RstSitios"];

            var valor = listado.Where(c => c.Id.ToString() == v).FirstOrDefault();

            if (valor != null)
            {
                return new KeyContent() { Key = valor.Id, Content = valor.Nombre };
            }
        }

        return null;
    }

    [WebGet]
    [OperationContract]
    public LookupResult BusquedaSitios(string search, string selected, int page, bool isMoreClick, string cat1)
    {
        int pageSize = 5;
        search = (search ?? "").ToLower();
        var sel = selected.GetIntArray();

        //var items = Fruits.Where(o => o.Name.ToLower().Contains(search) && !sel.Contains(o.Id))
        //    .Select(f => new KeyContent { Key = f.Id, Content = f.Name });
        var listado = new List<SitioSmm>();

        if (HttpContext.Current.Session["RstSitios"] != null)
        {
            listado = (List<SitioSmm>)HttpContext.Current.Session["RstSitios"];

            listado = listado.Where(c => c.Nombre.ToLower().Contains(search.ToLower())).ToList();
        }
        else
        {
            sqlserver conex = new sqlserver("Monitor");
            DataSet dataSet = new DataSet();
            conex.Conectar();
            dataSet = conex.queryDataset("SELECT sc.Cod_SitioCliente,sc.NomSitioCliente, sc.Poligono FROM dbo.SitioCliente (NOLOCK) sc INNER JOIN dbo.Flota (NOLOCK) f ON f.Id_Cliente = sc.Id_Cliente	WHERE f.Cod_Flota = " + cat1 + " AND sc.Cod_EstadoSitioCliente = 1 AND sc.NomSitioCliente LIKE '%" + search + "%' ORDER BY NomSitioCliente ASC");
            conex.Desconectar();
            var items = new List<KeyContent>();

            if (dataSet != null)
            {
                if (dataSet.Tables.Count > 0)
                {
                    foreach (DataRow row in dataSet.Tables[0].Rows)
                    {
                        listado.Add(new SitioSmm { Id = Convert.ToInt32(row.ItemArray[0]), Nombre = row.ItemArray[1].ToString(), Poligono = row.ItemArray[2].ToString() });
                        //items.Add(new KeyContent { Key = Convert.ToInt32(row.ItemArray[0]), Content = row.ItemArray[1].ToString() });
                    }
                }
            }

            HttpContext.Current.Session["RstSitios"] = listado;
        }

        return new LookupResult
        {
            Items = listado.Select(c => new KeyContent { Key = c.Id, Content = c.Nombre }),
            More = listado.Count > page * pageSize
        };
    }
}

public class SitioSmm
{
    public int Id { get; set; }
    public string Nombre { get; set; }
    public string Poligono { get; set; }
}
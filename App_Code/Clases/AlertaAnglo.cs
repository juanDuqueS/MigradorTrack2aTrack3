using Jayrock.Json.Conversion;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AlertaAnglo
/// </summary>
public class AlertaAnglo
{
	public AlertaAnglo()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static string ObtenerAltertaSubida()
    {
        try
        {
            List<Parametro> Parametros = new List<Parametro>();
            DataSet ds = new DataSet();
            //QRY_ALERTAS_BAJADA_ANGLO


            ds = SqlQuery.ObtieneDataSet(Parametros, "QRY_ALERTAS_SUBIDA_ANGLO", ConfigurationManager.AppSettings["ALERTA"]);

            if (ds != null)
            {
                return JsonConvert.ExportToString(ds.Tables[0]);
            }
            else
            {
                return "";
            }

        }
        catch (Exception)
        {
            
            return "";
        }

    }

    public static string ObtenerAltertaBajada()
    {
        try
        {
            List<Parametro> Parametros = new List<Parametro>();
            DataSet ds = new DataSet();

            ds = SqlQuery.ObtieneDataSet(Parametros, "QRY_ALERTAS_BAJADA_ANGLO", ConfigurationManager.AppSettings["ALERTA"]);

            if (ds != null)
            {
                return JsonConvert.ExportToString(ds.Tables[0]);
            }
            else
            {
                return "";
            }

        }
        catch (Exception)
        {

            return "";
        }

    }


    public static ArrayList ObtenerSitiosDeControl()
    {
        ArrayList sitios = new ArrayList();

        try
        {

            List<Parametro> Parametros = new List<Parametro>();
            DataSet ds = new DataSet();

            ds = SqlQuery.ObtieneDataSet(Parametros, "QRY_SITIOSCONTROLG21ANGLO", ConfigurationManager.AppSettings["Monitor"]);

            if (ds != null)
            {
                foreach (DataRow item in ds.Tables[0].Rows)
	            {
                    ArrayList coordenadas = new ArrayList();
                    string[] coor = item["Poligono"].ToString().Split(',');
                    double lat = 0;
                    double lng = 0;

                    
                    for (int i = 0; i < coor.Length; i++)
			        {
                        if (i % 2 == 0)
                        {
                            lat = double.Parse(coor[i].Replace('.',','));
                        }
                        else
                        {
                            lng = double.Parse(coor[i].Replace('.', ','));

                            coordenadas.Add(new { Latitud = lat, Longitud = lng });
                        }
			        }

                    sitios.Add(new { Cod_SitioCliente = item["Cod_SitioCliente"].ToString(), NomSitioCliente = item["NomSitioCliente"].ToString(), Latitud = item["Latitud"].ToString(), Longitud = item["Longitud"].ToString(), Poligono = coordenadas, Radio = item["Radio"].ToString(), Cod_TipoSitioCliente = item["Cod_TipoSitioCliente"].ToString() });
	            }

                return sitios;
            }
            else
            {
                return sitios;
            }

        }
        catch (Exception)
        {

            return sitios;
        }

    }


    


    public static DataSet  ObtenerAltertaInstantanea(string fecha)
    {
        DataSet ds = new DataSet();
        try
        {

            List<Parametro> Parametros = new List<Parametro>();

            Parametros.Add(new Parametro("@FechaHora", DbType.String, fecha));
            ds = SqlQuery.ObtieneDataSet(Parametros, "QRY_ALERTAINSTANTANEA_ANGLOG21", ConfigurationManager.AppSettings["ALERTA"]);

            if (ds != null)
            {
                return ds;
            }
            else
            {
                return ds;
            }

        }
        catch (Exception)
        {

            return ds;
        }

    }

}
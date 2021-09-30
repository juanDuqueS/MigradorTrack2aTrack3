using FWKgpschile.SqlServer;
using GpsChile.Servicio.Ems.Clases.Cango;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Reflection;
using System.Drawing;

/// <summary>
/// Summary description for CangoDatos
/// </summary>

namespace CangoDatos
{
    public static class CangoUtilidades
    {
        public static DateTime ParseMyDateWithOnlyHour(string date)
        {
            return new DateTime(int.Parse(date.Substring(0, 4)), int.Parse(date.Substring(4, 2)), int.Parse(date.Substring(6, 2)), int.Parse(date.Substring(9, 2)), 0, 0);
        }

        public static bool IsPointInPolygon(IList<PointF> polygon, PointF testPoint)
        {
            bool result = false;
            int j = polygon.Count() - 1;
            for (int i = 0; i < polygon.Count(); i++)
            {
                if (polygon[i].Y < testPoint.Y && polygon[j].Y >= testPoint.Y || polygon[j].Y < testPoint.Y && polygon[i].Y >= testPoint.Y)
                {
                    if (polygon[i].X + (testPoint.Y - polygon[i].Y) / (polygon[j].Y - polygon[i].Y) * (polygon[j].X - polygon[i].X) < testPoint.X)
                    {
                        result = !result;
                    }
                }
                j = i;
            }
            return result;
        }

        public static bool PointInPolygon(PointF p, PointF[] poly)
        {
            PointF p1, p2;

            bool inside = false;

            if (poly.Length < 3)
            {
                return inside;
            }

            PointF oldPoint = new PointF(
            poly[poly.Length - 1].X, poly[poly.Length - 1].Y);

            for (int i = 0; i < poly.Length; i++)
            {
                PointF newPoint = new PointF(poly[i].X, poly[i].Y);

                if (newPoint.X > oldPoint.X)
                {
                    p1 = oldPoint;
                    p2 = newPoint;
                }
                else
                {
                    p1 = newPoint;
                    p2 = oldPoint;
                }

                if ((newPoint.X < p.X) == (p.X <= oldPoint.X) && ((long)p.Y - (long)p1.Y) * (long)(p2.X - p1.X) < ((long)p2.Y - (long)p1.Y) * (long)(p.X - p1.X))
                {
                    inside = !inside;
                }

                oldPoint = newPoint;
            }

            return inside;
        }
        public static string mtdRetornoJson<T>(IList<T> lista, int Pagina, int regPorPagina, int totalRegistros) where T : class, new()
        {
            string retorno = "";
            //defino el paginado
            retorno = "{'PageCount':" + mtdNumPaginadoGrilla(regPorPagina, totalRegistros) + ",'CurrentPage':" + Pagina + ",'RecordCount':" + totalRegistros + ",";
            // ahora defino la grilla
            retorno += "'Items':[";
            T entidad = new T();
            PropertyInfo[] pInfo = entidad.GetType().GetProperties();
            foreach (T t in lista)
            {
                pInfo = t.GetType().GetProperties();
                retorno += "{";
                foreach (PropertyInfo prop in pInfo)
                {
                    try
                    {
                        retorno += "'" + prop.Name + "':'" + (prop.GetValue(t, null) != null ? prop.GetValue(t, null).ToString() : "") + "',";
                    }
                    catch (Exception ex)
                    {
                        retorno += "'" + prop.Name + "':'0',";
                    }
                }
                retorno = retorno.Substring(0, retorno.Length - 1);
                retorno += "},";
            }

            retorno = retorno.Substring(0, retorno.Length - 1);
            retorno += "]}";
            return retorno;
        }

        public static int mtdNumPaginadoGrilla(int regPorPagina, int totalRegistros)
        {
            int pageCount = 1;
            try
            {
                if ((totalRegistros % regPorPagina) != 0 && totalRegistros > 1)
                {
                    pageCount = ((totalRegistros / regPorPagina) + 1);
                }
                else
                {
                    pageCount = (totalRegistros / regPorPagina);
                }
            }
            catch (Exception ex)
            {
                pageCount = 1;
            }
            return pageCount;
        }


        public static string ParseMyHour(string date)
        {
            string[] data = date.Split(' ');

            string nuevaHora = data[1].Remove(2) + ":00";

            return nuevaHora;
        }

        public static string Formatear(string valor)
        {
            if (valor == "0.0" || valor == "0")
                return "0h 0m";

            valor = valor.Replace(",", ".");

            var culture = new CultureInfo("en-US");

            var calculo = double.Parse(valor, culture.NumberFormat);

            TimeSpan span = TimeSpan.FromSeconds(double.Parse(valor, culture.NumberFormat));

            return String.Format("{0}h {1:D2}m", (int)span.TotalHours, span.Minutes, span.Seconds);
        }

        public static string FormatearEnMinutos(string valor)
        {
            if (valor == "0.0" || valor == "0")
                return "0m";

            valor = valor.Replace(",", ".");

            var culture = new CultureInfo("en-US");

            var calculo = double.Parse(valor, culture.NumberFormat);

            TimeSpan span = TimeSpan.FromSeconds(double.Parse(valor, culture.NumberFormat));

            return String.Format("{0}m", span.TotalMinutes);
        }

        public static DateTime ObtenerFecha(string fecha)
        {
            string[] data = fecha.Split('/');
            int dia = 0;
            int mes = 0;
            int año = 0;
            int hora = 0;
            int minutos = 0;

            if (data.Length == 3)
            {
                dia = int.Parse(data[0]);
                mes = int.Parse(data[1]);
                año = 0;
                hora = 0;
                minutos = 0;

                string[] tempData = data[2].Split(' ');

                if (tempData.Length == 2)
                {
                    año = int.Parse(tempData[0].Trim());

                    string[] tiempo = tempData[1].Split(':');

                    if (tiempo.Length == 2)
                    {
                        hora = int.Parse(tiempo[0]);
                        minutos = int.Parse(tiempo[1]);
                    }
                }
            }

            return new DateTime(año, mes, dia, hora, minutos, 0);
        }

        public static DateTime ObtenerFechaSola(string fecha)
        {
            string[] data = fecha.Split('/');

            if (data.Length != 3)
                data = fecha.Split('-');

            int dia = 0;
            int mes = 0;
            int año = 0;

            if (data.Length == 3)
            {
                dia = int.Parse(data[0]);
                mes = int.Parse(data[1]);
                año = int.Parse(data[2]);
            }

            return new DateTime(año, mes, dia, 0, 0, 0);
        }

        public static DateTime ObtenerFechaSpreadsheet(string fecha)
        {
            fecha = fecha.Replace("-", "/");

            var dataFecha = fecha.Split(' ');

            if (dataFecha.Length > 1)
            {
                string[] data = dataFecha[0].Split('/');
                
                int dia = 0;
                int mes = 0;
                int año = 0;

                if (data.Length == 3)
                {
                    dia = int.Parse(data[0]);
                    mes = int.Parse(data[1]);
                    año = int.Parse(data[2]);
                }

                int hora = 0;
                int minuto = 0;

                string[] data2 = dataFecha[1].Split(':');

                hora = int.Parse(data2[0]);
                minuto = int.Parse(data2[1]);

                return new DateTime(año, mes, dia, hora, minuto, 0);
            }

            return new DateTime();
        }

        //03-09-2014 15:15:35

        public static DateTime ParseMyDate(string date)
        {
            return new DateTime(int.Parse(date.Substring(0, 4)), int.Parse(date.Substring(4, 2)), int.Parse(date.Substring(6, 2)));
        }

        public static DateTime ParseMyDateWithHour(string date)
        {
            return new DateTime(int.Parse(date.Substring(0, 4)), int.Parse(date.Substring(4, 2)), int.Parse(date.Substring(6, 2)), int.Parse(date.Substring(9, 2)), int.Parse(date.Substring(12, 2)), 0);
        }

        public static string FormatearExceso(string valor)
        {
            valor = valor.Replace(",", ".");

            CultureInfo culture = new CultureInfo("en-US");

            var calculo = double.Parse(valor, culture.NumberFormat);

            TimeSpan span = TimeSpan.FromMinutes(double.Parse(valor, culture.NumberFormat));

            return String.Format("{0}h {1:D2}m", (int)span.TotalHours, span.Minutes, span.Seconds);

            //return String.Format("{0}h {1:D2}m {2:D2}s", (int)span.TotalHours, span.Minutes, span.Seconds);
        }

        public static List<ArchivoExcel> ObtenerValoresArchivo(string archivo)
        {
            var listadoExcel = new List<ArchivoExcel>();

            try
            {

                var path = HttpContext.Current.Server.MapPath("~/Temp");
                path += "\\" + archivo;

                var con = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path +
                             ";Extended Properties='Excel 8.0;HDR=Yes;'";

                using (var connection = new OleDbConnection(con))
                {
                    connection.Open();

                    var dtSchema = connection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
                    var sheet1 = dtSchema.Rows[0].Field<string>("TABLE_NAME");

                    var command = new OleDbCommand("select * from [" + sheet1 + "]", connection);
                    using (OleDbDataReader dr = command.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            try
                            {
                                var rowPatente = dr.GetString(0);
                                var rowFecha = dr.GetDateTime(1);
                                var rowHora = dr.GetDateTime(2);
                                var rowUbicacion = dr.GetString(3);
                                var rowVolumen = Convert.ToDouble(dr.GetValue(4));
                                var rowOdometro = dr.GetDouble(5);
                                var rowRendimiento = dr.GetDouble(6);

                                rowFecha = rowFecha.AddHours(rowHora.Hour);
                                rowFecha = rowFecha.AddMinutes(rowHora.Minute);

                                listadoExcel.Add(new ArchivoExcel() { Patente = rowPatente, Fecha = rowFecha, Ubicacion = rowUbicacion, Carga = rowVolumen, Odometro = rowOdometro, Rendimiento = rowRendimiento });
                            }
                            catch (Exception ex)
                            {
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            }

            return listadoExcel;
        }

        public static List<ArchivoExcel> ObtenerValoresArchivoCompleto(string archivo)
        {
            var listadoExcel = new List<ArchivoExcel>();

            try
            {

                var path = HttpContext.Current.Server.MapPath("~/Temp");
                path += "\\" + archivo;

                var con = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path +
                             ";Extended Properties='Excel 8.0;HDR=Yes;'";

                using (var connection = new OleDbConnection(con))
                {
                    connection.Open();

                    var dtSchema = connection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
                    var sheet1 = dtSchema.Rows[0].Field<string>("TABLE_NAME");

                    var command = new OleDbCommand("select * from [" + sheet1 + "]", connection);
                    using (OleDbDataReader dr = command.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            try
                            {
                                var rowPatente = dr.GetString(1);
                                var rowFecha = dr.GetDateTime(2);
                                var rowHora = dr.GetDateTime(3);
                                var rowUbicacion = dr.GetString(4);
                                var rowPrecio = dr.GetDouble(6);
                                var rowVolumen = dr.GetDouble(7);
                                var rowOdometro = dr.GetDouble(9);
                                var rowGuia = dr.GetDouble(5);

                                rowFecha = rowFecha.AddHours(rowHora.Hour);
                                rowFecha = rowFecha.AddMinutes(rowHora.Minute);

                                listadoExcel.Add(new ArchivoExcel() { Patente = rowPatente, Fecha = rowFecha, Ubicacion = rowUbicacion, Carga = rowVolumen, Odometro = rowOdometro, Guia = rowGuia, Precio = rowPrecio });
                            }
                            catch (Exception ex)
                            {
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            }

            return listadoExcel;
        }

        public static GraphicInfo RetornarVacio(string codVehiculo, DateTime fromDate, DateTime toDate)
        {
            var info = ObtenerInformacionVehiculo(codVehiculo);

            // Valores Resumen
            var combustible = 0;
            var distancia = 0;
            var frenado = 0;
            var rendimiento = 0;

            //CalcularRendimiento(combustible, distancia);
            var velocidad = 0;
            var rpm = 0;

            // Valores promedio
            var velocidadProm = 0;
            var rpmProm = 0;
            var tempProm = 0;
            var distProm = 0;

            // Valores Graficos
            var series = new string[] { };
            object valsRPM = null;
            object valsDist = null;
            object valsCombustible = null;

            if ((toDate - fromDate).Days > 1)
            {
                List<string> dtStr = new List<string>();

                while (fromDate.Date <= toDate.Date)
                {
                    dtStr.Add(fromDate.ToString("ddd") + " " + fromDate.ToString("dd/mm/yyyy"));

                    fromDate = fromDate.AddDays(1);
                }

                series = dtStr.ToArray();

                valsRPM = new { name = "RPM", data = dtStr.Select(c => 0).ToArray() };
                valsCombustible = new { name = "Combustible", data = dtStr.Select(c => 0).ToArray() };
                valsDist = new { name = "Distancia", data = dtStr.Select(c => 0).ToArray() };
            }
            else
            {
                List<string> dtStr = new List<string>();

                for (var i = 0; i < 24; i++)
                {
                    dtStr.Add(fromDate.ToShortTimeString());

                    fromDate = fromDate.AddHours(1);
                }
                series = dtStr.ToArray();

                valsRPM = new { name = "RPM", data = dtStr.Select(c => 0).ToArray() };
                valsCombustible = new { name = "Combustible", data = dtStr.Select(c => 0).ToArray() };
                valsDist = new { name = "Distancia", data = dtStr.Select(c => 0).ToArray() };
            }

            // Asignacion de Valores            
            info.VelocidadPromedio = velocidadProm;
            info.RpmPromedio = rpmProm;
            info.DistanciaRecorrida = distancia.ToString();
            info.Frenados = frenado;
            info.TemperaturaPromedio = tempProm;
            info.Categorias = series;
            info.CombustibleComsumido = combustible;
            info.RendimientoCombustible = 0;
            info.ExcesosRPMS = "0";
            info.ExcesosVelocidad = "0";
            info.DistanciaPromedio = distProm;

            if ((toDate - fromDate).Days > 1)
            {
                info.TiempoViaje = (toDate - fromDate).Days.ToString() + " días";
            }
            else
            {
                info.TiempoViaje = (toDate - fromDate).Hours.ToString() + " horas";
            }

            info.Valores = new object[] { valsRPM, valsDist, valsCombustible };

            return info;
        }

        public static GraphicInfo ObtenerInformacionVehiculo(string codVehiculo)
        {
            GraphicInfo info = new GraphicInfo();

            sqlserver conex = new sqlserver("Monitor");
            DataSet dataSet = new DataSet();
            conex.Conectar();
            conex.addParametro("@COD_VEHICULO", codVehiculo.ToString());
            dataSet = conex.querySPDataset("SVC_QRY_CONSULTARDETALLEVEHICULOSSEGUNFLOTAUSUARIO");

            if (dataSet != null)
            {
                if (dataSet.Tables.Count > 0)
                {
                    foreach (DataRow row in dataSet.Tables[0].Rows)
                    {
                        info.NombreVehiculo = row.ItemArray[1].ToString();
                        info.Conductor = row.ItemArray[3].ToString();
                    }
                }
            }

            conex = new sqlserver("Monitor");
            dataSet = new DataSet();
            conex.Conectar();
            //conex.addParametro("@codVehiculo", codVehiculo);
            dataSet =
                conex.queryDataset(
                    "SELECT V.Cod_Vehiculo,V.Rego,V.RefVehiculo,C.NomConductor,Ubicacion,FechaHoraActividad FROM MONITOR..Vehiculo V INNER JOIN MONITOR..Conductor C ON V.Cod_Conductor = C.Cod_Conductor	WHERE V.Cod_Vehiculo = " +
                    codVehiculo.ToString());//conex.querySPDataset("SVC_QRY_CONSULTAINFORMACIONVEHICULO");

            if (dataSet != null)
            {
                if (dataSet.Tables.Count > 0)
                {
                    foreach (DataRow row in dataSet.Tables[0].Rows)
                    {
                        info.Patente = row.ItemArray[1].ToString();
                        info.UltimaActividad = row.ItemArray[5].ToString();
                        info.UltimaUbicacion = row.ItemArray[4].ToString();
                    }
                }
            }
            conex.Desconectar();

            conex = new sqlserver("Monitor");
            dataSet = new DataSet();
            conex.Conectar();
            //conex.addParametro("@codVehiculo", codVehiculo);
            dataSet =
                conex.queryDataset(
                    "SELECT Top 1 FechaHoraActividad, Ubicacion FROM MONITOR..Actividad WHERE Cod_Vehiculo = " + codVehiculo.ToString() + " ORDER BY Num_Actividad DESC");

            if (dataSet != null)
            {
                if (dataSet.Tables.Count > 0)
                {
                    foreach (DataRow row in dataSet.Tables[0].Rows)
                    {
                        info.UltimaActividad = row.ItemArray[0].ToString();
                        info.UltimaUbicacion = row.ItemArray[1].ToString();
                    }
                }
            }

            conex.Desconectar();

            return info;
        }
    }

    [Serializable]
    public class UnitInfo
    {
        public string NombreVehiculo { get; set; }
        public string Conductor { get; set; }
        public string Patente { get; set; }
        public string DistanciaRecorrida { get; set; }
        public double CombustibleComsumido { get; set; }
        public double RendimientoCombustible { get; set; }
        public string ExcesosRpm { get; set; }
        public string ExcesosVelocidad { get; set; }
        public double Frenados { get; set; }
        public string TiempoViaje { get; set; }
        public int TieneDatos { get; set; }
        public double TemperaturaPromedio { get; set; }
        public double VelocidadPromedio { get; set; }
        public double RpmPromedio { get; set; }
        public double DistanciaPromedio { get; set; }
        public string KmIniciales { get; set; }
        public string KmFinales { get; set; }
        public string HorasMotorIniciales { get; set; }
        public string HorasMotorFinales { get; set; }
        public string HorasMotorTotal { get; set; }
        public string Cargas { get; set; }
        public string Error { get; set; }
    }

    public class UnidadCango
    {
        public string CodVehiculo { get; set; }
        public string Rego { get; set; }
        public double LimiteRpm { get; set; }
        public double LimiteVelocidad { get; set; }
    }

    [Serializable]
    public class IdNameValue
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    [Serializable]
    public class GraphicInfo
    {
        public string NombreVehiculo { get; set; }
        public string Conductor { get; set; }
        public string Patente { get; set; }
        public string DistanciaRecorrida { get; set; }
        public double CombustibleComsumido { get; set; }
        public double RendimientoCombustible { get; set; }
        public string TiempoViaje { get; set; }
        public double TemperaturaPromedio { get; set; }
        public double VelocidadPromedio { get; set; }
        public double RpmPromedio { get; set; }
        public double DistanciaPromedio { get; set; }
        public double Frenados { get; set; }
        public string ExcesosRPMS { get; set; }
        public string ExcesosVelocidad { get; set; }
        public string LimiteExcesosRPM { get; set; }
        public string LimiteExcesosVelocidad { get; set; }
        public string[] Categorias { get; set; }
        public object[] Valores { get; set; }
        public string KmIniciales { get; set; }
        public string KmFinales { get; set; }
        public string HorasMotorIniciales { get; set; }
        public string HorasMotorFinales { get; set; }
        public string HorasMotorTotal { get; set; }
        public string UltimaActividad { get; set; }
        public string UltimaUbicacion { get; set; }
    }

    public class CombustibleUnidad
    {
        public virtual int Cod_Vehiculo { get; set; }
        public virtual string RefVehiculo { get; set; }
        public virtual DateTime FechaHoraActividad { get; set; }
        public virtual string NomConductor { get; set; }
        public virtual string Ubicacion { get; set; }
        public virtual bool TemperaturaActivo { get; set; }
    }

    public class Flota
    {
        public virtual int Cod_Flota { get; set; }
        public virtual string NomFlota { get; set; }
    }

    public class Grupo
    {
        public virtual int Cod_GrupoVehiculo { get; set; }
        public virtual string NomGrupoVehiculo { get; set; }
    }

    public class Unidad
    {
        public virtual int Cod_Vehiculo { get; set; }
        public virtual string RefVehiculo { get; set; }
        public virtual DateTime FechaHoraActividad { get; set; }
        public virtual string NomConductor { get; set; }
        public virtual bool TemperaturaActivo { get; set; }
    }

    public class nGrupo
    {
        public nGrupo() { }


        public List<Grupo> gruposPorFlota(int codFlota)
        {
            //declaraciones
            Grupo objGrupo = new Grupo();
            List<Grupo> lstGrupo = new List<Grupo>();

            sqlserver conex = new sqlserver("Monitor");
            DataSet dataSet = new DataSet();
            conex.Conectar();
            conex.addParametro("@Flota_Id", codFlota.ToString());
            dataSet = conex.querySPDataset("SVC_QRY_CONSULTARGRUPOS");
            conex.Desconectar();
            foreach (DataRow row in dataSet.Tables[0].Rows)
            {
                objGrupo = new Grupo();
                objGrupo.Cod_GrupoVehiculo = Int32.Parse(row["Cod_GrupoVehiculo"].ToString());
                objGrupo.NomGrupoVehiculo = row["NomGrupoVehiculo"].ToString();
                lstGrupo.Add(objGrupo);
            }
            return lstGrupo;
        }
    }

    public class nFlota
    {
        public nFlota() { }

        public List<Flota> flotasPorUsuario(int codUsuario)
        {
            List<Flota> lstFlotas = new List<Flota>();
            sqlserver conex = new sqlserver("Monitor");
            DataSet dataSet = new DataSet();
            conex.Conectar();
            conex.addParametro("@Cod_Usuario", codUsuario.ToString());
            dataSet = conex.querySPDataset("SVC_QRY_TEMPERATURA_FLOTAPORUSUARIO");
            conex.Desconectar();
            foreach (DataRow row in dataSet.Tables[0].Rows)
            {
                Flota objFlota = new Flota();
                objFlota.Cod_Flota = Int32.Parse(row["Cod_Flota"].ToString());
                objFlota.NomFlota = row["NomFlota"].ToString();
                lstFlotas.Add(objFlota);
            }
            return lstFlotas;
        }
    }

    [Serializable]
    public class CombustibleInfo
    {
        public string Patente { get; set; }
        public string Conductor { get; set; }
        public string UltimaPosicion { get; set; }
        public string UltimaActividad { get; set; }
        public string Odometro { get; set; }
        public string Velocidad { get; set; }
        public string Rendimiento { get; set; }
        public double NivelCombustible { get; set; }
        public string NivelCombustibleEstado { get; set; }
        public string Rpm { get; set; }
    }

    [Serializable]
    public class DetalleCombustibleCango
    {
        public string Fecha { get; set; }
        public string Patente { get; set; }
        public string Conductor { get; set; }
        public string PuntoInicial { get; set; }
        public string PuntoFinal { get; set; }
        public string Distancia { get; set; }
        public string CombustibleCopec { get; set; }
        public string CombustibleTotal { get; set; }
        public string CombustibleRalenti { get; set; }
        public string CombustibleActividad { get; set; }
        public string CombustiblePto { get; set; }
        public string NivelInicial { get; set; }
        public string NivelFinal { get; set; }
        public string Rendimiento { get; set; }
        public object Detalle { get; set; }
    }

    [Serializable]
    public class DetalleCombustibleCangoDia
    {
        //root: "Items", page: "CurrentPage", total: "PageCount", records: "RecordCount", repeatitems: false, cell: "Row", id: "ID" },

        public DetalleCangoDia[] Items { get; set; }
        public int CurrentPage { get; set; }
        public int RecordCount { get; set; }
        public int PageCount { get; set; }
    }

    [Serializable]
    public class DetalleCangoDia
    {
        public int Id { get; set; }
        public string Fecha { get; set; }
        public string Combustible { get; set; }
        public string Carga { get; set; }
        public double CombustibleRalenti { get; set; }
        public double CombustibleActivo { get; set; }
        public double CombustiblePto { get; set; }
        public string Odometro { get; set; }
        public string OdometroCarga { get; set; }
    }

    [Serializable]
    public class JQGrid
    {
        public class Row
        {
            public int id { get; set; }
            public List<string> cell { get; set; }

            public Row()
            {
                cell = new List<string>();
            }
        }

        public int page { get; set; }
        public int total { get; set; }
        public int records { get; set; }
        public List<Row> rows { get; set; }

        public JQGrid()
        {
            rows = new List<Row>();
        }
    }

    public class ArchivoExcel
    {
        public string Patente { get; set; }
        public DateTime Fecha { get; set; }
        public string Ubicacion { get; set; }
        public double Carga { get; set; }
        public double Odometro { get; set; }
        public double Precio { get; set; }
        public double Guia { get; set; }
        public double Rendimiento { get; set; }
    }

    public class InformacionMotor
    {
        public string Patente { get; set; }
        public string Conductor { get; set; }
        public string MotorMovimientoTiempo { get; set; }
        public string MotorMovimientoPorcentaje { get; set; }
        public string MotorRalentiTiempo { get; set; }
        public string MotorRalentiPorcentaje { get; set; }
        public string MotorPtoMovTiempo { get; set; }
        public string MotorPtoMovPorcentaje { get; set; }
        public string MotorPtoDetTiempo { get; set; }
        public string MotorPtoDetPorcentaje { get; set; }
        public string CombustibleMovimientoTiempo { get; set; }
        public string CombustibleMovimientoPorcentaje { get; set; }
        public string CombustibleRalentiTiempo { get; set; }
        public string CombustibleRalentiPorcentaje { get; set; }
        public string CombustiblePtoMovTiempo { get; set; }
        public string CombustiblePtoMovPorcentaje { get; set; }
        public string CombustiblePtoDetTiempo { get; set; }
        public string CombustiblePtoDetPorcentaje { get; set; }
        public string MotorTotal { get; set; }
        public string HorometroInicial { get; set; }
        public string HorometroFinal { get; set; }
        public string RalentiSobre5 { get; set; }
        public string RalentiSobre10 { get; set; }
        public string RalentiTotal { get; set; }
        public string PtoTotal { get; set; }
        public string Frenadas { get; set; }
        public string Embrague { get; set; }
        public string[] Fechas { get; set; }
    }

    public class ValoresInstantaneos
    {
        public string[] Categorias { get; set; }
        public SerieGrafico[] Series { get; set; }

    }

    public class SerieGrafico
    {
        public string name { get; set; }
        public float[] data { get; set; }
        public bool visible { get; set; }
    }

    public class EficienciaUnidad
    {
        public string Patente { get; set; }
        public string Conductor { get; set; }
        public string ExcesoRpm1 { get; set; }
        public string ExcesoRpm2 { get; set; }
        public string ExcesoRpm3 { get; set; }
        public string PonderacionRpm { get; set; }
        public string PuntajeRpm { get; set; }
        public string ExcesoVelocidad1 { get; set; }
        public string ExcesoVelocidad2 { get; set; }
        public string ExcesoVelocidad3 { get; set; }
        public string PonderacionVelocidad { get; set; }
        public string PuntajeVelocidad { get; set; }
        public string TiempoRalenti1 { get; set; }
        public string TiempoRalenti2 { get; set; }
        public string TiempoRalenti3 { get; set; }
        public string PonderacionRalenti { get; set; }
        public string PuntajeRalenti { get; set; }
        public string PromedioTorque1 { get; set; }
        public string TiempoTorque1 { get; set; }
        public string PonderacionTorque { get; set; }
        public string PuntajeTorque { get; set; }
        public string Embrague { get; set; }
        public string Acelerador { get; set; }
        public string Freno { get; set; }
        public string PonderacionPedales { get; set; }
        public string PuntajePedales { get; set; }
        public string Total { get; set; }
        public string HorasMotorTotal { get; set; }
    }

    public class InformacionPuntos
    {
        public string Patente { get; set; }
        public string Origen { get; set; }
        public string Destino { get; set; }
        public Cango[] Actividades { get; set; }
        public string FechaOrigen { get; set; }
        public string FechaDestino { get; set; }
        public string TiempoRecorrido { get; set; }
        public string KmsRecorridos { get; set; }
        public string LtrsConsumidos { get; set; }
        public string Rendimiento { get; set; }
        public DateTime Fecha { get; set; }
    }

    public class InfoDetalle
    {
        public string Patente { get; set; }
        public string Fecha { get; set; }
        public string KmsGps { get; set; }
        public string KmsEms { get; set; }
        public string KmsTct { get; set; }
        public string LtrsEms { get; set; }
        public string LtrsTct { get; set; }
        public string RendimientoEms { get; set; }
        public string RendimientoTct { get; set; }
        public string Lugar { get; set; }
        public string DiferenciaKms { get; set; }
        public string DiferenciaLtrs { get; set; }
    }

    public class InfoDetalleTobar
    {
        public string Patente { get; set; }
        public string Fecha { get; set; }
        public string Punto1 { get; set; }
        public string Punto2 { get; set; }
        public string Distancia { get; set; }
        public string DistanciaTct { get; set; }
        public string DistanciaGps { get; set; }
        public string CombustibleConsumido { get; set; }
        public string CombustibleCargado { get; set; }
        public string Rendimiento { get; set; }
        public string RendimientoTct { get; set; }
        public string OdometroSmm { get; set; }
        public string OdometroTct { get; set; }
        public string DiferenciaCombustible { get; set; }
        public string DiferenciaDistancia { get; set; }
        public string Razon { get; set; }
    }

    public class TempCango
    {
        public DateTime Fecha { get; set; }
        public List<GpsChile.Servicio.Ems.Clases.Cango.Trama.T1> Data { get; set; }
        public List<GpsChile.Servicio.Ems.Clases.Cango.Trama.T2> Data2 { get; set; }
    }

    [Serializable]
    public class AjustesCango
    {
        public Ajuste[] Ajustes { get; set; }
    }

    public class Ajuste
    {
        public int CodVehiculo { get; set; }
        public float AjusteOdometro { get; set; }
    }

    public class nUnidad
    {
        public nUnidad() { }
        public List<CombustibleUnidad> unidadesPorGrupo(string Cod_Grupo)
        {
            List<CombustibleUnidad> unidades = new List<CombustibleUnidad>();

            CombustibleUnidad unidad = new CombustibleUnidad();
            sqlserver conex = new sqlserver("Monitor");
            DataSet dataSet = new DataSet();
            conex.Conectar();
            conex.addParametro("@Cod_Grupo", Cod_Grupo.ToString());
            dataSet = conex.querySPDataset("SVC_QRY_TEMPERATURACONSULTARVEHICULOSSEGUNGRUPO");
            conex.Desconectar();
            foreach (DataRow row in dataSet.Tables[0].Rows)
            {
                try
                {
                    unidad = new CombustibleUnidad();
                    unidad.Cod_Vehiculo = Int32.Parse(row["Cod_Vehiculo"].ToString());
                    unidad.RefVehiculo = row["RefVehiculo"].ToString();
                    unidad.FechaHoraActividad = DateTime.Parse(row["FechaHoraActividad"].ToString());
                    unidad.NomConductor = row["NomConductor"].ToString();
                    unidad.TemperaturaActivo = Boolean.Parse(row["TemperaturaActivo"].ToString());
                }
                catch (Exception ex)
                {
                    string msg = ex.Message.ToString();
                }

                unidades.Add(unidad);

            }
            return unidades;
        }

        public List<CombustibleUnidad> unidadesPorFlota(string codFlota)
        {
            List<CombustibleUnidad> unidades = new List<CombustibleUnidad>();

            CombustibleUnidad unidad = new CombustibleUnidad();
            sqlserver conex = new sqlserver("Monitor");
            DataSet dataSet = new DataSet();
            conex.Conectar();
            conex.addParametro("@ListaFlotas", codFlota);
            dataSet = conex.querySPDataset("SVC_QRY_VEHICULOPORFLOTA");
            conex.Desconectar();
            foreach (DataRow row in dataSet.Tables[0].Rows)
            {
                try
                {
                    unidad = new CombustibleUnidad();
                    unidad.Cod_Vehiculo = Int32.Parse(row["Cod_Vehiculo"].ToString());
                    unidad.RefVehiculo = row["RefVehiculo"].ToString();
                    unidad.FechaHoraActividad = DateTime.Parse(row["FechaHoraActividad"].ToString());
                    unidad.NomConductor = row["NomConductor"].ToString();
                    //unidad.TemperaturaActivo = Boolean.Parse(row["TemperaturaActivo"].ToString());
                }
                catch (Exception ex)
                {
                    string msg = ex.Message.ToString();
                }

                unidades.Add(unidad);

            }
            return unidades;
        }

        public string unidadTemperaturaActivo(string pNum_Unidad, string pLogin)
        {
            string retorno = "1";
            try
            {
                sqlserver conex = new sqlserver("Corporativo");
                conex.Conectar();
                conex.addParametro("@pNum_Unidad", pNum_Unidad.ToString());
                conex.addParametro("@pLogin", pLogin);
                conex.ejecutarSPNoReturn("HSVC_UPD_TEMPERATURAACTIVO");
                conex.Desconectar();
            }
            catch (Exception ex)
            {
                retorno = "0";
            }
            return retorno;
        }
    }
}
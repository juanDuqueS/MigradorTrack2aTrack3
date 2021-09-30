using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using GpsChile.Servicio.Ems.Ado;
using System.Data.SqlClient;
using CangoDatos;

namespace GpsChile.Servicio.Ems.Clases
{
    public class Proceso
    {

        public static Respuesta ViajeEMS(string Cod_Vehiculo, string FechaInicio, string FechaTermino)
        {
            Respuesta respuesta = new Respuesta();

            long vehiculo;
            string IdVehiculo = "";

            respuesta.Estado = false;

            if (!long.TryParse(Cod_Vehiculo, out vehiculo))
            {
                respuesta.descripcion = "El parámetro vehículo debe ser numérico";
                return respuesta;
            }

            if (!Utilidad.ValidaFecha(FechaInicio))
            {
                respuesta.descripcion = "El formato de fecha no es el correcto para el parámetro FechaInicio";
                return respuesta;
            }

            if (!Utilidad.ValidaFecha(FechaTermino))
            {
                respuesta.descripcion = "El formato de fecha no es el correcto para el parámetro FechaTermino";

                return respuesta;
            }


            ObtieneIdVehiculoAvl(long.Parse(Cod_Vehiculo), out IdVehiculo);
            if (IdVehiculo != null)
            {

                if (!IdVehiculo.Equals("0"))
                {
                    ObtieneDatosEms(IdVehiculo, FechaInicio, FechaTermino, out respuesta);

                    if (respuesta == null)
                    {
                        respuesta = new Respuesta();
                        respuesta.Estado = false;
                        respuesta.descripcion = "No existen datos asociados al periodo de consulta";
                        return respuesta;
                    }
                    else
                    {
                        return respuesta;
                    }
                }
                else
                {
                    respuesta.descripcion = "Ocurrió un error al obtener el identificador del vehículo";
                    return respuesta;
                }

            }
            else
            {
                respuesta.descripcion = "El vehículo no existe.";
                return respuesta;
            }

        }

        private static void ObtieneDatosEms(string IdVehiculo, string FechaInicio, string FechaTermino, out Respuesta respuesta)
        {
            respuesta = null;

            try
            {

                DataSet ds = new DataSet();

                StringBuilder builder = new StringBuilder();
                builder.Append("      SELECT T.TripId ");
                builder.Append("      ,T.VehicleId ");
                builder.Append("      ,T.DriverId ");
                builder.Append("      ,T.StartDateTime ");
                builder.Append("      ,T.StartLatitude ");
                builder.Append("      ,T.StartLongitude ");
                builder.Append("      ,T.StartLocation ");
                builder.Append("      ,T.StartOdometer ");
                builder.Append("      ,T.StopDateTime ");
                builder.Append("      ,T.StopLatitude ");
                builder.Append("      ,T.StopLongitude ");
                builder.Append("      ,T.StopLocation ");
                builder.Append("      ,T.Distance ");
                builder.Append("      ,T.EngineHours ");
                builder.Append("      ,T.WarmSeconds ");
                builder.Append("      ,T.IdleSeconds ");
                builder.Append("      ,T.ExcessIdleSeconds ");
                builder.Append("      ,T.RollingSeconds ");
                builder.Append("      ,T.KeyOnSeconds ");
                builder.Append("      ,T.PTOSeconds ");
                builder.Append("      ,T.PTOIdleSeconds ");
                builder.Append("      ,T.PTORollSeconds ");
                builder.Append("      ,T.PTOOverRPMSeconds ");
                builder.Append("      ,T.OverSpeedCount ");
                builder.Append("      ,T.OverSpeedSeconds ");
                builder.Append("      ,T.MaxSpeed ");
                builder.Append("      ,T.OverRPMCount ");
                builder.Append("      ,T.OverRPMSeconds ");
                builder.Append("      ,T.MaxRPM ");
                builder.Append("      ,T.OverTempSeconds ");
                builder.Append("      ,T.MaxTemp ");
                builder.Append("      ,T.UnderOilSeconds ");
                builder.Append("      ,T.MinOil ");
                builder.Append("      ,T.FuelUsedRoll ");
                builder.Append("      ,T.FuelUsedIdle ");
                builder.Append("      ,T.FuelUsedPTORoll ");
                builder.Append("      ,T.FuelUsedPTOIdle ");
                builder.Append("      ,T.BrakeCount ");
                builder.Append("      ,T.BrakeDistance ");
                builder.Append("      ,T.BrakeOn ");
                builder.Append("      ,T.BrakeRoll ");
                builder.Append("      ,T.HeavyBrakeCount ");
                builder.Append(" FROM EMSService.Trip T WITH (NOLOCK) ");
                builder.Append(" WHERE T.VehicleId = '" + IdVehiculo + "' ");
                builder.Append("  AND T.StopDateTime >= '" + FechaInicio + "' ");
                builder.Append("  AND T.StopDateTime <= '" + FechaTermino + "' ");
                builder.Append(" ORDER BY T.StopDateTime ASC ");

                ds = SqlServer.ObtieneDataSet(builder.ToString(), Utilidad.obtieneValorAppSeting("OnlineAVL2"));

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        respuesta = new Respuesta();
                        respuesta.Estado = true;
                        foreach (DataRow fila in ds.Tables[0].Rows)
                        {
                            respuesta.Viajes.Add(Proceso.CreaViaje(fila));
                        }
                        respuesta.descripcion = "Consulta procesada correctamente.";
                    }
                }

            }
            catch (Exception ex)
            {
                respuesta = new Respuesta();
                respuesta.Estado = false;
                //respuesta.descripcion = "Ocurrió un problema al procesar la consulta.";
                respuesta.descripcion = ex.Message;
            }

        }

        public static Viaje CreaViaje(DataRow fila)
        {
            try
            {
                Viaje viaje = new Viaje();
                viaje.TripID = fila["TripID"].ToString();
                viaje.VehicleId = fila["VehicleId"].ToString();
                viaje.DriverId = fila["DriverId"].ToString();
                viaje.StartDateTime = fila["StartDateTime"].ToString();
                viaje.StartLatitude = fila["StartLatitude"].ToString();
                viaje.StartLongitude = fila["StartLongitude"].ToString();
                viaje.StartLocation = fila["StartLocation"].ToString();
                viaje.StartOdometer = fila["StartOdometer"].ToString();
                viaje.StopDateTime = fila["StopDateTime"].ToString();
                viaje.StopLatitude = fila["StopLatitude"].ToString();
                viaje.StopLongitude = fila["StopLongitude"].ToString();
                viaje.StopLocation = fila["StopLocation"].ToString();
                viaje.Distance = fila["Distance"].ToString();
                viaje.EngineHours = fila["EngineHours"].ToString();
                viaje.WarmSeconds = fila["WarmSeconds"].ToString();
                viaje.IdleSeconds = fila["IdleSeconds"].ToString();
                viaje.ExcessIdleSeconds = fila["ExcessIdleSeconds"].ToString();
                viaje.RollingSeconds = fila["RollingSeconds"].ToString();
                viaje.KeyOnSeconds = fila["KeyOnSeconds"].ToString();
                viaje.PTOSeconds = fila["PTOSeconds"].ToString();
                viaje.PTOIdleSeconds = fila["PTOIdleSeconds"].ToString();
                viaje.PTORollSeconds = fila["PTORollSeconds"].ToString();
                viaje.PTOOverRPMSeconds = fila["PTOOverRPMSeconds"].ToString();
                viaje.OverSpeedCount = fila["OverSpeedCount"].ToString();
                viaje.OverSpeedSeconds = fila["OverSpeedSeconds"].ToString();
                viaje.MaxSpeed = fila["MaxSpeed"].ToString();
                viaje.OverRPMCount = fila["OverRPMCount"].ToString();
                viaje.OverRPMSeconds = fila["OverRPMSeconds"].ToString();
                viaje.MaxRPM = fila["MaxRPM"].ToString();
                viaje.OverTempSeconds = fila["OverTempSeconds"].ToString();
                viaje.MaxTemp = fila["MaxTemp"].ToString();
                viaje.UnderOilSeconds = fila["UnderOilSeconds"].ToString();
                viaje.MinOil = fila["MinOil"].ToString();
                viaje.FuelUsedRoll = fila["FuelUsedRoll"].ToString();
                viaje.FuelUsedIdle = fila["FuelUsedIdle"].ToString();
                viaje.FuelUsedPTORoll = fila["FuelUsedPTORoll"].ToString();
                viaje.FuelUsedPTOIdle = fila["FuelUsedPTOIdle"].ToString();
                viaje.BrakeCount = fila["BrakeCount"].ToString();
                viaje.BrakeDistance = fila["BrakeDistance"].ToString();
                viaje.BrakeOn = fila["BrakeOn"].ToString();
                viaje.BrakeRoll = fila["BrakeRoll"].ToString();
                viaje.HeavyBrakeCount = fila["HeavyBrakeCount"].ToString();

                return viaje;

            }
            catch (Exception)
            {

                throw;
            }

        }

        private static void ObtieneIdVehiculoAvl(long Cod_Vehiculo, out string Id_VehiculoAvl2)
        {
            try
            {
                Id_VehiculoAvl2 = null;
                DataSet ds = new DataSet();
                List<SqlParametro> lstParametro = new List<SqlParametro>();

                lstParametro.Add(new SqlParametro("@Cod_Vehiculo", DbType.Int64, Cod_Vehiculo));
                ds = SqlServer.ObtieneDataSet(lstParametro, "SVC_QRY_OBTIENEIDVEHICULOAVL2", Utilidad.obtieneValorAppSeting("MONITOR_SQL1"));
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {

                        foreach (DataRow fila in ds.Tables[0].Rows)
                        {
                            Id_VehiculoAvl2 = fila["Cod_VehiculoAvl2"].ToString();
                        }
                    }
                }
            }
            catch (Exception)
            {
                Id_VehiculoAvl2 = "0";
            }

        }

        public static Respuesta ViajeCango(string Cod_Vehiculo, string FechaInicio, string FechaTermino)
        {
            Respuesta respuesta = new Respuesta();
            Utilidad.validaEntrada(Cod_Vehiculo, FechaInicio, FechaTermino, out respuesta);
            if (respuesta.Estado)
            {
                ObtieneDatosCango(Cod_Vehiculo, FechaInicio, FechaTermino, out respuesta);
                return respuesta;
            }
            return respuesta;
        }

        public static Respuesta ViajeCangoPorPuntos(string Cod_Vehiculo, string FechaInicio, string FechaTermino)
        {
            Respuesta respuesta = new Respuesta();
            Utilidad.validaEntrada(Cod_Vehiculo, FechaInicio, FechaTermino, out respuesta);
            if (respuesta.Estado)
            {
                ObtieneDatosCangoPorPuntos(Cod_Vehiculo, FechaInicio, FechaTermino, out respuesta);
                return respuesta;
            }
            return respuesta;
        }

        public static Respuesta ObtenerDatosTotales(int cod_vehiculo)
        {
            Respuesta respuesta = new Respuesta();

            ObtieneDatosCangoTotales(cod_vehiculo, out respuesta);

            return respuesta;
        }

        private static void ObtieneDatosCango(string Cod_Vehiculo, string FechaInicio, string FechaTermino, out Respuesta respuesta)
        {
            try
            {
                respuesta = new Respuesta();
                List<SqlParametro> lstParametro = new List<SqlParametro>();
                DataSet ds = new DataSet();
                lstParametro.Add(new SqlParametro("@Cod_Vehiculo", DbType.Int64, long.Parse(Cod_Vehiculo)));
                lstParametro.Add(new SqlParametro("@FInicio", DbType.String, FechaInicio));
                lstParametro.Add(new SqlParametro("@FFIN", DbType.String, FechaTermino));

                ds=SqlServer.ObtieneDataSet(lstParametro,"SVC_QRY_SMMDATOS",Utilidad.obtieneValorAppSeting("PERIFERICO"));

                var culture = new System.Globalization.CultureInfo("en-US");

                if (ds != null)
                {
                    respuesta.Estado = true;

                    float ajuste = 0;

                    var path = System.Web.Hosting.HostingEnvironment.MapPath("\\Logs") + "\\" + "configuraciones.xml";

                    var serializer = new System.Xml.Serialization.XmlSerializer(typeof(AjustesCango));
                    var fs = new System.IO.FileStream(path, System.IO.FileMode.Open);
                    var conf = (AjustesCango)serializer.Deserialize(fs);

                    if (conf.Ajustes.Where(c => c.CodVehiculo == int.Parse(Cod_Vehiculo)).Count() > 0)
                    {
                        ajuste = conf.Ajustes.Where(c => c.CodVehiculo == int.Parse(Cod_Vehiculo)).FirstOrDefault().AjusteOdometro;
                    }

                    fs.Close();

                    foreach (DataRow fila in ds.Tables[0].Rows)
                    {
                        try
                        {
                            var viaje = new Cango.Cango(fila["DatosExtendidos"].ToString(), fila["FechaHoraActividad"].ToString());
                            viaje.T2.mileage = (float.Parse(viaje.T2.mileage, culture.NumberFormat) + (ajuste)).ToString().Replace(",", ".");

                            respuesta.ViajesCango.Add(viaje);
                        }
                        catch (Exception)
                        {

                        }
                    }

                   respuesta.ViajesCango = respuesta.ViajesCango.OrderBy(c => CangoUtilidades.ParseMyDateWithHour(c.Spreadsheet.FechaActividad)).ToList();

                    respuesta.descripcion = "Consulta procesada correctamente.";

                }
                else
                    respuesta.descripcion = "No existen datos para el periodo.";
            }
            catch (Exception ex)
            {
                respuesta = new Respuesta();
                respuesta.Estado = false;
                respuesta.descripcion = ex.Message;
            }
        }

        private static void ObtieneDatosCangoPorPuntos(string Cod_Vehiculo, string FechaInicio, string FechaTermino, out Respuesta respuesta)
        {
            try
            {
                respuesta = new Respuesta();
                List<SqlParametro> lstParametro = new List<SqlParametro>();
                DataSet ds = new DataSet();
                lstParametro.Add(new SqlParametro("@Cod_Vehiculo", DbType.Int64, long.Parse(Cod_Vehiculo)));
                lstParametro.Add(new SqlParametro("@FINICIO", DbType.String, FechaInicio));
                lstParametro.Add(new SqlParametro("@FFIN", DbType.String, FechaTermino));

                var query = "DECLARE @actividades TABLE(Num_Actividad bigint,FechaHoraActividad datetime,Ubicacion varchar(200),Cod_Vehiculo int,Latitud float,Longitud float, Odometro float); ";
                query += "";
                query += "INSERT INTO @actividades SELECT Num_Actividad,FechaHoraActividad,Ubicacion,Cod_Vehiculo,Latitud,Longitud,Odometro FROM MONITOR.dbo.Vista_ActividadesDiarias WHERE Cod_Vehiculo = " + Cod_Vehiculo + " AND (FechaHoraActividad >= '" + FechaInicio + "' AND FechaHoraActividad <= '" + FechaTermino + "');";
                query += "";
                query += "SELECT AE.DatosExtendidos,CONVERT(VARCHAR(20),AE.FechaHoraActividad,112) + ' ' + CONVERT(VARCHAR(20),AE.FechaHoraActividad,108) AS FechaHoraActividad,A.Latitud,A.Longitud,A.Odometro FROM PERIFERICO..CangoActividadExtend AE INNER JOIN @actividades A ON AE.Num_Actividad = A.Num_Actividad WHERE AE.Cod_Vehiculo = " + Cod_Vehiculo + " AND AE.FechaHoraActividad BETWEEN '" + FechaInicio + "' AND '" + FechaTermino + "'";

                ds = SqlServer.ObtieneDataSet(lstParametro, "SVC_QRY_DATOSSMM_CON_POSICIONAMIENTO", Utilidad.obtieneValorAppSeting("PERIFERICO"));
                //ds = SqlServer.ObtieneDataSet(query, Utilidad.obtieneValorAppSeting("MONITOR_SQL1"));
                //ds = SqlServer.ObtieneDataSet(lstParametro, "SVC_QRY_OBTIENEDATOSCANGOPORPUNTOS", Utilidad.obtieneValorAppSeting("MONITOR_SQL1"));

                var culture = new System.Globalization.CultureInfo("en-US");

                if (ds != null)
                {
                    respuesta.Estado = true;

                    float ajuste = 0;

                    var path = System.Web.Hosting.HostingEnvironment.MapPath("\\Logs") + "\\" + "configuraciones.xml";

                    var serializer = new System.Xml.Serialization.XmlSerializer(typeof(AjustesCango));
                    var fs = new System.IO.FileStream(path, System.IO.FileMode.Open);
                    var conf = (AjustesCango)serializer.Deserialize(fs);

                    if (conf.Ajustes.Where(c => c.CodVehiculo == int.Parse(Cod_Vehiculo)).Count() > 0)
                    {
                        ajuste = conf.Ajustes.Where(c => c.CodVehiculo == int.Parse(Cod_Vehiculo)).FirstOrDefault().AjusteOdometro;
                    }

                    fs.Close();

                    foreach (DataRow fila in ds.Tables[0].Rows)
                    {
                        try
                        {
                            double latitud = Convert.ToDouble(fila["Latitud"]);
                            double longitud = Convert.ToDouble(fila["Longitud"]);
                            double odometro = Convert.ToDouble(fila["Odometro"]);

                            var viaje = new Cango.Cango(fila["DatosExtendidos"].ToString(), fila["FechaHoraActividad"].ToString(), latitud, longitud, odometro);
                            viaje.T2.mileage = (float.Parse(viaje.T2.mileage, culture.NumberFormat) + (ajuste)).ToString();

                            respuesta.ViajesCango.Add(viaje);
                        }
                        catch (Exception)
                        {

                        }
                    }

                    respuesta.ViajesCango = respuesta.ViajesCango.OrderBy(c => CangoDatos.CangoUtilidades.ParseMyDateWithHour(c.Spreadsheet.FechaActividad)).ToList();

                    respuesta.descripcion = "Consulta procesada correctamente.";

                }
                else
                    respuesta.descripcion = "No existen datos para el periodo.";
            }
            catch (Exception ex)
            {
                respuesta = new Respuesta();
                respuesta.Estado = false;
                respuesta.descripcion = ex.Message;
            }
        }

        private static void ObtieneDatosCangoTotales(int cod_Vehiculo, out Respuesta respuesta)
        {
            try
            {
                respuesta = new Respuesta();

                SqlConnection conexion = new SqlConnection(Utilidad.obtieneValorAppSeting("PERIFERICO"));
                conexion.Open();

                SqlCommand comando=new SqlCommand("SVC_SMM_OBTIENEDATOSCANGOTOTALES "+ cod_Vehiculo.ToString());
                //SqlCommand comando = new SqlCommand(query, conexion);

                var reader = comando.ExecuteReader();

                List<Cango.Cango> data = new List<Cango.Cango>();

                while (reader.Read())
                {
                    respuesta.Estado = true;

                    try
                    {
                        respuesta.ViajesCango.Add(new Cango.Cango(reader.GetInt32(0), reader.GetString(1), reader.GetString(3), reader.GetString(5), reader.GetDateTime(6).ToString()));
                    }
                    catch (Exception)
                    {

                    }

                    respuesta.descripcion = "Consulta procesada correctamente.";
                }

                reader.Close();
                conexion.Close();
            }
            catch (Exception ex)
            {
                respuesta = new Respuesta();
                respuesta.Estado = false;
                respuesta.descripcion = ex.Message;
            }
        }
    }
}
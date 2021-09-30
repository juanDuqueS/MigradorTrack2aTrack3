using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.Web;

namespace GpsChile.Servicio.Ems.Clases
{
    public class Utilidad
    {

        public static bool ValidaFecha(string Fecha)
        {
            CultureInfo enUS = new CultureInfo("en-US");
            DateTime result = new DateTime();
            return DateTime.TryParseExact(Fecha, "yyyyMMdd HH:mm:ss", enUS, DateTimeStyles.None, out result);
        }

        public static string obtieneValorAppSeting(string nombre)
        {
            try
            {
                return ConfigurationManager.AppSettings[nombre].ToString();
            }
            catch (Exception)
            {

                throw;
            }

        }

        public static void validaEntrada(string Cod_Vehiculo, string FechaInicio, string FechaTermino, out Respuesta respuesta)
        {
            long vehiculo;
            respuesta = new Respuesta();
            respuesta.Estado = true;
            if (!long.TryParse(Cod_Vehiculo, out vehiculo))
            {
                respuesta.descripcion = "El parámetro vehículo debe ser numérico";
                respuesta.Estado = false;
               
            }

            if (!Utilidad.ValidaFecha(FechaInicio))
            {
                respuesta.descripcion = "El formato de fecha no es el correcto para el parámetro FechaInicio";
                respuesta.Estado = false;
                
            }

            if (!Utilidad.ValidaFecha(FechaTermino))
            {
                respuesta.descripcion = "El formato de fecha no es el correcto para el parámetro FechaTermino";
                respuesta.Estado = false;
            }
        }
    }
}
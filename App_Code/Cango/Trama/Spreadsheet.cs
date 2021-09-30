using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GpsChile.Servicio.Ems.Clases.Cango
{
    public class Spreadsheet
    {
        public int CodigoVehiculo { get; set; }
        public string Patente { get; set; }
        public string Flota { get; set; }
        public string PTO_engagement { get; set; }
        public string FechaActividad { get; set; }
        public double Latitud { get; set; }
        public double Longitud { get; set; }
        public double Odometro { get; set; }
        
        public Spreadsheet() { }
        public Spreadsheet(string trama,string FechaActividad) 
        {
            List<string> lstTrama = trama.Split(',').ToList();
            this.PTO_engagement = lstTrama[2];
            this.FechaActividad = FechaActividad;
        }
        public Spreadsheet(string trama, string FechaActividad, double latitud, double longitud)
        {
            List<string> lstTrama = trama.Split(',').ToList();
            this.PTO_engagement = lstTrama[2];
            this.FechaActividad = FechaActividad;
            this.Latitud = latitud;
            this.Longitud = longitud;
        }  
    }
}
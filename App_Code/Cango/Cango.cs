using GpsChile.Servicio.Ems.Clases.Cango.Trama;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace GpsChile.Servicio.Ems.Clases.Cango
{
    public class Cango
    {
        public Spreadsheet Spreadsheet { get; set; }
        public T1 T1 { get; set; }
        public T2 T2 { get; set; }

        public Cango() { }

        public Cango(int codVehiculo, string flota, string patente, string DatosExtendidos, string FechaActividad)
        {
            List<string> lstDatosExtendidos = Regex.Split(DatosExtendidos, Utilidad.obtieneValorAppSeting("SeparacionTramaCango")).ToList(); ;

            this.Spreadsheet = new Spreadsheet(lstDatosExtendidos[0], FechaActividad);
            this.T1 = new T1(lstDatosExtendidos[1]);
            this.T2 = new T2(lstDatosExtendidos[2]);

            this.Spreadsheet.CodigoVehiculo = codVehiculo;
            this.Spreadsheet.Flota = flota;
            this.Spreadsheet.Patente = patente;
        }

        public Cango(string DatosExtendidos,string FechaActividad)
        {
            List<string> lstDatosExtendidos = Regex.Split(DatosExtendidos, Utilidad.obtieneValorAppSeting("SeparacionTramaCango")).ToList(); ;

            this.Spreadsheet = new Spreadsheet(lstDatosExtendidos[0], FechaActividad);
            this.T1 = new T1(lstDatosExtendidos[1]);
            this.T2 = new T2(lstDatosExtendidos[2]);
        }

        public Cango(string DatosExtendidos, string FechaActividad, double latitud, double longitud)
        {
            List<string> lstDatosExtendidos = Regex.Split(DatosExtendidos, Utilidad.obtieneValorAppSeting("SeparacionTramaCango")).ToList(); ;

            this.Spreadsheet = new Spreadsheet(lstDatosExtendidos[0], FechaActividad, latitud, longitud);
            this.T1 = new T1(lstDatosExtendidos[1]);
            this.T2 = new T2(lstDatosExtendidos[2]);
        }

        public Cango(string DatosExtendidos, string FechaActividad, double latitud, double longitud, double odometro)
        {
            List<string> lstDatosExtendidos = Regex.Split(DatosExtendidos, Utilidad.obtieneValorAppSeting("SeparacionTramaCango")).ToList(); ;

            this.Spreadsheet = new Spreadsheet(lstDatosExtendidos[0], FechaActividad, latitud, longitud);
            this.Spreadsheet.Odometro = odometro;
            this.T1 = new T1(lstDatosExtendidos[1]);
            this.T2 = new T2(lstDatosExtendidos[2]);
        }
    }
}
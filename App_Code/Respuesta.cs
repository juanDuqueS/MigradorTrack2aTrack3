using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace GpsChile.Servicio.Ems.Clases
{
    public class Respuesta
    {
        public bool Estado = false;
        public string descripcion = "";
        public List<Viaje> Viajes = new List<Viaje>();
        public List<Cango.Cango> ViajesCango = new List<Cango.Cango>();

        public Respuesta()
        {

            
        }
    }
}
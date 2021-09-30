using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GpsChile.Servicio.Ems.Ado
{
    public class Mobileyentend
    {
        public string valor1 { get; set; }
        public string valor2 { get; set; }
        public string valor3 { get; set; }
        public string valor4 { get; set; }
        public string valor5 { get; set; }
        public Mobileyentend()
        { 
        }

        public Mobileyentend(string trama)
        {
            
            List<string> lstTrama = trama.Split(',').ToList();

            this.valor1= lstTrama[0];
            this.valor2= lstTrama[1];
            this.valor3= lstTrama[2];
            this.valor4= lstTrama[3];
            this.valor5= lstTrama[4];


        
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GpsChile.Servicio.Ems.Clases.Cango.Trama
{
    public class T1
    {
        public string speed { get; set; }
        public string engine { get; set; }
        public string fuel_consumption { get; set; }
        public string fuel_level_pri_tank { get; set; }
        public string axel_weight_1 { get; set; }
        public string axel_weight_2 { get; set; }
        public string axel_weight_3 { get; set; }
        public string axel_weight_4 { get; set; }
        public string turbo_pressure { get; set; }
        public string coolant_temp { get; set; }
        public string acc_pedal { get; set; }
        public string torque { get; set; }
        public string version { get; set; }
        public string bat_voltage { get; set; }
        public string coolant_level { get; set; }
        public string oil_temp { get; set; }
        public string oil_level { get; set; }
        public string throttel_position { get; set; }
        public string air_inlet_pressure { get; set; }
        public string fuel_level_sec_tank { get; set; }
        public string trans_current_gear { get; set; }
        public string seat_belt { get; set; }

        public T1()
        { 
        }

        public T1(string trama)
        {
            
            List<string> lstTrama = trama.Split(',').ToList();

            this.speed= lstTrama[2];
            this.engine= lstTrama[3];
            this.fuel_consumption= lstTrama[4];
            this.fuel_level_pri_tank= lstTrama[5];
            this.axel_weight_1= lstTrama[6];
            this.axel_weight_2= lstTrama[7];
            this.axel_weight_3= lstTrama[8];
            this.axel_weight_4= lstTrama[9];
            this.turbo_pressure= lstTrama[10];
            this.coolant_temp= lstTrama[11];
            this.acc_pedal= lstTrama[12];
            this.torque= lstTrama[13];
            this.version= lstTrama[14];
            this.bat_voltage= lstTrama[15];
            this.coolant_level= lstTrama[16];
            this.oil_temp= lstTrama[17];
            this.oil_level= lstTrama[18];
            this.throttel_position= lstTrama[19];
            this.air_inlet_pressure= lstTrama[20];
            this.fuel_level_sec_tank= lstTrama[21];
            this.trans_current_gear= lstTrama[22];
            this.seat_belt= lstTrama[23];


        
        }
    }
}
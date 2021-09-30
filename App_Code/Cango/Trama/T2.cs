using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GpsChile.Servicio.Ems.Clases.Cango.Trama
{
    public class T2
    {
        public string mileage { get; set; }
        public string total_fuel { get; set; }
        public string fuel_used_at_cruise { get; set; }
        public string fuel_used_at_drive { get; set; }
        public string idle_longer_than_5_minutes { get; set; }
        public string idle_longer_than_10_minutes { get; set; }
        public string total_idle_time { get; set; }
        public string total_time_pto { get; set; }
        public string time_cruise { get; set; }
        public string rpm_greater_than_threshold_rpm_1 { get; set; }
        public string rpm_greater_than_threshold_rpm_2 { get; set; }
        public string speed_greater_than_threshold_speed_1 { get; set; }
        public string speed_greater_than_threshold_speed_2 { get; set; }
        public string speed_greater_than_threshold_speed_3 { get; set; }
        public string brake_apps { get; set; }
        public string clutch_apps { get; set; }
        public string engine_on { get; set; }
        public string time_torque_greater_than_90 { get; set; }

        public T2()
        { 
        
        }
        public T2(string trama)
        {
            List<string> lstTrama = trama.Split(',').ToList();

            this.mileage= lstTrama[2];
            this.total_fuel= lstTrama[3];
            this.fuel_used_at_cruise= lstTrama[4];
            this.fuel_used_at_drive= lstTrama[5];
            this.idle_longer_than_5_minutes= lstTrama[6];
            this.idle_longer_than_10_minutes= lstTrama[7];
            this.total_idle_time= lstTrama[8];
            this.total_time_pto= lstTrama[9];
            this.time_cruise= lstTrama[10];
            this.rpm_greater_than_threshold_rpm_1= lstTrama[11];
            this.rpm_greater_than_threshold_rpm_2= lstTrama[12];
            this.speed_greater_than_threshold_speed_1= lstTrama[13];
            this.speed_greater_than_threshold_speed_2= lstTrama[14];
            this.speed_greater_than_threshold_speed_3= lstTrama[15];
            this.brake_apps= lstTrama[16];
            this.clutch_apps= lstTrama[17];
            this.engine_on= lstTrama[18];
            this.time_torque_greater_than_90= lstTrama[19];

        }
    }
}
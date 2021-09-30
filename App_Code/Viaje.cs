using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace GpsChile.Servicio.Ems.Clases
{
    public class Viaje
    {
        public string TripID = "";
        public string VehicleId = "";
        public string DriverId = "";
        public string StartDateTime = "";
        public string StartLatitude = "";
        public string StartLongitude = "";
        public string StartLocation = "";
        public string StartOdometer = "";
        public string StopDateTime = "";
        public string StopLatitude = "";
        public string StopLongitude = "";
        public string StopLocation = "";
        public string Distance = "";
        public string EngineHours = "";
        public string WarmSeconds = "";
        public string IdleSeconds = "";
        public string ExcessIdleSeconds = "";
        public string RollingSeconds = "";
        public string KeyOnSeconds = "";
        public string PTOSeconds = "";
        public string PTOIdleSeconds = "";
        public string PTORollSeconds = "";
        public string PTOOverRPMSeconds = "";
        public string OverSpeedCount = "";
        public string OverSpeedSeconds = "";
        public string MaxSpeed = "";
        public string OverRPMCount = "";
        public string OverRPMSeconds = "";
        public string MaxRPM = "";
        public string OverTempSeconds = "";
        public string MaxTemp = "";
        public string UnderOilSeconds = "";
        public string MinOil = "";
        public string FuelUsedRoll = "";
        public string FuelUsedIdle = "";
        public string FuelUsedPTORoll = "";
        public string FuelUsedPTOIdle = "";
        public string BrakeCount = "";
        public string BrakeDistance = "";
        public string BrakeOn = "";
        public string BrakeRoll = "";
        public string HeavyBrakeCount = "";
        

        public Viaje()
        {
       
        }

    }
}
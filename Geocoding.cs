using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;

namespace Geocoding
{
    public class Geocoding
    {

        [XmlRoot(ElementName = "gMapsResponse", Namespace = "http://tempuri.org/")]
        public class GMapsResponse
        {
            [XmlElement(ElementName = "gMapsResult", Namespace = "http://tempuri.org/")]
            public string GMapsResult { get; set; }
            [XmlAttribute(AttributeName = "xmlns")]
            public string Xmlns { get; set; }
        }

        [XmlRoot(ElementName = "Body", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
        public class Body
        {
            [XmlElement(ElementName = "gMapsResponse", Namespace = "http://tempuri.org/")]
            public GMapsResponse GMapsResponse { get; set; }
        }

        [XmlRoot(ElementName = "Envelope", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
        public class Envelope
        {
            [XmlElement(ElementName = "Body", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
            public Body Body { get; set; }
            [XmlAttribute(AttributeName = "soap", Namespace = "http://www.w3.org/2000/xmlns/")]
            public string Soap { get; set; }
            [XmlAttribute(AttributeName = "xsi", Namespace = "http://www.w3.org/2000/xmlns/")]
            public string Xsi { get; set; }
            [XmlAttribute(AttributeName = "xsd", Namespace = "http://www.w3.org/2000/xmlns/")]
            public string Xsd { get; set; }
        }



        private HttpWebRequest CreateSOAPWebRequest()
        {
            string url = ConfigurationManager.AppSettings["GeocodingUrlGoogle"].ToString();
            string soapAction = ConfigurationManager.AppSettings["SoapAction"].ToString();

            //Making Web Request    
            HttpWebRequest Req = (HttpWebRequest)WebRequest.Create(@url);
            //SOAPAction    
            Req.Headers.Add(@"SOAPAction:"+soapAction);
            //Content_type    
            Req.ContentType = "text/xml;charset=\"utf-8\"";
            Req.Accept = "text/xml";
            //HTTP method    
            Req.Method = "POST";
            //return HttpWebRequest    
            return Req;
        }

    public async Task<Envelope> InvokeService(string latitud, string longitud)
    {
            try
            {
                //Calling CreateSOAPWebRequest method  
                HttpWebRequest request = CreateSOAPWebRequest();

                XmlDocument SOAPReqBody = new XmlDocument();

                //SOAP Body Request  
                //SOAPReqBody.LoadXml(@"<?xml version=""1.0"" encoding=""utf-8""?>  
                //<soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-   instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">  
                // <soap:Body>  
                //    <Addition xmlns=""http://tempuri.org/"">  
                //      <a>" + a + @"</a>  
                //      <b>" + b + @"</b>  
                //    </Addition>  
                //  </soap:Body>  
                //</soap:Envelope>");

                SOAPReqBody.LoadXml(@"<?xml version=""1.0"" encoding=""utf-8""?>
            <soap:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">
                <soap:Body>
                    <gMaps xmlns=""http://tempuri.org/"">
                        <Latitud>" + latitud.Replace(",", ".") + @"</Latitud>
                        <Longitud>" + longitud.Replace(",", ".") + @"</Longitud>
                    </gMaps>
                </soap:Body>
            </soap:Envelope>");

                using (Stream stream = await request.GetRequestStreamAsync())
                {
                    SOAPReqBody.Save(stream);
                }
                //Geting response from request  
                using (WebResponse Serviceres = await request.GetResponseAsync())
                {
                    using (StreamReader rd = new StreamReader(Serviceres.GetResponseStream()))
                    {
                        //reading stream  
                        var ServiceResult = rd.ReadToEnd();
                        //writting stream result on console  
                        //ServiceResult = ServiceResult.Replace("<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>", "");
                        return Deserialize<Envelope>(ServiceResult);


                    }
                }
            }
            catch(Exception e)
            {
                log.Error(e.StackTrace, e);
                return null;
            }
          
        }

        public T Deserialize<T>(string input) where T : class
        {
            System.Xml.Serialization.XmlSerializer ser = new System.Xml.Serialization.XmlSerializer(typeof(T));

            using (StringReader sr = new StringReader(input))
            {
                return (T)ser.Deserialize(sr);
            }
        }

    }
}

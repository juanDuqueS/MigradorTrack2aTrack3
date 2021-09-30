using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Serialization;

public partial class MigraZona : Page
{
    public string Id_Cliente;
    clsUsuario usuario;
    int IdUsuario;

    public class filaEquipo
    {
        public string Rut { get; set; }
        public string Nombre { get; set; }
        public string Paterno { get; set; }
        public string Materno { get; set; }
        public string Referncia { get; set; }
        public string Correo { get; set; }
        public string Celular { get; set; }
        public string Autorizacion { get; set; }
        public string Nacimiento { get; set; }
        public string Vencimiento { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //try
        //{

        //    usuario = (clsUsuario)Session["clsUsuario"];
        //    IdUsuario = Convert.ToInt32(usuario.codUsuario);
        //    Id_Cliente = usuario.idCliente;

        //    StringBuilder sbUsuario = new StringBuilder();

        //    sbUsuario.Append("<option selected='selected' value=\"" + IdUsuario + "\">" + IdUsuario + "</option>");
        //    sIdUsario.Controls.Add(new Literal { Text = sbUsuario.ToString() });

        //}
        //catch (Exception)
        //{
        //    Response.Redirect("login/Login.aspx"); // DESARROLLO
        //    //Response.Redirect("../login/Login.aspx"); // PRODUCCION
        //}
 
    }

    public T Deserialize<T>(string input) where T : class
    {
        XmlSerializer ser = new XmlSerializer(typeof(T));
        using (StringReader sr = new StringReader(input))
        {
            return (T)ser.Deserialize(sr);
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public static ArrayList cargarFlotas(string IdPlataforma, string IdUsuario)
    public static ArrayList cargarFlotas(string IdPlataforma)
    {
        ArrayList flotas = new ArrayList();
        string StrConx = "";

        if (IdPlataforma =="2")
        {
            StrConx = ConfigurationManager.AppSettings["MIG_ORIGEN"].ToString();
            try
            {
                //List<Parametro> Parametros = new List<Parametro>();
                //Parametros.Add(new Parametro("@Cod_Usuario", DbType.Int32, IdUsuario));

                SqlConnection conx = new SqlConnection(StrConx);
                SqlCommand com = new SqlCommand();
                com.Connection = conx;
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "[PRO_FLOTAS_MIG]";
                conx.Open();
                com.ExecuteNonQuery();

                if (IdPlataforma != "")
                {
                    using (SqlDataReader reader = com.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            flotas.Add(new { NomFlota = "Seleccione Flota", Cod_Flota = 0 });
                            while (reader.Read())
                            {
                                int cod_flota = int.Parse(reader[0].ToString());
                                string nomflota = reader[1].ToString();
                                string cliente = reader[2].ToString();
                                string rut = reader[3].ToString();

                                flotas.Add(new { NomFlota = nomflota + " / " + cliente + " / " + rut, Cod_Flota = cod_flota });
                            }
                        }
                        reader.Close();
                    }
                }
                else
                {
                    flotas.Clear();
                }
                conx.Close();
                return flotas;

            }
            catch (Exception)
            {
                return flotas;
            }
        }
        return flotas;
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public static ArrayList cargarClientes(string IdPlataforma, string IdUsuario)
    public static ArrayList cargarClientes(string IdPlataforma)
    {
        ArrayList clientes = new ArrayList();
        string StrConx = "";

        if (IdPlataforma == "2")
        {
            StrConx = ConfigurationManager.AppSettings["MIG_DESTINO"].ToString();
            try
            {
                //List<Parametro> Parametros = new List<Parametro>();
                //Parametros.Add(new Parametro("@Cod_Usuario", DbType.Int32, IdUsuario));

                SqlConnection conx = new SqlConnection(StrConx);
                SqlCommand com = new SqlCommand();
                com.Connection = conx;
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "[PRO_CLIENTE_MIG]";
                conx.Open();
                com.ExecuteNonQuery();

                if (IdPlataforma != "")
                {
                    using (SqlDataReader reader = com.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            clientes.Add(new { Cl_Nombre = "Seleccione Cliente", Cl_ID = "0" });
                            while (reader.Read())
                            {
                                string RUT = reader[0].ToString();
                                string Nombre = reader[1].ToString();
                                int ID = int.Parse(reader[2].ToString());
                                clientes.Add(new { Cl_Nombre = RUT + " / " + Nombre, Cl_ID = ID });
                            }
                        }
                        reader.Close();
                    }
                }
                else
                {
                    clientes.Clear();
                }
                conx.Close();
                return clientes;
            }
            catch (Exception)
            {
                return clientes;
            }

        }//Fin idPlataforma = 2
        return clientes;
    }



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public static ArrayList generarInforme(string IdPlataforma, string idFlota, string IdUsuario)
    public static ArrayList generarInforme(string idPlataforma, string idFlota)
    {
        string StrConx = "";
        string msg = "-";
        string msgError = "-";

        ArrayList respuesta = new ArrayList();
        ArrayList points = new ArrayList();

        if (idFlota == "0") { idFlota = "-1"; }

        if (idPlataforma == "2")
        {
            StrConx = ConfigurationManager.AppSettings["MIG_ORIGEN"].ToString();
            try
            {
                //List<Parametro> Parametros = new List<Parametro>();
                //Parametros.Add(new Parametro("@Cod_Usuario", DbType.Int32, IdUsuario));

                SqlConnection conx = new SqlConnection(StrConx);
                SqlCommand com = new SqlCommand();
                com.Connection = conx;
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@Cod_Flota", idFlota);
                com.CommandText = "[PRO_ZONASPORCLIENTE_MIG]";
                conx.Open();
                com.ExecuteNonQuery();

                using (SqlDataReader reader = com.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        int c = 0;
                        while (reader.Read())
                        {
                            string Nombre = reader[0].ToString();
                            string Tipo = reader[1].ToString();
                            int Vehiculos = int.Parse(reader[2].ToString());
                            string EstadoZ = reader[3].ToString();
                            int codZona= int.Parse(reader[4].ToString());
                            string lat = reader[5].ToString();
                            string lon = reader[6].ToString();
                            float rad = float.Parse(reader[7].ToString());
                            string pol = reader[8].ToString();
                            string refe = reader[9].ToString();

                            if (pol == "")
                            {
                                pol = lat + "," + lon + "," + rad;
                            }

                            respuesta.Add(new
                            {
                                Zona = Nombre,
                                TipoZona = Tipo,
                                NumVehiculos = Vehiculos,
                                EstadoZona = EstadoZ,
                                Ver = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#VizModal\"" 
                                    + "data-lat='" + lat.ToString() + "'"
                                    + "data-lng='" + lon.ToString() + "'"
                                    + "data-rad='" + rad.ToString() + "'"
                                    + "data-pol='" + pol.ToString() + "'"
                                    + "'><i class=\"fa fa-search\" aria-hidden=\"true\"></i></a>",
                                Error = msgError,
                                Migrar = "",
                                Mensaje = msg,
                                Poligono = pol,
                                Referencia = refe

                            });
                            c++;
                        }
                        return respuesta;
                    }
                    return respuesta;
                }
            }
            catch (Exception e)
            {
                var txt = e.Message;
                return respuesta;
            }
        }
        return respuesta;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public static ArrayList validarZonas(string IdPlataforma, string IdUsuario)
    public static ArrayList validarZona(List<string> fila)
    {
        ArrayList respuesta = new ArrayList();

        try
        {
            //List<Parametro> Parametros = new List<Parametro>();
            //Parametros.Add(new Parametro("@Cod_Usuario", DbType.Int32, IdUsuario));

            for (int c = 0; c < fila.Count; c++)
            {
                string StrConx = "";
                StrConx = ConfigurationManager.AppSettings["MIG_DESTINO"].ToString();
                string[] strArg = fila[c].Split('|');
                SqlConnection conx = new SqlConnection(StrConx);
                SqlCommand com = new SqlCommand();
                com.Connection = conx;
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@CL_Id", int.Parse(strArg[0]));
                com.Parameters.AddWithValue("@ZN_Nom", strArg[1]);
                com.Parameters.AddWithValue("@ZN_Tipo", strArg[2]);

                com.CommandText = "[PRO_VALIDAZONA_MIG]";
                conx.Open();
                com.ExecuteNonQuery();

                using (SqlDataReader reader = com.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            respuesta.Add(new
                            {
                                contZona = int.Parse(reader[0].ToString()),
                                MigUser = reader[1].ToString()
                            });
                        }
                    }
                    reader.Close();
                }
                conx.Close();
            }
            return respuesta;
        }
        catch (Exception e)
        {
            var txt = e.Message;
            return respuesta;
        }
    }

    [WebMethod]
    //public static ArrayList migraEquipo(string IdPlataforma, string idFlota, string IdUsuario)
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ArrayList migraZona(List<string> fila, string idPlataforma)
    {
        ArrayList respuesta = new ArrayList();

        if (idPlataforma == "2")
        {
            for (int i = 0; i < fila.Count; i++)
            {
                try
                {
                    //List<Parametro> Parametros = new List<Parametro>();
                    //Parametros.Add(new Parametro("@Cod_Usuario", DbType.Int32, IdUsuario));
                    string StrConx = "";
                    StrConx = ConfigurationManager.AppSettings["MIG_DESTINO"].ToString();
                    string[] strArg = fila[i].Split('/');
                    SqlConnection conx = new SqlConnection(StrConx);
                    SqlCommand com = new SqlCommand();
                    com.Connection = conx;
                    com.CommandType = CommandType.StoredProcedure;

                    com.Parameters.AddWithValue("@Cl_Id", int.Parse(strArg[0]));
                    com.Parameters.AddWithValue("@ZN_Nom", strArg[1]);
                    com.Parameters.AddWithValue("@ZN_Tipo", int.Parse(strArg[2]));
                    com.Parameters.AddWithValue("@ZN_Desc", strArg[3]);
                    com.Parameters.AddWithValue("@ZN_Geom", int.Parse(strArg[4]));
                    com.Parameters.AddWithValue("@ZN_JSON", strArg[5]);
                    com.Parameters.AddWithValue("@US_Id", 1); //strArg[6]

                    com.CommandText = "[PRO_MIGRAZONA_MIG]";
                    conx.Open();

                    int rowsAffected = com.ExecuteNonQuery();
                }
                catch (Exception e)
                {
                    var txt = e.Message;
                    respuesta.Add(new { Err = e.Message });
                    //return respuesta;
                }
            }

        }
        return respuesta;
    }//migraZona

}
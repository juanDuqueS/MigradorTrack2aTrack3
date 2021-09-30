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

public partial class MigraConductores : Page
{
    public string Id_Cliente;
    //clsUsuario usuario;
    //int IdUsuario;

    public class filaConductor
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
 /*       try
        {

            usuario = (clsUsuario)Session["clsUsuario"];
            IdUsuario = Convert.ToInt32(usuario.codUsuario);
            Id_Cliente = usuario.idCliente;

            sIdUsario.Controls.Add(new Literal { Text = sbUsuario.ToString() });

        }
        catch (Exception)
        {
            Response.Redirect("login/Login.aspx"); // DESARROLLO
            //Response.Redirect("../login/Login.aspx"); // PRODUCCION
        }
 */
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

        switch (IdPlataforma)
        {
            case "1":
                StrConx = ""; // ConfigurationManager.AppSettings["MONITOR_INT"].ToString();
                break;
            case "2":
                StrConx = ConfigurationManager.AppSettings["MIG_ORIGEN"].ToString();
                break;
            default:
                break;
        }

        try
        {
            List<Parametro> Parametros = new List<Parametro>();
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

                            flotas.Add(new { NomFlota = nomflota +" / "+ cliente +" / "+ rut, Cod_Flota = cod_flota });
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

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ArrayList generarInforme(string idPlataforma, string idFlota)
    {
        string StrConx = "";
        ArrayList respuesta = new ArrayList();

        switch (idPlataforma)
        {
            case "1":
                StrConx = ""; // ConfigurationManager.AppSettings["MONITOR_INT"].ToString();
                break;
            case "2":
                StrConx = ConfigurationManager.AppSettings["MIG_ORIGEN"].ToString();
                break;
            default:
                break;
        }

        try
        {
            //List<Parametro> Parametros = new List<Parametro>();
            //Parametros.Add(new Parametro("@Cod_Usuario", DbType.Int32, IdUsuario));

            SqlConnection conx = new SqlConnection(StrConx);
            SqlCommand com = new SqlCommand();
            com.Connection = conx;
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@Cod_Flota", idFlota);
            com.CommandText = "[SVC_QRY_CONDUCTORPORFLOTA]";
            conx.Open();
            com.ExecuteNonQuery();

            using (SqlDataReader reader = com.ExecuteReader())
            {
                if (reader.HasRows)
                {
                    //List<filaConductor> filas = new List<filaConductor>();
                    while (reader.Read())
                    {
                        string NomConductor = reader[3].ToString();
                        string[] texto= NomConductor.Split(' ');

                        string C_Rut = reader[6].ToString();
                        string C_Nombre = "";
                        string C_Paterno = "";
                        string C_Materno = "";
                        string C_Referncia = reader[5].ToString();
                        string C_Correo = reader[8].ToString();
                        string C_Celular = "";
                        string C_Autorizacion = "";
                        string C_Nacimiento = "";
                        string C_Vencimiento = "";

                        switch (texto.Length)
                        {
                            case 1:
                                C_Nombre = texto[0];
                                C_Paterno = "";
                                C_Materno = "";
                                break;
                            
                            case 2:
                                C_Nombre = texto[0];
                                C_Paterno = texto[1];
                                C_Materno = "";
                                break;

                            case 3:
                                C_Nombre = texto[0];
                                C_Paterno = texto[1];
                                C_Materno = texto[2];
                                break;
                            case 4:
                                C_Nombre = texto[0] + " "+ texto[1];
                                C_Paterno = texto[2];
                                C_Materno = texto[3];
                                break;
                            default:
                                break;
                        }

                        respuesta.Add(new
                        {
                            RUT_Cond = C_Rut,
                            Nombre_Cond = C_Nombre,
                            Paterno_Cond = C_Paterno,
                            Materno_Cond = C_Materno,
                            Referncia_Cond = C_Referncia,
                            Correo_Cond = C_Correo,
                            Celular_Cond = C_Celular,
                            Autoriza_Cond = C_Autorizacion,
                            Nacimiento_Cond = C_Nacimiento,
                            Vencimiento_Cond = C_Vencimiento
                        });
                    }
                    return respuesta;
                }
                return respuesta;
            }
        }
        catch (Exception)
        {
            return respuesta;
        }
    }



    }
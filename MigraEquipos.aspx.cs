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

public partial class MigraEquipos : System.Web.UI.Page
{
    public string Id_Cliente;
    //clsUsuario usuario;
    //int IdUsuario;

    public class filaEquipo
    {
        public string RefVehiculo { get; set; }
        public string Patente { get; set; }
        public string VIN { get; set; }
        public string idAVL { get; set; }
        public string Estado { get; set; }
        public string FechaUltTr { get; set; }
        public string NroSerieGPS { get; set; }
        public string MarcaGPS { get; set; }
        public string ModeloGPS { get; set; }
        public string IMEIGPS { get; set; }
        public string NroSIM { get; set; }
        public string TipoSIM { get; set; }
        public string CiaSIM { get; set; }
        public string Error { get; set; }
        public string Migrar { get; set; }
        public string Mensaje { get; set; }
        public string Referencia { get; set; }
    }

    public class valFila
    {
        public string Myfila { get; set; }
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
    //public static ArrayList cargarUsuarios(string IdPlataforma, int idCliente, string IdUsuario)
    public static ArrayList cargarUsuarios(string IdPlataforma, int idCliente)
    {
        ArrayList usuarios = new ArrayList();
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
                com.Parameters.AddWithValue("@Cod_Cliente", idCliente);
                com.CommandText = "[PRO_USUARIOSPORCLIENTE_MIG]";
                conx.Open();
                com.ExecuteNonQuery();

                if (IdPlataforma != "")
                {
                    using (SqlDataReader reader = com.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            usuarios.Add(new { Nombre_User = "Seleccione Usuario", ID_User = "" });
                            while (reader.Read())
                            {
                                int id = int.Parse(reader[0].ToString());
                                string nombreU = reader[1].ToString();
                                string nombre = reader[2].ToString();
                                string paterno = reader[3].ToString();
                                string materno = reader[4].ToString();

                                usuarios.Add(new { ID_User = id, Nombre_User = nombreU + " / " + nombre + " " + paterno + " " + materno });
                            }
                        }
                        reader.Close();
                    }
                }
                else
                {
                    usuarios.Clear();
                }
                conx.Close();
                return usuarios;

            }
            catch (Exception)
            {
                return usuarios;
            }
        }
        return usuarios;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public static ArrayList cargarMig(string IdPlataforma, string IdUsuario)
    public static ArrayList cargarMig(string IdPlataforma)
    {
        ArrayList migrados = new ArrayList();
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
                com.CommandText = "[PRO_VALIDAEQUIPOMIGRADO_MIG]";
                conx.Open();
                com.ExecuteNonQuery();

                if (IdPlataforma != "")
                {
                    using (SqlDataReader reader = com.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                string vehiculo = reader[0].ToString();
                                string user = reader[1].ToString();
                                string fecha = reader[2].ToString();

                                migrados.Add(new { migVehiculo = vehiculo, migDatos = user + " / " + fecha });
                            }
                        }
                        reader.Close();
                    }
                }
                else
                {
                    migrados.Clear();
                }
                conx.Close();
                return migrados;

            }
            catch (Exception e)
            {
                var txt = e.Message;
                return migrados;
            }
        }
        return migrados;
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
            catch (Exception e)
            {
                ArrayList txt = new ArrayList();
                txt.Add(e.Message);

                return txt;
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
        ArrayList respuesta = new ArrayList();
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
                com.CommandText = "[PRO_VEHICULOSPORFLOTA_MIG]";
                conx.Open();
                com.ExecuteNonQuery();

                using (SqlDataReader reader = com.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        int c = 0;
                        while (reader.Read())
                        {
                            int E_Vehiculo = int.Parse(reader[0].ToString());
                            int E_Flota = int.Parse(reader[1].ToString());

                            string E_Rego = reader[2].ToString().Trim();

                            string E_Patente;
                            string E_VIN;
                            string E_Fecha;
                            string E_Error;
                            string E_Mensaje;

                            string E_Des = reader[3].ToString();

                            E_Fecha = "<td data-sort = 'YYYYMMDD'><span>"+ reader[4].ToString().Substring(6, 4) + reader[4].ToString().Substring(3, 2)+ reader[4].ToString().Substring(0, 2) +"</span>" + "  " + reader[4].ToString().Substring(0, 10) + "</ td >"  ;

                            string E_idAvl = reader[5].ToString();
                            string E_Sim = reader[6].ToString();
                            string E_Estado = reader[7].ToString();
                            string E_GPS = reader[8].ToString();
                            string E_Modelo = reader[9].ToString();
                            string E_CIA = reader[10].ToString();
                            string E_tipo = reader[11].ToString();
                            string E_Ref = reader[12].ToString();
                            string E_CodVehiculo = reader[13].ToString();
                            string E_CodConductor = reader[14].ToString();
                            string E_Conductor = reader[15].ToString();
                            string E_EmailConductor = reader[16].ToString();
                            string E_IdAsignadoConductor = reader[17].ToString();
                            string E_CodRefAsignadoConductor = reader[18].ToString();
                            string EPinConductor = reader[19].ToString();


                            switch (E_Rego.Length)
                            {
                                case 6:
                                    E_Patente = "<input type=\"checkbox\" name=\"idPat_" + c.ToString() + "\" checked>";
                                    E_VIN = "<input type=\"checkbox\" name=\"idVin_" + c.ToString() + "\">";
                                    break;
                                case 17:
                                    E_Patente = "<input type=\"checkbox\" name=\"idPat_" + c.ToString() + "\">";
                                    E_VIN = "<input type=\"checkbox\" name=\"idVin_" + c.ToString() + "\" checked>";
                                    break;

                                default:
                                    E_Patente = "<input type=\"checkbox\" name=\"idPat_" + c.ToString() + "\">";
                                    E_VIN = "<input type=\"checkbox\" name=\"idVin_" + c.ToString() + "\">";
                                    break;
                            }

                          if(E_Modelo != "Enfora MT-4100" && E_Modelo != "LMU26H30"  && E_Modelo != "FMU130")
                            {
                                E_Error = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#myModal\"><i class=\"fa fa-exclamation-triangle\" aria-hidden=\"true\"></i></a>";
                                E_Mensaje = "<tr><td>Problemas con equipo &nbsp</td><td>GPS :&nbsp" + E_GPS + "&nbsp" + E_Modelo + "&nbsp no está soportado para migración.</td></tr>";
                            } 
                            else { 
                                E_Error = "";
                                E_Mensaje = "-";
                            }

                            respuesta.Add(new
                            {
                                RefVehiculo = E_Rego,
                                Patente = E_Patente,
                                VIN = E_VIN,
                                idAVL = E_idAvl,
                                Estado = E_Estado,
                                FechaUltTr = E_Fecha,
                                NroSerieGPS = E_Des,
                                MarcaGPS = E_GPS,
                                ModeloGPS = E_Modelo,
                                IMEIGPS = E_idAvl,
                                NroSIM = E_Sim,
                                TipoSIM = E_tipo,
                                CiaSIM = E_CIA,
                                Error = E_Error,
                                Migrar = "",
                                Mensaje = E_Mensaje,
                                Referencia = E_Ref,
                                cod_vehiculo = E_CodVehiculo,
                                cod_conductor = E_CodConductor,
                                conductor = E_Conductor,
                                email_conductor =E_EmailConductor,
                                id_asignado_conductor = E_IdAsignadoConductor,
                                cod_ref_asignado_conductor = E_CodRefAsignadoConductor,
                                pin_conductor = EPinConductor
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


    [System.Web.Services.WebMethod]
    public static string ProcesaArreglo(List<string> Argumento)
    {
        string[] strArg = Argumento[1].Split('|');
        Random aleatorio = new Random();
        return aleatorio.Next(0, 1000).ToString();
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public static ArrayList validarEquipos(string IdPlataforma, string IdUsuario)
    public static ArrayList validarEquipos(List<string> fila)
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
                SqlConnection conx = new SqlConnection(StrConx);

                string[] strArg = fila[c].Split('|');

                SqlCommand com = new SqlCommand();
                com.Connection = conx;
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@Nom_Flota", strArg[0]);
                com.Parameters.AddWithValue("@Cod_Vehiculo", strArg[1]);
                com.Parameters.AddWithValue("@Cod_GPS", strArg[2]);
                com.Parameters.AddWithValue("@NumIMEI", strArg[3]);
                com.Parameters.AddWithValue("@NumSIM", strArg[4]);
                com.Parameters.AddWithValue("@RUT", strArg[5]);

                com.CommandText = "[PRO_VALIDAEQUIPOS_MIG]";
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
                                NomFlota = reader[0].ToString(),
                                FlotaPatente = reader[1].ToString(),
                                FlotaVIN = reader[2].ToString(),
                                CliPatente = reader[3].ToString(),
                                CliVin = reader[4].ToString(),
                                CliSerie = reader[5].ToString(),
                                NomCliSerie = reader[6].ToString(),
                                CliIMEI = reader[7].ToString(),
                                NomCliIMEI = reader[8].ToString(),
                                CliSIM = reader[9].ToString(),
                                NomCliSIM = reader[10].ToString(),
                                PatenteSIM = reader[11].ToString(),
                                VinSIM = reader[12].ToString(),
                                SimAsociado = reader[13].ToString()
                            });

                        }

                    }
                    reader.Close();
                }
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
    public static ArrayList migraEquipo(List<string> fila, string idPlataforma)
    {
        ArrayList respuesta = new ArrayList();
        String RutCompleto = "";



        if (idPlataforma == "2")
        {
            for (int c = 0; c < fila.Count; c++)
            {
                try
                {
                    //List<Parametro> Parametros = new List<Parametro>();
                    //Parametros.Add(new Parametro("@Cod_Usuario", DbType.Int32, IdUsuario));
                    string[] strArg = fila[c].Split('|');
                    string StrConx = "";
                    StrConx = ConfigurationManager.AppSettings["MIG_DESTINO"].ToString();
                    SqlConnection conx = new SqlConnection(StrConx);
                    SqlCommand com = new SqlCommand();
                    com.Connection = conx;
                    com.CommandType = CommandType.StoredProcedure;

                    com.Parameters.AddWithValue("@FL_Nom", strArg[0]);
                    if (strArg[1].Length == 6)
                    {
                        com.Parameters.AddWithValue("@VH_Patente", strArg[1]);
                        com.Parameters.AddWithValue("@VH_Vin", "");
                    }
                    else //if (strArg[1].Length == 17)
                    {
                        com.Parameters.AddWithValue("@VH_Patente", "");
                        com.Parameters.AddWithValue("@VH_Vin", strArg[1]);
                    }
                    com.Parameters.AddWithValue("@VH_Unidad", strArg[1]);
                    com.Parameters.AddWithValue("@GPS_Serie", strArg[2]);
                    com.Parameters.AddWithValue("@GPS_IMEI", strArg[3]);
                    com.Parameters.AddWithValue("@SIM_Serie", strArg[4]);
                    com.Parameters.AddWithValue("@CL_RUT", strArg[5]);
                    com.Parameters.AddWithValue("@CL_Id", strArg[6]);
                    com.Parameters.AddWithValue("@US_Id", strArg[7]);
                    com.Parameters.AddWithValue("@US_Sys", strArg[7]);
                    com.Parameters.AddWithValue("@GPS_Modelo", strArg[8]);
                    com.Parameters.AddWithValue("@SIM_CIA", strArg[9]);
                    com.Parameters.AddWithValue("@VH_AVL", strArg[11]);
                    com.Parameters.AddWithValue("@VH_Ref", strArg[12]);


                    if (!strArg[17].Equals("") && Rut.ValidaRut(strArg[17]) && strArg[17].Length <= 10)
                    {
                        RutCompleto = strArg[17];
                    }
                    else { 
                        if (!strArg[14].Equals(""))
                        {
                        RutCompleto = strArg[14] + "-" + Rut.Digito(int.Parse(strArg[14]));
                        }
                    }

                    if (strArg[10] == "Nacional")
                    {
                        com.Parameters.AddWithValue("@SIM_Tipo", 1);
                    }
                    else
                    {
                        com.Parameters.AddWithValue("@SIM_Tipo", 2);
                    }

                    com.Parameters.AddWithValue("@VH_TAG", 0);
                    com.Parameters.AddWithValue("@VH_Tercero", 0);

                    com.Parameters.AddWithValue("@RutConductor", RutCompleto);
                    com.Parameters.AddWithValue("@Nombre", strArg[15]);
                    com.Parameters.AddWithValue("@Email", strArg[16]);

                    com.CommandText = "[PRO_MIGRAEQUIPO_MIG]";
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
    }//migraEquipo



    /// <summary>
    /// Validador de RUT Chileno
    /// Hace uso del algoritmo Modulo 11
    ///
    /// Chilean ID Number validator
    /// Use the algorithm called Module 11
    /// </summary>
    class Rut
    {

        /// <summary>
        /// Metodo de validación de rut con digito verificador
        /// dentro de la cadena
        /// </summary>
        /// <param name="rut">string</param>
        /// <returns>booleano</returns>
        public static bool ValidaRut(string rut)
        {
            rut = rut.Replace(".", "").ToUpper();
            Regex expresion = new Regex("^([0-9]+-[0-9K])$");
            string dv = rut.Substring(rut.Length - 1, 1);
            if (!expresion.IsMatch(rut))
            {
                return false;
            }
            char[] charCorte = { '-' };
            string[] rutTemp = rut.Split(charCorte);
            if (dv != Digito(int.Parse(rutTemp[0])))
            {
                return false;
            }
            return true;
        }


        /// <summary>
        /// Método que valida el rut con el digito verificador
        /// por separado
        /// </summary>
        /// <param name="rut">integer</param>
        /// <param name="dv">char</param>
        /// <returns>booleano</returns>
        public static bool ValidaRut(string rut, string dv)
        {
            return ValidaRut(rut + "-" + dv);
        }

        /// <summary>
        /// método que calcula el digito verificador a partir
        /// de la mantisa del rut
        /// </summary>
        /// <param name="rut"></param>
        /// <returns></returns>
        public static string Digito(int rut)
        {
            int suma = 0;
            int multiplicador = 1;
            while (rut != 0)
            {
                multiplicador++;
                if (multiplicador == 8)
                    multiplicador = 2;
                suma += (rut % 10) * multiplicador;
                rut = rut / 10;
            }
            suma = 11 - (suma % 11);
            if (suma == 11)
            {
                return "0";
            }
            else if (suma == 10)
            {
                return "K";
            }
            else
            {
                return suma.ToString();
            }
        }
    }

}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using Jayrock.Json.Conversion;

namespace GPSChile.Framework.Datos
{
    /// <summary>
    /// Clase para el manejo de transacciones con bases de datos SQL Server.
    /// </summary>
    public class Conexion
    {
        #region Métodos de consultas
        /// <summary>
        /// Ejecuta un comando o consulta a la base de datos especificada.
        /// </summary>
        /// <param name="strComando">El comando con la consulta a ejecutar.</param>
        /// <param name="listaParametros">La lista de parámetros a utilizar en la consulta.</param>
        /// <param name="strCatalogo">La base de datos a utilizar.</param>
        /// <param name="TipoComando">El tipo de comando a utilizar.</param>
        /// <returns>Un conjunto de datos con el resultado de la consulta.</returns>
        public static DataSet dsConsultaConResultados(string strComando, List<SqlParameter> listaParametros, string strCatalogo, CommandType TipoComando)
        {
            try
            {
                using (SqlConnection sqlCon = new SqlConnection(ConfigurationManager.AppSettings[strCatalogo.ToUpper()]))
                {
                    using(SqlCommand sqlCom = new SqlCommand(strComando, sqlCon))
                    {
                        if (listaParametros != null)
                        {
                            sqlCom.Parameters.AddRange(listaParametros.ToArray());
                        }

                        sqlCom.CommandType = TipoComando;

                        Conexion.LogComandoSQL(sqlCom);

                        using(SqlDataAdapter adaptador = new SqlDataAdapter(sqlCom))
                        {
                            DataSet ds = new DataSet();

                            adaptador.Fill(ds);
                            return ds;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null;
            }
        }

        /// <summary>
        /// Ejecuta un comando o consulta a la base de datos especificada la cual no devuelve resultados.
        /// </summary>
        /// <param name="strComando">El comando con la consulta a ejecutar.</param>
        /// <param name="spcParametros">La colección de parámetros a utilizar en la consulta.</param>
        /// <param name="strCatalogo">La base de datos a utilizar.</param>
        /// <returns>El resultado de la consulta.</returns>
        public static bool blConsultaSinResultados(string strComando, SqlParameterCollection spcParametros, string strCatalogo)
        {
            try
            {
                using (SqlConnection sqlCon = new SqlConnection(ConfigurationManager.AppSettings[strCatalogo.ToUpper()]))
                {
                    using (SqlCommand sqlCom = new SqlCommand(strComando, sqlCon))
                    {
                        foreach (SqlParameter parametro in spcParametros)
                        {
                            sqlCom.Parameters.AddWithValue(parametro.ParameterName, parametro.Value);
                        }

                        Conexion.LogComandoSQL(sqlCom);
                        sqlCom.ExecuteNonQuery();
                        
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
        }
        /// <summary>
        /// Convierte un DataTable a JSON.
        /// </summary>
        /// <param name="tabla">El DataTable a convertir.</param>
        /// <returns></returns>
        public static string ConvertirDataTableJSON(DataTable tabla)
        {
            if (tabla.Rows.Count > 0)
            {
                return JsonConvert.ExportToString(tabla);
            }

            return "";
        }
        /// <summary>
        /// Escribe un log en consola de depuración con el comando SQL dado.
        /// </summary>
        /// <param name="comando">El comando SQL.</param>
        public static void LogComandoSQL(SqlCommand comando)
        {
            string strComando;

            if (comando.CommandType == CommandType.StoredProcedure)
            {
                strComando = comando.Connection.Database + ".." + comando.CommandText;
            }
            else
            {
                strComando = comando.CommandText;
            }

            foreach (SqlParameter par in comando.Parameters)
            {
                strComando += " '" + par.Value + "',";
            }

            strComando = strComando.Substring(0, strComando.Length - 1);

            Debug.WriteLine(string.Format("LOG: {0}", strComando));
        }
        /// <summary>
        /// Genera cadena en formato json de un data table para mostrar en una grilla jqGrid.
        /// </summary>
        /// <param name="tabla">La tabla de datos.</param>
        /// <returns>Cadena en formato json.</returns>
        public static string GeneraDatosGrillaJSON(DataTable tabla)
        {
            string strFilas = "{";

            for (int i = 0; i < tabla.Rows.Count; i++)
            {
                string strColumna = "";

                for (int j = 0; j < tabla.Columns.Count; j++)
                {
                    if (j == 0)
                    {
                        strFilas += "{\"id\":\"" + i + "\", \"cell\":[\"";
                    }

                    strColumna += "\"" + tabla.Rows[i].ItemArray[j].ToString().Replace('"', '*') + "\", ";
                }

                strColumna = strColumna.Substring(1, strColumna.Length - 3);
                strFilas += strColumna + "]}, ";
            }

            strFilas = strFilas.Substring(1, strFilas.Length - 3);

            string strRes = "{";
            strRes += string.Format("\"page\": 1, \"records\": {0}, \"rows\": [{1}]", tabla.Rows.Count, strFilas);
            strRes += "}";

            return strRes;
        }
        #endregion
    }
}

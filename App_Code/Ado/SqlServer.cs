using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace GpsChile.Servicio.Ems.Ado
{
    public class SqlServer
    {

        public static DataSet ObtieneDataSet(List<SqlParametro> parametro, String ProcedimientoAlmacenado, string cadenaConexion)
        {
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter();
            try
            {
                using (SqlConnection conexion = new SqlConnection(cadenaConexion))
                {
                    using (SqlCommand comando = new SqlCommand(ProcedimientoAlmacenado, conexion))
                    {
                        comando.CommandType = CommandType.StoredProcedure;
                        comando.CommandTimeout = conexion.ConnectionTimeout;
                        comando.Parameters.Clear();

                        foreach (var item in parametro)
                        {
                            new SqlParametro().addParametro(item.Nombre, item.Valor, item.Tipo, comando);
                        }

                        da.SelectCommand = comando;
                        da.Fill(ds);
                    }
                }

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    return ds;
                }
                else
                    return null;

            }
            catch (Exception)
            {
                
                throw;
            }

           
        }


        public static DataSet ObtieneDataSet(string comandoSql, string cadenaConexion)
        {
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter();
            try
            {
                using (SqlConnection conexion = new SqlConnection(cadenaConexion))
                {
                    using (SqlCommand comando = new SqlCommand(comandoSql, conexion))
                    {
                        comando.CommandType = CommandType.Text;
                        comando.CommandTimeout = conexion.ConnectionTimeout;
                        da.SelectCommand = comando;
                        da.Fill(ds);
                    }
                }
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    return ds;
                }
                else
                    return null;
            }
            catch (Exception)
            {
                throw;
            }
        }

    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace GpsChile.Servicio.Ems.Ado
{
    public class SqlParametro
    {
        public SqlParametro() { }

        public SqlParametro(String nombre, DbType tipo, Object valor)
        {
            Nombre = nombre;
            Tipo = tipo;
            Valor = valor;
        }


        public String Nombre { get; set; }

        public DbType Tipo { get; set; }

        public Object Valor { get; set; }

        public void addParametro(String nombre, object valor, DbType tipo, SqlCommand comando)
        {
            try
            {
                IDataParameter dbParam_param = new SqlParameter();
                dbParam_param.ParameterName = nombre;
                dbParam_param.Value = valor == null ? DBNull.Value : valor;
                if (valor != null) dbParam_param.DbType = tipo;
                comando.Parameters.Add(dbParam_param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
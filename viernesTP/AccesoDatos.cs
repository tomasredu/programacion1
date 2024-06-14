using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using TP3.Properties;

namespace TP3.Datos
{
    public class AccesoDatos
    {
        private string cadenaConexion = Properties.Resources.CadenaConexion;
        SqlConnection cnx;
        SqlCommand comando;

        public AccesoDatos()
        {
            cnx = new SqlConnection(cadenaConexion);
            
        }

        public void Conectar()
        {
            cnx.Open();
            comando = new SqlCommand();
            comando.Connection = cnx;
            comando.CommandType = CommandType.Text;
        }

        public void Desconectar()
        {
            cnx.Close();
            comando = null;
        }

        public DataTable consultarBD(string consultaSQL)
        {
            DataTable tabla = new DataTable();
            Conectar();
            comando.CommandText = consultaSQL;
            tabla.Load(comando.ExecuteReader());
            Desconectar();
            return tabla;
        }

        public DataTable consultarBD(string consultaSQL, List<Parametro> parametros)
        {
            DataTable tabla = new DataTable();
            Conectar();
            comando.CommandText = consultaSQL;
            foreach (Parametro p in parametros)
            {
                comando.Parameters.AddWithValue(p.Nombre, p.Valor);
            }
            tabla.Load(comando.ExecuteReader());
            Desconectar();
            return tabla;
        }

        public int actualizarBD(string consultaSQL)
        {
            comando.CommandText = consultaSQL;
            Conectar();
            int filasAfectadas = comando.ExecuteNonQuery();
            Desconectar();
            return filasAfectadas;
        }

        public int actualizarBD(string consultaSQL, List<Parametro> parametros)
        {
            Conectar();
            comando.CommandText = consultaSQL;
            foreach (Parametro p in parametros)
            {
                comando.Parameters.AddWithValue(p.Nombre, p.Valor);
            }
            int filasAfectadas = comando.ExecuteNonQuery();
            Desconectar();
            return filasAfectadas;
        }


    }
}

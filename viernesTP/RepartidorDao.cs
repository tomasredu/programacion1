using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using TP3.Negocio;

namespace TP3.Datos
{
    public class RepartidorDao
    {
        AccesoDatos oBD;


        public RepartidorDao()
        {
            oBD = new AccesoDatos();

        }

        public List<Repartidor> recuperarRepartidores()
        {
            List<Repartidor> repartidores = new List<Repartidor>();
            /*
            string consulta = "select r.*," +
                              " b.id_ciudad idBarrio, b.nombre Barrio," +
                              " c.id_ciudad idCiudad, c.nombre Ciudad," +
                              " p.id_provincia idProvincia, p.nombre Provincia," +
                              " td.id_tipo_documento idTipo, td.descripcion Tipo " +
                                    "from Repartidores r join Barrios b on r.id_barrio = b.id_barrio " +
                                    "join Ciudades c on c.id_ciudad = b.id_ciudad " +
                                    "join Provincias p on p.id_provincia = c.id_provincia " +
                                    "join Tipos_Documento td on td.id_tipo_documento = r.id_tipo_documento";
            */
            string consulta = "select r.*," +
                              " b.id_ciudad idBarrio, b.nombre Barrio," +
                              " c.id_ciudad idCiudad, c.nombre Ciudad," +
                              " p.id_provincia idProvincia, p.nombre Provincia," +
                              " td.id_tipo_documento idTipo, td.descripcion Tipo " +
                                    "from Repartidores r join Barrios b on r.id_barrio = b.id_barrio " +
                                    "join Ciudades c on c.id_ciudad = b.id_ciudad " +
                                    "join Provincias p on p.id_provincia = c.id_provincia " +
                                    "join Tipos_Documento td on td.id_tipo_documento = r.id_tipo_documento";
            DataTable tabla = oBD.consultarBD(consulta);

            foreach (DataRow fila in tabla.Rows)
            {
                Provincia p = new Provincia();
                p.Codigo = (int)fila["idProvincia"];
                p.Nombre = fila["Provincia"].ToString();
                Ciudad c = new Ciudad();
                c.Codigo = (int)fila["idCiudad"];
                c.Nombre = fila["Ciudad"].ToString();
                c.Provincia = p;
                Barrio b = new Barrio();
                b.Codigo = (int)fila["idBarrio"];
                b.Nombre = fila["Barrio"].ToString();
                b.Ciudad = c;
                TipoDocumento td = new TipoDocumento();
                td.Codigo = (int)fila["idTipo"];
                td.Tipo = fila["Tipo"].ToString();

                Repartidor r = new Repartidor();
                r.Codigo = (int)fila["id_repartidor"];
                r.Nombre = fila["nombre"].ToString();
                r.Apellido = fila["apellido"].ToString();
                r.Documento = (int)fila["documento"];
                r.TipoDocumento = td;
                r.FechaNacimiento = (DateTime)fila["fecha_nac"];
                r.Direccion = fila["direccion"].ToString();
                r.Barrio = b;


                repartidores.Add(r);

            }
            return repartidores;
        }
        public List<Repartidor> recuperarRepartidores(string[] valores)
        {
            List<Parametro> parametros = new List<Parametro>() {
                new Parametro("@codigo",valores[0]),
                new Parametro("@nombre", valores[1]),
                new Parametro("@apellido", valores[2]),
                new Parametro("@documento", valores[3]),
                new Parametro("@tipo_documento", valores[4]),
                new Parametro("@fecha_nac", valores[5]),
                new Parametro("@direccion", valores[6]),
                new Parametro("@provincia", valores[7]),
                new Parametro("@ciudad", valores[8]),
                new Parametro("@barrio",valores[9])
            };
            List<Parametro> paramsConsulta = new List<Parametro>();
            
            
            for (int i = 0; i < valores.Length; i++)
            {
                if (!string.IsNullOrEmpty((string)parametros[i].Valor))
                {
                    paramsConsulta.Add(parametros[i]);
                }
            }
            string where = "";
            if (paramsConsulta.Count > 0) where = " where ";
            for (int i = 0; i < paramsConsulta.Count; i++)
            {
                switch (paramsConsulta[i].Nombre)
                {
                    case "@codigo":
                        where += "cast(id_repartidor as varchar) like '%'+@codigo+'%'";
                        break;
                    case "@nombre":
                        where += "r.nombre like '%'+@nombre+'%'";
                        break;
                    case "@apellido":
                        where += "r.apellido like '%'+@apellido+'%'";
                        break;
                    case "@documento":
                        where += "Cast(r.documento as varchar) like '%'+@documento+'%'";
                        break;
                    case "@tipo_documento":
                        where += "td.descripcion = @tipo_documento";
                        break;
                    case "@fecha_nac":
                        where += "r.fecha_nac >= @fecha_nac";
                        break;
                    case "@direccion":
                        where += "r.direccion like '%'+@direccion+'%'";
                        break;
                    case "@provincia":
                        where += "p.nombre = @provincia";
                        break;
                    case "@ciudad":
                        where += "c.nombre = @ciudad";
                        break;
                    case "@barrio":
                        where += "b.nombre = @barrio";
                        break;
                    
                    
                }
                if (i != paramsConsulta.Count - 1)
                {
                    where += " and ";
                }
            }
            
            List<Repartidor> repartidores = new List<Repartidor>();
            string consulta = "set dateformat dmy select r.*," +
                              " b.id_ciudad idBarrio, b.nombre Barrio," +
                              " c.id_ciudad idCiudad, c.nombre Ciudad," +
                              " p.id_provincia idProvincia, p.nombre Provincia," +
                              " td.id_tipo_documento idTipo, td.descripcion Tipo " +
                                    "from Repartidores r join Barrios b on r.id_barrio = b.id_barrio " +
                                    "join Ciudades c on c.id_ciudad = b.id_ciudad " +
                                    "join Provincias p on p.id_provincia = c.id_provincia " +
                                    "join Tipos_Documento td on td.id_tipo_documento = r.id_tipo_documento"+where;
            DataTable tabla = oBD.consultarBD(consulta,paramsConsulta);

            foreach (DataRow fila in tabla.Rows)
            {
                Provincia p = new Provincia();
                p.Codigo = (int)fila["idProvincia"];
                p.Nombre = fila["Provincia"].ToString();
                Ciudad c = new Ciudad();
                c.Codigo = (int)fila["idCiudad"];
                c.Nombre = fila["Ciudad"].ToString();
                c.Provincia = p;
                Barrio b = new Barrio();
                b.Codigo = (int)fila["idBarrio"];
                b.Nombre = fila["Barrio"].ToString();
                b.Ciudad = c;
                TipoDocumento td = new TipoDocumento();
                td.Codigo = (int)fila["idTipo"];
                td.Tipo = fila["Tipo"].ToString();

                Repartidor r = new Repartidor();
                r.Codigo = (int)fila["id_repartidor"];
                r.Nombre = fila["nombre"].ToString();
                r.Apellido = fila["apellido"].ToString();
                r.Documento = (int)fila["documento"];
                r.TipoDocumento = td;
                r.FechaNacimiento = (DateTime)fila["fecha_nac"];
                r.Direccion = fila["direccion"].ToString();
                r.Barrio = b;


                repartidores.Add(r);

            }
            return repartidores;
        }

        public List<TipoDocumento> recuperarTiposDocumento()
        {
            List<TipoDocumento> tipos = new List<TipoDocumento>();
            string consulta = "select id_tipo_documento, descripcion from Tipos_Documento";
            DataTable tabla = oBD.consultarBD(consulta);

            foreach(DataRow fila in tabla.Rows)
            {
                TipoDocumento td = new TipoDocumento();
                td.Codigo = (int)fila["id_tipo_documento"];
                td.Tipo = fila["descripcion"].ToString();

                tipos.Add(td);
            }
            return tipos;

        }

        public int insertarRepartidor(Repartidor r)
        {
            List<Parametro> parametros = new List<Parametro>() {
                new Parametro("@nombre", r.Nombre),
                new Parametro("@apellido", r.Apellido),
                new Parametro("@documento", r.Documento),
                new Parametro("@id_tipo_documento", r.TipoDocumento.Codigo),
                new Parametro("@fecha_nac", r.FechaNacimiento),
                new Parametro("@direccion", r.Direccion),
                new Parametro("@id_barrio", r.Barrio.Codigo)
            };

            string consulta = "insert into repartidores(nombre,apellido,documento,id_tipo_documento,fecha_nac, direccion, id_barrio)\r\nvalues(@nombre,@apellido,@documento,@id_tipo_documento,@fecha_nac,@direccion,@id_barrio)";


            return oBD.actualizarBD(consulta, parametros);



        }
        
        public int actualizarRepartidor(Repartidor r)
        {
            List<Parametro> parametros = new List<Parametro>() {
                new Parametro("codigo", r.Codigo),
                new Parametro("@nombre", r.Nombre),
                new Parametro("@apellido", r.Apellido),
                new Parametro("@documento", r.Documento),
                new Parametro("@id_tipo_documento", r.TipoDocumento.Codigo),
                new Parametro("@fecha_nac", r.FechaNacimiento),
                new Parametro("@direccion", r.Direccion),
                new Parametro("@id_barrio", r.Barrio.Codigo)
            };

            string consulta = "update repartidores\r\nset nombre = @nombre,\r\n\tapellido = @apellido,\r\n\tdocumento = @documento,\r\n\tid_tipo_documento = @id_tipo_documento,\r\n\tfecha_nac = @fecha_nac,\r\n\tdireccion = @direccion,\r\n\tid_barrio = @id_barrio\r\nwhere id_repartidor = @codigo";


            return oBD.actualizarBD(consulta, parametros);
        }


        public int eliminarRepartidor(Repartidor r)
        {
            List<Parametro> parametros = new List<Parametro>() {
                new Parametro("codigo", r.Codigo),
            };

            string consulta = "delete from repartidores\r\nwhere id_repartidor = @codigo;";

            return oBD.actualizarBD(consulta, parametros);
        }
        
        
    }
}

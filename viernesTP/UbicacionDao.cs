using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TP3.Negocio;

namespace TP3.Datos
{
    public class UbicacionDao
    {
        AccesoDatos oBD;

        public UbicacionDao()
        {
            this.oBD = new AccesoDatos();
        }

        public List<Provincia> recuperarProvincias()
        {
            List<Provincia> provincias = new List<Provincia>();
            string consulta = "select * from Provincias";
            DataTable tabla = oBD.consultarBD(consulta);

            foreach (DataRow fila in tabla.Rows)
            {
                Provincia pr = new Provincia();
                pr.Codigo = (int)fila["id_provincia"];
                pr.Nombre = fila["nombre"].ToString();
                
                provincias.Add(pr);

            }
            return provincias;
        }

        public List<Ciudad> recuperarCiudades()
        {
            List<Ciudad> ciudades = new List<Ciudad>();
            string consulta = "select c.id_ciudad, c.nombre Ciudad, c.id_provincia, p.nombre Provincia from Ciudades c join Provincias p on c.id_provincia = p.id_provincia";
            DataTable tabla = oBD.consultarBD(consulta);

            foreach (DataRow fila in tabla.Rows)
            {
                Ciudad c = new Ciudad();
                c.Codigo = (int)fila["id_provincia"];
                c.Nombre = fila["Ciudad"].ToString();

                Provincia pr = new Provincia();
                pr.Codigo = (int)fila["id_provincia"];
                pr.Nombre = fila["Provincia"].ToString();

                c.Provincia = pr;

                ciudades.Add(c);

            }
            return ciudades;
        }

        public List<Ciudad> recuperarCiudades(Provincia provinciaFiltro)
        {
            List<Ciudad> ciudades = new List<Ciudad>();
            string consulta = "select c.id_ciudad idCiudad, c.nombre Ciudad, p.id_provincia idProvincia, p.nombre Provincia from Ciudades c join Provincias p on c.id_provincia = p.id_provincia " +
                                    "where c.id_provincia = "+provinciaFiltro.Codigo; //este where es el que filtra
            DataTable tabla = oBD.consultarBD(consulta);

            foreach (DataRow fila in tabla.Rows)
            {
                Ciudad c = new Ciudad();
                c.Codigo = (int)fila["idCiudad"];
                c.Nombre = fila["Ciudad"].ToString();

                Provincia pr = new Provincia();
                pr.Codigo = (int)fila["idProvincia"];
                pr.Nombre = fila["Provincia"].ToString();

                c.Provincia = pr;

                ciudades.Add(c);

            }
            return ciudades;
        }
        public List<Barrio> recuperarBarrios()
        {
            List<Barrio> barrios = new List<Barrio>();
            string consulta = "select b.id_barrio idBarrio, b.nombre Barrio, c.nombre Ciudad, c.id_ciudad idCiudad, p.id_provincia idProvincia, p.nombre Provincia from Barrios b " +
                                    "join Ciudades c on b.id_ciudad = c.id_ciudad " +
                                    "join Provincias p on c.id_provincia = p.id_provincia";
                                    
            DataTable tabla = oBD.consultarBD(consulta);

            foreach (DataRow fila in tabla.Rows)
            {
                Provincia pr = new Provincia();
                pr.Codigo = (int)fila["idProvincia"];
                pr.Nombre = fila["Provincia"].ToString();

                Ciudad c = new Ciudad();
                c.Codigo = (int)fila["idCiudad"];
                c.Nombre = fila["Ciudad"].ToString();
                c.Provincia = pr;

                Barrio b = new Barrio();

                b.Codigo = (int)fila["idBarrio"];
                b.Nombre = fila["Barrio"].ToString();
                b.Ciudad = c;

                barrios.Add(b);

            }

            return barrios;
        }
        public List<Barrio> recuperarBarrios(Ciudad ciudadFiltro)
        {
            List<Barrio> barrios = new List<Barrio>();
            string consulta = "select b.id_barrio idBarrio, b.nombre Barrio, c.nombre Ciudad, c.id_ciudad idCiudad, p.id_provincia idProvincia, p.nombre Provincia from Barrios b " +
                                    "join Ciudades c on b.id_ciudad = c.id_ciudad " +
                                    "join Provincias p on c.id_provincia = p.id_provincia " +
                                    "where b.id_ciudad = "+ ciudadFiltro.Codigo;
            DataTable tabla = oBD.consultarBD(consulta);

            foreach (DataRow fila in tabla.Rows)
            {
                Provincia pr = new Provincia();
                pr.Codigo = (int)fila["idProvincia"];
                pr.Nombre = fila["Provincia"].ToString();

                Ciudad c = new Ciudad();
                c.Codigo = (int)fila["idCiudad"];
                c.Nombre = fila["Ciudad"].ToString();
                c.Provincia = pr;

                Barrio b = new Barrio();

                b.Codigo = (int)fila["idBarrio"];
                b.Nombre = fila["Barrio"].ToString();
                b.Ciudad = c;

                barrios.Add(b);

            }

            return barrios;
        }

        public int agregarBarrio(Barrio b)
        {
            List<Parametro> parametros = new List<Parametro>() {
                new Parametro("@nombre", b.Nombre),
                new Parametro("@id_ciudad", b.Ciudad.Codigo),

            };

            string consulta = "insert into barrios(nombre, id_ciudad)\r\nvalues(@nombre,@id_ciudad)";


            return oBD.actualizarBD(consulta, parametros);
        }

        public int editarBarrio(Barrio b)
        {
            List<Parametro> parametros = new List<Parametro>() {
                new Parametro("@codigo", b.Codigo),
                new Parametro("@nombre", b.Nombre),
                new Parametro("@id_ciudad", b.Ciudad.Codigo)
            };

            string consulta = "update barrios\r\nset nombre = @nombre,\r\n\tid_ciudad = @id_ciudad\r\nwhere id_barrio = @codigo";


            return oBD.actualizarBD(consulta, parametros);
        }

        public int eliminarBarrio(Barrio b)
        {
            List<Parametro> parametros = new List<Parametro>() {
                new Parametro("codigo", b.Codigo),
            };

            string consulta = "delete from barrios\r\nwhere id_barrio = @codigo;";

            return oBD.actualizarBD(consulta, parametros);
        }
    }
}

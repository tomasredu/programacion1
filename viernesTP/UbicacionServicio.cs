using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TP3.Datos;

namespace TP3.Negocio
{
    public class UbicacionServicio
    {
        UbicacionDao oDao;

        public UbicacionServicio()
        {
            this.oDao = new UbicacionDao();
        }

        public List<Provincia> traerProvincias()
        {
            return oDao.recuperarProvincias();
        }
        public List<Ciudad> traerCiudades()
        {
            return oDao.recuperarCiudades();
        }
        public List<Ciudad> traerCiudades(Provincia filtro)
        {
            return oDao.recuperarCiudades(filtro);
        }
        public List<Barrio> traerBarrios()
        {
            return oDao.recuperarBarrios();
        }
        public List<Barrio> traerBarrios(Ciudad filtro) 
        {
            return oDao.recuperarBarrios(filtro);
        }

        public int agregarBarrio(Barrio barrio)
        {
            return oDao.agregarBarrio(barrio);
        }
        public int editarBarrio(Barrio barrio)
        {
            return oDao.editarBarrio(barrio);
        }
        public int eliminarBarrio(Barrio barrio)
        {
            return oDao.eliminarBarrio(barrio);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TP3.Datos;

namespace TP3.Negocio
{
    public class RepartidorServicio
    {
        RepartidorDao oDao;

        public RepartidorServicio()
        {
            this.oDao = new RepartidorDao();
        }

        public List<Repartidor> traerRepartidores()
        {
            return oDao.recuperarRepartidores();
        }
        public List<Repartidor> traerRepartidores(string[] valores)
        {
            return oDao.recuperarRepartidores(valores);
        }

        public List<TipoDocumento> traerTiposDocumento()
        {
            return oDao.recuperarTiposDocumento();
        }

        public int agregarRepartidor(Repartidor r)
        {
            return oDao.insertarRepartidor(r);
        }

        public int editarRepartidor(Repartidor r)
        {
            return oDao.actualizarRepartidor(r);
        }

        public int eliminarRepartidor(Repartidor r)
        {
            return oDao.eliminarRepartidor(r);
        }
    }
}

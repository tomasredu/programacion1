using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TP3.Datos;
using TP3.Presentacion;
using System.Data;

namespace TP3.Negocio
{
    public class ConsultaServicio
    {
        ConsultaDao oDao;
        public ConsultaServicio()
        {
            oDao = new ConsultaDao();
        }

        public DataTable consultar(int c) {
            return oDao.hacerConsulta(c);
            
        
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Authentication;
using System.Text;
using System.Threading.Tasks;

namespace TP3.Negocio
{
    public class Barrio
    {
		private int codigo;

		public int Codigo
		{
			get { return codigo; }
			set { codigo = value; }
		}
		private string nombre;

		public string Nombre
		{
			get { return nombre; }
			set { nombre = value; }
		}

		private Ciudad ciudad;

		public Ciudad Ciudad
		{
			get { return ciudad; }
			set { ciudad = value; }
		}

        public override string ToString()
        {
            return this.nombre;
        }


    }
}

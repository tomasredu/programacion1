using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TP3.Negocio
{
    public class TipoDocumento
    {
		private int codigo;

		public int Codigo
		{
			get { return codigo; }
			set { codigo = value; }
		}

		private string tipo;

		public string Tipo
		{
			get { return tipo; }
			set { tipo = value; }
		}

        public override string ToString()
        {
            return this.tipo;
        }


    }
}

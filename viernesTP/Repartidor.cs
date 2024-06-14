using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace TP3.Negocio
{
    public class Repartidor
    {
		private int codigo;
		private string nombre;
		private string apellido;
		private int documento;
		private TipoDocumento tipoDocumento;
		private DateTime fechaNacimiento;
		private string direccion;
		private Barrio barrio;

        public int Codigo
        {
            get { return codigo; }
            set { codigo = value; }
        }
        public string Nombre
        {
            get { return nombre; }
            set { nombre = value; }
        }
        public string Apellido
        {
            get { return apellido; }
            set { apellido = value; }
        }
        public int Documento
        {
            get { return documento; }
            set { documento = value; }
        }
        public TipoDocumento TipoDocumento
        {
            get { return tipoDocumento; }
            set { tipoDocumento = value; }
        }
        public DateTime FechaNacimiento
        {
            get { return fechaNacimiento; }
            set { fechaNacimiento = value; }
        }
        public string Direccion
        {
            get { return direccion; }
            set { direccion = value; }
        }
        public Barrio Barrio
		{
			get { return barrio; }
			set { barrio = value; }
		}

        public override string ToString()
        {
            return this.nombre + " " + this.Apellido;
        }




    }
}

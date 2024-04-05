using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;


namespace _412012_Punto
{
    internal class Punto
    {
        private double valorX;
        private double valorY;

        public double pValorX
        {
            get { return valorX;}
            set { valorX = value;}
        }
        public double pValorY { 
            get { return valorY;} 
            set { valorY = value; } 
        }

        public Punto()
        {
            valorX = 0;
            valorY = 0;
        }
        public Punto(double valorX, double valorY)
        {
            this.valorX = valorX;
            this.valorY = valorY;
        }

        public double getModulo()
        {
            return Math.Sqrt(valorY * valorY + valorX * valorX);
        }

        public void mostrarPunto()
        {
            string sPunto = "(" + valorX + "," + valorY + ")";
            Console.WriteLine(sPunto);
        }

}
}

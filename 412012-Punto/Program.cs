using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _412012_Punto
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Punto punto= new Punto(2,4);
            punto.mostrarPunto();
            Console.WriteLine(punto.getModulo());
            Console.Read();
        }
    }
    
}

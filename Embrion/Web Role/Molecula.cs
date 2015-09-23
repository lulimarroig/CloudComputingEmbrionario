using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web_Role
{
    public class Molecula
    {
        string nomMolecula;
        string constanteDifusion;
        string constanteDifusion2d;
        int cantidad;

        public string getNombreMolecula()
        {
            return nomMolecula;
        }

        public string getConstanteDifusion3D()
        {
            return constanteDifusion;
        }

        public string getConstanteDifusion2D()
        {
            return constanteDifusion2d;
        }

        public int getCantidad()
        {
            return cantidad;
        }

        public Molecula(string nombre, string difusion, string difusion2d, int cantidad)
        {
            this.nomMolecula = nombre;
            this.constanteDifusion = difusion;
            this.constanteDifusion2d = difusion2d;
            this.cantidad = cantidad;
        }
       
    }
}
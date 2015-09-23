using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web_Role
{
    public class Reaccion
    {
        string nombreReaccion;
        string reaccion;
        double rateInicio;
        double rateFin;
        double rateStep;

        public string getNombreReaccion()
        {
            return this.nombreReaccion;
        }

        public string getReaccion()
        {
            return this.reaccion;
        }

        public double getRateInicio()
        {
            return this.rateInicio;
        }

        public double getRateFin()
        {
            return this.rateFin;
        }

        public double getRateStep()
        {
            return this.rateStep;
        }

        public Reaccion(string nombre, string reaccion, double inicio, double fin, double step)
        {
            this.nombreReaccion = nombre;
            this.reaccion = reaccion;
            this.rateInicio = inicio;
            this.rateFin = fin;
            this.rateStep = step;
        }
    }
}
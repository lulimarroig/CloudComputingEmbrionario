using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InterroleCommons
{
    public class SimulacionParameters
    {
        public InitParameters init { get; set; }
        public GeometriaParameters geometria { get; set; }
        public MoleculasParameters moleculas { get; set; }
        public List<ReaccionesParameters> reacciones { get; set; }
        public FernetParameters fernet { get; set; }
    }

    public class InitParameters
    {
        public Double iterations { get; set; }
        public Double timeStep { get; set; }
    }

    public class GeometriaParameters
    {
        public BoxParameters box { get; set; }
    }

    public class BoxParameters
    {
        public String nombre { get; set; }
        public LinkedList<LinkedList<String>> corners { get; set; }
        public Double? aspectRatio { get; set; }
    }

    public class MoleculasParameters
    {
        public String nameList { get; set; }
        public List<MoleculaParameters> defineMoleculas { get; set; }       
    }

    public class MoleculaParameters
    {
        public String nombre { get; set; }

        public Double difusion3D { get; set; }
        public Double? difusion2D { get; set; }
        public Int32 cantidad { get; set; }        
    }

    public class ReaccionesParameters
    {
        public String reaccion { get; set; }
        public RateParameters rate { get; set; } //si no esta definido, null
        public String nombre { get; set; }
    }

    public class RateParameters
    {
        public Double rateInicio { get; set; }
        public Double rateFin { get; set; } //si no se quiere rango, null
        public Double rateStep { get; set; } //si no se quiere rango, null
        
    }

    public class FernetParameters
    {
        public string mode { get; set; }

    }
}

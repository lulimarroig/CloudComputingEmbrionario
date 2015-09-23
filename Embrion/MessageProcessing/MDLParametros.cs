using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MessageProcessing
{
    class MDLParametros
    {
        public Double iteraciones { get; set; }        
        public Double timeStep { get; set; }
        public BoxParametros box { get; set; }
        public DefMoleculas moleculas { get; set; }
        public LinkedList<ReacParametros> reacciones { get; set; }
        public bool hayReacciones { get; set; }
    }

    class DefMoleculas { 
        public String nameList {get; set;}
        public LinkedList<MoleculasParametros> defineMoleculas { get; set; }
    
    }

    class BoxParametros
    {
        public String nombre { get; set; }        
        public String corners { get; set; }
        public Double? aspectRatio { get; set; }        
    }

    class MoleculasParametros
    {
        public String nombre { get; set; }        
        public Int32 cantidad { get; set; }
        public Double diffusion3D { get; set; }
        public Double? diffusion2D { get; set; }   
    }

    class ReacParametros
    {
        public String reaccion { get; set; }
        public Double rate { get; set; }
        public String nombre { get; set; }
    }
}

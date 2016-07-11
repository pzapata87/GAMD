using System.Collections.Generic;

namespace GAMD.Business.Entity
{
    public class Encuesta
    {
        public int Id { get; set; }
        public string Nombre { get; set; }

        public virtual ICollection<PreguntaEncuesta> PreguntaList { get; set; }
    }
}
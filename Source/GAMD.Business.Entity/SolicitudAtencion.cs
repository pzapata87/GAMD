using System;

namespace GAMD.Business.Entity
{
    public class SolicitudAtencion
    {
        public int Id { get; set; }
        public string NumeroSolicitud { get; set; }
        public DateTime FechaSolicitud { get; set; }
        public int TipoServicio { get; set; }
        public string Ubicacion { get; set; }
        public int Especialidad { get; set; }
        public string Sintomas { get; set; }
    }
}
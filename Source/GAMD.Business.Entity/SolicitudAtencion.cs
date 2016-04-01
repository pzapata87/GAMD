using System;

namespace GAMD.Business.Entity
{
    public class SolicitudAtencion
    {
        public int Id { get; set; }
        public string Direccion { get; set; }
        public DateTime FechaSolicitud { get; set; }
        public string ServicioId { get; set; }
        public string Sintomas { get; set; }
    }
}
namespace GAMD.Business.Entity
{
    public class PreguntaEncuestaSolicitud
    {
        public int Id { get; set; }
        public int PreguntaEncuestaId { get; set; }
        public int SolicitudId { get; set; }
        public int Calificacion { get; set; }
        public string Observacion { get; set; }
    }
}
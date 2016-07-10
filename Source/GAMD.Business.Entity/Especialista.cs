namespace GAMD.Business.Entity
{
    public class Especialista : Persona
    {
        public decimal Latitud { get; set; }
        public decimal Longitud { get; set; }
        public string CodEspecialidad { get; set; }
        public int Calificacion { get; set; }
    }
}
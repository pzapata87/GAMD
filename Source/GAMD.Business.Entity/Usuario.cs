namespace GAMD.Business.Entity
{
    public class Usuario
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public int PersonaId { get; set; }
        public int Estado { get; set; }

        public virtual Persona Persona { get; set; }
    }
}
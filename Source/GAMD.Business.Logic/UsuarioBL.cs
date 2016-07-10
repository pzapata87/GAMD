using EDOSwit.Entity;
using GAMD.Business.Entity;
using GAMD.DataAccess;

namespace GAMD.Business.Logic
{
    public class UsuarioBL : Singleton<UsuarioBL>
    {
        public Usuario GetUser(string username, string password)
        {
            return UsuarioRepository.Instancia.GetUser(username, password);
        }
    }
}
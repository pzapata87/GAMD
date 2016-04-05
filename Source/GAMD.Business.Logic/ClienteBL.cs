using EDOSwit.Entity;
using GAMD.Business.Entity;
using GAMD.DataAccess;

namespace GAMD.Business.Logic
{
    public class ClienteBL : Singleton<ClienteBL>
    {
        public Usuario GetUserCliente(string username, string password)
        {
            return ClienteRepository.Instancia.GetUserCliente(username, password);
        }
    }
}
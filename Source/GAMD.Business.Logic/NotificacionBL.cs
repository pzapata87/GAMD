using EDOSwit.Entity;
using GAMD.Business.Entity;
using GAMD.DataAccess;

namespace GAMD.Business.Logic
{
    public class NotificacionBL : Singleton<NotificacionBL>
    {
        public Notificacion GetByUsername(string username)
        {
            return NotificacionRepository.Instancia.GetByUsername(username);
        }

        public int Add(string username, string codigoGCm)
        {
            return NotificacionRepository.Instancia.Add(username, codigoGCm);
        }
    }
}
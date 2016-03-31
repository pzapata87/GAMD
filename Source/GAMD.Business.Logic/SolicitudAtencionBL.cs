using EDOSwit.Entity;
using GAMD.Business.Entity;
using GAMD.DataAccess;

namespace GAMD.Business.Logic
{
    public class SolicitudAtencionBL : Singleton<SolicitudAtencionBL>
    {
        public void Add(SolicitudAtencion solicitud)
        {
            SolicitudAtencionRepository.Instancia.Add(solicitud);
        }
    }
}
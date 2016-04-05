using EDOSwit.Entity;
using GAMD.Business.Entity;
using GAMD.DataAccess;

namespace GAMD.Business.Logic
{
    public class SolicitudAtencionBL : Singleton<SolicitudAtencionBL>
    {
        public int Add(SolicitudAtencion solicitud)
        {
            return SolicitudAtencionRepository.Instancia.Add(solicitud);
        }

        public void AsignarMedico(SolicitudAtencion solicitud)
        {
            SolicitudAtencionRepository.Instancia.AsignarMedico(solicitud);
        }
    }
}
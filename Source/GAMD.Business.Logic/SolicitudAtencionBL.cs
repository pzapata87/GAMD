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

        public SolicitudAtencion GetCita(int clienteId)
        {
            return SolicitudAtencionRepository.Instancia.GetCita(clienteId);
        }

        public void UpdateEstado(int solicitudId, int estadoSolicitud)
        {
            SolicitudAtencionRepository.Instancia.UpdateEstado(solicitudId, estadoSolicitud);
        }

        public void AsignarMedico(SolicitudAtencion solicitud)
        {
            SolicitudAtencionRepository.Instancia.AsignarMedico(solicitud);
        }
    }
}
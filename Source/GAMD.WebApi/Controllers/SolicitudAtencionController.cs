using System;
using System.Configuration;
using System.Web.Http;
using GAMD.Business.Entity;
using GAMD.Business.Logic;
using GAMD.DTO;
using GAMD.WebApi.Core;

namespace GAMD.WebApi.Controllers
{
    public class SolicitudAtencionController : BaseController
    {
        [HttpPost]
        public JsonResponse CrearSolicitud(SolicitudDto solicitud)
        {
            var jsonResponse = new JsonResponse { Success = false };
            try
            {
                SolicitudAtencionBL.Instancia.Add(new SolicitudAtencion
                {
                    ServicioId = solicitud.ServicioId,
                    Direccion = solicitud.Direccion,
                    Sintomas = solicitud.Sintomas,
                    FechaSolicitud = DateTime.Now
                });
                jsonResponse.Success = true;

                int radio = Convert.ToInt32(ConfigurationManager.AppSettings.Get("Radio"));
                var list = EspecialistaBL.Instancia.GetEspecialistas(solicitud.Latitud, solicitud.Longitud, radio);
                jsonResponse.Data = list;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }
            return jsonResponse;
        }
    }
}
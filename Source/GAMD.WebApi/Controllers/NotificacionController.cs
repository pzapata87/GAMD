using System;
using System.Web.Http;
using GAMD.Business.Logic;
using GAMD.DTO;
using GAMD.WebApi.Core;

namespace GAMD.WebApi.Controllers
{
    public class NotificacionController : BaseController
    {
        [HttpPost]
        public JsonResponse Add(NotificacionDto notificacion)
        {
            var jsonResponse = new JsonResponse { Success = false };
            try
            {
                int resultado = NotificacionBL.Instancia.Add(notificacion.Username, notificacion.CodigoGcm);

                if (resultado > 0)
                {
                    jsonResponse.Success = true;
                    jsonResponse.Message = Mensajes.RegistroSatisfactorio;
                }
                else
                {
                    jsonResponse.Message = Mensajes.RegistroFallido;
                }
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
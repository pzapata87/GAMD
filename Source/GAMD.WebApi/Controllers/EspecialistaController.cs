using System;
using System.Configuration;
using System.Web.Http;
using GAMD.Business.Logic;
using GAMD.DTO;
using GAMD.WebApi.Core;

namespace GAMD.WebApi.Controllers
{
    public class EspecialistaController : BaseController
    {
        [HttpPost]
        //[Route("api/Especialista/GetEspecialistas")]
        public JsonResponse GetEspecialistas(PosicionDto posicion)
        {
            var jsonResponse = new JsonResponse { Success = false };
            try
            {
                int radio = Convert.ToInt32(ConfigurationManager.AppSettings.Get("Radio"));
                var list = EspecialistaBL.Instancia.GetEspecialistas(posicion.Latitud, posicion.Longitud, radio);
                jsonResponse.Success = true;
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
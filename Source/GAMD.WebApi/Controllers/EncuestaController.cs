using System;
using System.Collections.Generic;
using System.Web.Http;
using GAMD.Business.Entity;
using GAMD.Business.Logic;
using GAMD.DTO;
using GAMD.WebApi.Core;

namespace GAMD.WebApi.Controllers
{
    public class EncuestaController : BaseController
    {
        [HttpPost]
        public JsonResponse RegistrarEncuesta(List<PreguntaEncuestaSolicitud> respuestas)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                foreach (var item in respuestas)
                {
                    EncuestaBL.Instancia.Add(item);
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }

            return jsonResponse;
        }

        [HttpPost]
        public JsonResponse GetEncuestas()
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                var list = EncuestaBL.Instancia.GetEncuestas();
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
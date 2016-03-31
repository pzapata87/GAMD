using System;
using System.Web.Mvc;
using GAMD.Business.Logic;
using GAMD.DTO;
using GAMD.WebApi.Core;

namespace GAMD.WebApi.Controllers
{
    public class EspecialistaController : BaseController
    {
        [HttpGet]
        [Route("GetEspecialistas")]//api/Especialista/GetEspecialistas
        public JsonResponse GetEspecialistas(decimal latitud, decimal longitud)
        {
            var jsonResponse = new JsonResponse { Success = false };
            try
            {
                var list = EspecialistaBL.Instancia.GetEspecialistas(latitud, longitud, 2);
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
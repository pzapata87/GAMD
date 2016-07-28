using System;
using System.Web.Http;
using GAMD.Business.Logic;
using GAMD.DTO;
using GAMD.WebApi.Core;

namespace GAMD.WebApi.Controllers
{
    public class TipoController : BaseController
    {
        [HttpPost]
        public JsonResponse GetTipos()
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                var list = TipoParametroBL.Instancia.GetTipos();
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
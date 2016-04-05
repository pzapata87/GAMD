using System;
using System.Web.Http;
using GAMD.Business.Logic;
using GAMD.DTO;
using GAMD.WebApi.Core;

namespace GAMD.WebApi.Controllers
{
    public class ClienteController : BaseController
    {
        [HttpPost]
        public JsonResponse GetUserCliente(LoginDto login)
        {
            var jsonResponse = new JsonResponse { Success = false };
            try
            {
                var user = ClienteBL.Instancia.GetUserCliente(login.Username, login.Password);
                if (user !=null)
                {
                    jsonResponse.Success = true;
                    jsonResponse.Data = user;
                }
                else
                {
                    jsonResponse.Message = Mensajes.UsuarioNoExiste;
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
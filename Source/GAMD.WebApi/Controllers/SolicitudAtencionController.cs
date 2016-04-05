using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web;
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
        public JsonResponse CrearSolicitud(SolicitudDto solicitudDto)
        {
            var jsonResponse = new JsonResponse { Success = false };
            try
            {
                //Colocar en AutoMapper;
                var solicitud = new SolicitudAtencion
                {
                    ServicioId = solicitudDto.ServicioId,
                    Direccion = solicitudDto.Direccion,
                    Sintomas = solicitudDto.Sintomas,
                    FechaSolicitud = DateTime.Now,
                    ClienteId = solicitudDto.ClienteId,
                    Latitud = solicitudDto.Latitud,
                    Longitud = solicitudDto.Longitud
                };

                int id = SolicitudAtencionBL.Instancia.Add(solicitud);
                solicitud.Id = id;
                jsonResponse.Success = true;

                int radio = Convert.ToInt32(ConfigurationManager.AppSettings.Get("Radio"));
                var list = EspecialistaBL.Instancia.GetEspecialistas(solicitud.Latitud, solicitud.Longitud, radio);
                jsonResponse.Data = list;

                // Se crea una tarea para asignar un médico a la solicitud
                Task.Run(() => AsignarMedico(solicitud, solicitudDto.CodigoGCM, list));
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }
            return jsonResponse;
        }

        private void AsignarMedico(SolicitudAtencion solicitud, string codigoGCM, List<Especialista> especialistaList)
        {
            try
            {
                if (especialistaList != null)
                {
                    //TODO: Poner el criterio de selección del especialista
                    var especialistaSel = especialistaList.First();
                    solicitud.EspecialistaId = especialistaSel.Id;

                    SolicitudAtencionBL.Instancia.AsignarMedico(solicitud);

                    var response = EnviarNotificacion(solicitud, codigoGCM);
                    if (!response.Success)
                        throw new Exception(response.Message);
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
            }
        }

        private JsonResponse EnviarNotificacion(SolicitudAtencion solicitud, string codigoGCM)
        {
            var jsonResponse = new JsonResponse { Success = false };
            string GCM_URL = ConfigurationManager.AppSettings.Get("GCM_URL");
            string collapseKey = DateTime.Now.ToString();
            Dictionary<string, string> data = new Dictionary<string, string>
            {
                {"data.msg", HttpUtility.UrlEncode("Solicitud: " + solicitud.Id)}
            };

            StringBuilder sb = new StringBuilder();
            sb.AppendFormat("registration_id={0}&collapse_key={1}", codigoGCM, collapseKey);

            foreach (string item in data.Keys)
            {
                if (item.Contains("data."))
                    sb.AppendFormat("&{0}={1}", item, data[item]);
            }

            string msg = sb.ToString();
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create(GCM_URL);
            req.Method = "POST";
            req.ContentLength = msg.Length;
            req.ContentType = "application/x-www-form-urlencoded";

            string apiKey = ConfigurationManager.AppSettings.Get("ApiKey");
            req.Headers.Add("Authorization:key=" + apiKey);

            using (StreamWriter oWriter = new StreamWriter(req.GetRequestStream()))
            {
                oWriter.Write(msg);
            }

            using (HttpWebResponse resp = (HttpWebResponse)req.GetResponse())
            {
                using (StreamReader sr = new StreamReader(resp.GetResponseStream()))
                {
                    string respData = sr.ReadToEnd();
                    jsonResponse.Data = respData;
                    if (resp.StatusCode == HttpStatusCode.OK)   // OK = 200
                    {
                        if (respData.StartsWith("id="))
                            jsonResponse.Success = true;
                    }
                    else if (resp.StatusCode == HttpStatusCode.InternalServerError)    // 500
                        jsonResponse.Message = "Error interno del servidor, prueba más tarde.";
                    else if (resp.StatusCode == HttpStatusCode.ServiceUnavailable)    // 503
                        jsonResponse.Message = "Servidor no disponible temporalmente, prueba más tarde.";
                    else if (resp.StatusCode == HttpStatusCode.Unauthorized)          // 401
                        jsonResponse.Message = "La API Key utilizada no es válida.";
                    else
                        jsonResponse.Message = "Error: " + resp.StatusCode;
                }
            }

            return jsonResponse;
        }
    }
}
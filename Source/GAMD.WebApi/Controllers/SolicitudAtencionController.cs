using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using GAMD.Business.Entity;
using GAMD.Business.Logic;
using GAMD.Common;
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
                var citaPendiente = SolicitudAtencionBL.Instancia.GetCitaPorCliente(solicitudDto.ClienteId);

                if (citaPendiente == null)
                {
                    //TODO:Colocar en AutoMapper;
                    var solicitud = new SolicitudAtencion
                    {
                        ServicioId = solicitudDto.ServicioId,
                        Direccion = solicitudDto.Direccion,
                        Sintomas = solicitudDto.Sintomas,
                        FechaSolicitud = DateTime.Now,
                        ClienteId = solicitudDto.ClienteId,
                        Latitud = solicitudDto.Latitud,
                        Longitud = solicitudDto.Longitud,
                        ClienteUserName = solicitudDto.ClienteUserName,
                        FechaCita = DateTime.ParseExact(solicitudDto.FechaAtencion, "dd/MM/yyyy", CultureInfo.InvariantCulture),
                        HoraCita = solicitudDto.HoraAtencion
                    };

                    int id = SolicitudAtencionBL.Instancia.Add(solicitud);
                    solicitud.Id = id;

                    int radio = Convert.ToInt32(ConfigurationManager.AppSettings.Get("Radio"));
                    var list = EspecialistaBL.Instancia.GetEspecialistas(solicitud.Latitud, solicitud.Longitud, radio);

                    jsonResponse.Data = list;
                    jsonResponse.Success = true;

                    // Se crea una tarea para asignar un médico a la solicitud
                    Task.Run(() => AsignarMedico(solicitud, list));
                }
                else
                {
                    jsonResponse.Message = Mensajes.SolicitudPendiente;
                    jsonResponse.Data = citaPendiente;
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
        public JsonResponse CancelarCita(SolicitudDto solicitudDto)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                SolicitudAtencionBL.Instancia.UpdateEstado(solicitudDto.SolicitudId, EstadoSolicitud.Cancelada.GetNumberValue(), null);
                jsonResponse.Success = true;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }

            return jsonResponse;
        }

        [HttpPost]
        public JsonResponse ConfirmarLlegadaCita(SolicitudDto solicitudDto)
        {
            var jsonResponse = new JsonResponse {Success = false};

            try
            {
                SolicitudAtencionBL.Instancia.UpdateEstado(solicitudDto.SolicitudId, EstadoSolicitud.Activa.GetNumberValue(), null);
                var cita = SolicitudAtencionBL.Instancia.GetCita(solicitudDto.SolicitudId);

                var notificacion = NotificacionBL.Instancia.GetByUsername(cita.ClienteUserName);
                if (notificacion != null)
                {
                    string msj = string.Format(" Estimado {0}, su médico {1}.\n acaba de llegar para su cita pactada.",
                        cita.ClienteNombre, cita.EspecialistaNombre);
                    EnviarNotificacion(cita.Id, msj, notificacion.CodigoGcm, (int)TipoNotificacion.Confirmacion);
                }
                else
                {
                    LogError(string.Format("{0} {1}", Mensajes.NoExisteCodigoGcm, cita.ClienteUserName));
                }

                jsonResponse.Success = true;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }

            return jsonResponse;
        }

        [HttpPost]
        public JsonResponse FinalizarCita(SolicitudDto solicitudDto)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                SolicitudAtencionBL.Instancia.UpdateEstado(solicitudDto.SolicitudId, EstadoSolicitud.Finalizada.GetNumberValue(), solicitudDto.Observacion);
                var cita = SolicitudAtencionBL.Instancia.GetCita(solicitudDto.SolicitudId);

                var notificacion = NotificacionBL.Instancia.GetByUsername(cita.ClienteUserName);
                if (notificacion != null)
                {
                    string msj = string.Format(" Estimado {0}, su cita a finalizado.", cita.ClienteNombre);
                    EnviarNotificacion(cita.Id, msj, notificacion.CodigoGcm, (int)TipoNotificacion.Finalizacion);
                }
                else
                {
                    LogError(string.Format("{0} {1}", Mensajes.NoExisteCodigoGcm, cita.ClienteUserName));
                }

                jsonResponse.Success = true;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }

            return jsonResponse;
        }

        [HttpPost]
        public JsonResponse GetSolicitudesPendientes(SolicitudDto solicitudDto)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                var list = SolicitudAtencionBL.Instancia.GetSolicitudes(EstadoSolicitud.Pendiente.GetNumberValue(), solicitudDto.EspecialistaId);
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

        [HttpPost]
        public JsonResponse GetSolicitudesActivas(SolicitudDto solicitudDto)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                var list = SolicitudAtencionBL.Instancia.GetSolicitudes(EstadoSolicitud.Activa.GetNumberValue(), solicitudDto.EspecialistaId);
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

        #region Metodos Privados

        private void AsignarMedico(SolicitudAtencion solicitud, List<Especialista> especialistaList)
        {
            try
            {
                if (especialistaList != null)
                {
                    var notificacion = NotificacionBL.Instancia.GetByUsername(solicitud.ClienteUserName);
                    if (notificacion != null)
                    {
                        var especialistaSel = especialistaList.OrderByDescending(p => p.Calificacion).First();
                        solicitud.EspecialistaId = especialistaSel.Id;
                        solicitud.EspecialistaNombre = string.Format("{0} {1}",especialistaSel.Nombre, especialistaSel.Apellido);

                        SolicitudAtencionBL.Instancia.AsignarMedico(solicitud);

                        string msj = string.Format(
                            " Estimado {0}, su solicitud ha sido aceptada.\n Le atenderá el Dr. {1}.\n Su cita se realizará el {2} {3}.\n\n Gracias.",
                            solicitud.ClienteUserName, solicitud.EspecialistaNombre,
                            solicitud.FechaCita.GetDate(), solicitud.HoraCita);                        

                        var response = EnviarNotificacion(solicitud.Id, msj, notificacion.CodigoGcm);
                        if (!response.Success)
                            throw new Exception(response.Message);

                        notificacion = NotificacionBL.Instancia.GetByUsername(especialistaSel.Email);

                        string msjEspecialista = string.Format(
                                                    " Estimado {0}, usted ha sido asignado para atender a {1}.\n Se debe atender la cita el {2} {3}.\n\n Gracias.",
                                                    solicitud.EspecialistaNombre, solicitud.ClienteUserName,
                                                    solicitud.FechaCita.GetDate(), solicitud.HoraCita);
                        LogError(msjEspecialista);

                        response = EnviarNotificacion(solicitud.Id, msjEspecialista, notificacion.CodigoGcm);
                        if (!response.Success)
                            throw new Exception(response.Message);
                    }
                    else
                    {
                        throw new Exception(Mensajes.NoExisteCodigoGcm);
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
            }
        }

        private JsonResponse EnviarNotificacion(int solicitudId, string mensaje, string codigoGcm, int tipo = (int)TipoNotificacion.Aviso)
        {
            var jsonResponse = new JsonResponse { Success = false };
            string GCM_URL = ConfigurationManager.AppSettings.Get("GCM_URL");
            string collapseKey = DateTime.Now.GetDateTime(false);
            LogError("codigoGcm = " + codigoGcm);

            LogError("message = " + mensaje);
            LogError("requestCode = " + solicitudId);
            LogError("tipo = " + tipo);

            var data = new Dictionary<string, string>
            {
                {"data.message", HttpUtility.UrlEncode(mensaje)},
                {"data.requestCode", solicitudId.ToString()},
                {"data.tipo", tipo.ToString()}
            };

            var sb = new StringBuilder();
            sb.AppendFormat("registration_id={0}&collapse_key={1}", codigoGcm, collapseKey);

            foreach (string item in data.Keys)
            {
                if (item.Contains("data."))
                    sb.AppendFormat("&{0}={1}", item, data[item]);
            }

            string msg = sb.ToString();
            var req = (HttpWebRequest)WebRequest.Create(GCM_URL);
            req.Method = "POST";
            req.ContentLength = msg.Length;
            req.ContentType = "application/x-www-form-urlencoded";

            string apiKey = ConfigurationManager.AppSettings.Get("ApiKey");
            req.Headers.Add("Authorization:key=" + apiKey);

            using (var oWriter = new StreamWriter(req.GetRequestStream()))
            {
                oWriter.Write(msg);
            }

            using (var resp = (HttpWebResponse)req.GetResponse())
            {
                using (var sr = new StreamReader(resp.GetResponseStream()))
                {
                    string respData = sr.ReadToEnd();
                    LogError("respData = " + respData);
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
            LogError("jsonResponse.message = " + jsonResponse.Message);

            return jsonResponse;
        }

        #endregion
    }
}
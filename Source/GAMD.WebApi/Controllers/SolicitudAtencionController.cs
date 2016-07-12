﻿using System;
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
                var citaPendiente = SolicitudAtencionBL.Instancia.GetCita(solicitudDto.ClienteId);

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
                    jsonResponse.Success = true;

                    int radio = Convert.ToInt32(ConfigurationManager.AppSettings.Get("Radio"));
                    var list = EspecialistaBL.Instancia.GetEspecialistas(solicitud.Latitud, solicitud.Longitud, radio);
                    jsonResponse.Data = list;

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
        public JsonResponse CancelarCita(int solicitudId)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                SolicitudAtencionBL.Instancia.UpdateEstado(solicitudId, EstadoSolicitud.Cancelada.GetNumberValue(), null);
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
        public JsonResponse ConfirmarLlegadaCita(int solicitudId)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                SolicitudAtencionBL.Instancia.UpdateEstado(solicitudId, EstadoSolicitud.Activa.GetNumberValue(), null);
                jsonResponse.Success = true;
                //TODo: Enviar Notificacion al cliente
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }

            return jsonResponse;
        }

        [HttpPost]
        public JsonResponse FinalizarCita(int solicitudId, string observacion)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                SolicitudAtencionBL.Instancia.UpdateEstado(solicitudId, EstadoSolicitud.Finalizada.GetNumberValue(), observacion);
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
        public JsonResponse GetSolicitudesPendientes(int especialistaId)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                var list = SolicitudAtencionBL.Instancia.GetSolicitudes(EstadoSolicitud.Pendiente.GetNumberValue(), especialistaId);
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
        public JsonResponse GetSolicitudesActivas(int especialistaId)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                var list = SolicitudAtencionBL.Instancia.GetSolicitudes(EstadoSolicitud.Activa.GetNumberValue(), especialistaId);
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

                        var response = EnviarNotificacion(solicitud, notificacion.CodigoGcm);
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

        private JsonResponse EnviarNotificacion(SolicitudAtencion solicitud, string codigoGcm)
        {
            var jsonResponse = new JsonResponse { Success = false };
            string GCM_URL = ConfigurationManager.AppSettings.Get("GCM_URL");
            string collapseKey = DateTime.Now.GetDateTime(false);
            LogError("codigoGcm = " + codigoGcm);

            string mensaje =
                string.Format(
                    " Estimado {0}, su solicitud ha sido aceptada.\n Le atenderá el Dr. {1}.\n Su cita se realizará el {2}.\n\n Gracias.",
                    solicitud.ClienteUserName, solicitud.EspecialistaNombre, solicitud.FechaCita.GetDateTime(false));
            LogError("message = " + mensaje);
            LogError("requestCode = " + solicitud.Id);

            var data = new Dictionary<string, string>
            {
                {"data.message", HttpUtility.UrlEncode(mensaje)},
                {"data.requestCode", solicitud.Id.ToString()}
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
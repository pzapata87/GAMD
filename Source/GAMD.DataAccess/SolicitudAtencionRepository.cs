using System.Data;
using System;
using System.Collections.Generic;
using EDOSwit.Entity;
using GAMD.Business.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GAMD.DataAccess
{
    public class SolicitudAtencionRepository : Singleton<SolicitudAtencionRepository>
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create("DefaultConnection");

        #endregion

        #region Métodos

        public int Add(SolicitudAtencion solicitud)
        {
            int id;

            using (var comando = _database.GetStoredProcCommand("Insert_SolicitudAtencion"))
            {
                _database.AddInParameter(comando, "@ClienteId", DbType.Int32, solicitud.ClienteId);
                _database.AddInParameter(comando, "@FechaSolicitud", DbType.DateTime, solicitud.FechaSolicitud);
                _database.AddInParameter(comando, "@FechaCita", DbType.DateTime, solicitud.FechaCita);
                _database.AddInParameter(comando, "@HoraCita", DbType.String, solicitud.HoraCita);
                _database.AddInParameter(comando, "@Direccion", DbType.String, solicitud.Direccion);
                _database.AddInParameter(comando, "@CodServicio", DbType.String, solicitud.ServicioId);
                _database.AddInParameter(comando, "@Sintomas", DbType.String, solicitud.Sintomas);
                _database.AddInParameter(comando, "@Latitud", DbType.Decimal, solicitud.Latitud);
                _database.AddInParameter(comando, "@Longitud", DbType.Decimal, solicitud.Longitud);

                id = Convert.ToInt32(_database.ExecuteScalar(comando));
            }

            return id;
        }

        public void UpdateEstado(int solicitudId, int estadoSolicitud)
        {
            using (var comando = _database.GetStoredProcCommand("Update_EstadoSolicitudAtencion"))
            {
                _database.AddInParameter(comando, "@Id", DbType.Int32, solicitudId);
                _database.AddInParameter(comando, "@EstadoSolicitud", DbType.Int32, estadoSolicitud);

                _database.ExecuteNonQuery(comando);
            }
        }

        public SolicitudAtencion GetCita(int clienteId)
        {
            SolicitudAtencion solicitud = null;

            using (var comando = _database.GetStoredProcCommand("Get_CitaAtencion"))
            {
                _database.AddInParameter(comando, "@ClienteId", DbType.Int32, clienteId);

                using (var lector = _database.ExecuteReader(comando))
                {
                    if (lector.Read())
                    {
                        solicitud = new SolicitudAtencion
                        {
                            Id = lector.GetInt32(lector.GetOrdinal("Id")),
                            NumSolicitud = lector.GetString(lector.GetOrdinal("NumSolicitud")),
                            Direccion = lector.GetString(lector.GetOrdinal("Direccion")),
                            ServicioId = lector.GetString(lector.GetOrdinal("ServicioId")),
                            Sintomas = lector.GetString(lector.GetOrdinal("Sintomas")),
                            FechaSolicitud = lector.GetDateTime(lector.GetOrdinal("FechaSolicitud")),
                            EstadoSolicitud = lector.GetInt32(lector.GetOrdinal("EstadoSolicitud")),
                            FechaCita = lector.GetDateTime(lector.GetOrdinal("FechaCita")),
                            HoraCita = lector.GetString(lector.GetOrdinal("HoraCita")),
                            Latitud = lector.GetInt32(lector.GetOrdinal("Latitud")),
                            Longitud = lector.GetInt32(lector.GetOrdinal("Longitud"))
                        };
                    }
                }
            }

            return solicitud;
        }

        public List<SolicitudAtencion> GetSolicitudes(int estadoSolicitud, int especialistaId)
        {
            var list = new List<SolicitudAtencion>();

            using (var comando = _database.GetStoredProcCommand("Get_SolicitudesAtencion"))
            {
                _database.AddInParameter(comando, "@EstadoSolicitud", DbType.Int32, estadoSolicitud);
                _database.AddInParameter(comando, "@EspecialistaId", DbType.Int32, especialistaId);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(new SolicitudAtencion
                        {
                            Id = lector.GetInt32(lector.GetOrdinal("Id")),
                            NumSolicitud = lector.GetString(lector.GetOrdinal("NumSolicitud")),
                            Direccion = lector.GetString(lector.GetOrdinal("Direccion")),
                            ServicioId = lector.GetString(lector.GetOrdinal("ServicioId")),
                            Sintomas = lector.GetString(lector.GetOrdinal("Sintomas")),
                            FechaSolicitud = lector.GetDateTime(lector.GetOrdinal("FechaSolicitud")),
                            EstadoSolicitud = lector.GetInt32(lector.GetOrdinal("EstadoSolicitud")),
                            FechaCita = lector.GetDateTime(lector.GetOrdinal("FechaCita")),
                            HoraCita = lector.GetString(lector.GetOrdinal("HoraCita")),
                            Latitud = lector.GetInt32(lector.GetOrdinal("Latitud")),
                            Longitud = lector.GetInt32(lector.GetOrdinal("Longitud"))
                        });
                    }
                }
            }

            return list;
        }

        public void AsignarMedico(SolicitudAtencion solicitud)
        {
            using (var comando = _database.GetStoredProcCommand("AsignarMedico_SolicitudAtencion"))
            {
                _database.AddInParameter(comando, "@Id", DbType.Int32, solicitud.Id);
                _database.AddInParameter(comando, "@EspecialistaId", DbType.Int32, solicitud.EspecialistaId);

                _database.ExecuteNonQuery(comando);
            }
        }

        #endregion  
    }
}
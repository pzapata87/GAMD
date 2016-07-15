using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using EDOSwit.Entity;
using GAMD.Business.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GAMD.DataAccess
{
    public class EncuestaRepository : Singleton<EncuestaRepository>
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create("DefaultConnection");

        #endregion

        #region Métodos

        public int Add(PreguntaEncuestaSolicitud respuesta)
        {
            int id;

            using (var comando = _database.GetStoredProcCommand("Insert_PreguntaEncuestaSolicitud"))
            {
                _database.AddInParameter(comando, "@PreguntaEncuestaId", DbType.Int32, respuesta.PreguntaEncuestaId);
                _database.AddInParameter(comando, "@SolicitudId", DbType.Int32, respuesta.SolicitudId);
                _database.AddInParameter(comando, "@Calificacion", DbType.Int32, respuesta.Calificacion);
                _database.AddInParameter(comando, "@Observacion", DbType.String, respuesta.Observacion);

                id = Convert.ToInt32(_database.ExecuteScalar(comando));
            }

            return id;
        }

        public List<Encuesta> GetEncuestas()
        {
            var list = new List<Encuesta>();

            using (var comando = _database.GetStoredProcCommand("Get_Encuestas"))
            {
                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        string nombreEncuesta = lector.GetString(lector.GetOrdinal("Nombre"));
                        if (list.All(p => p.Nombre != nombreEncuesta))
                        {
                            list.Add(new Encuesta
                            {
                                Id = lector.GetInt32(lector.GetOrdinal("EncuestaId")),
                                Nombre = lector.GetString(lector.GetOrdinal("NombreEcuenta")),
                                PreguntaList = new List<PreguntaEncuesta>
                                {
                                    new PreguntaEncuesta
                                    {
                                        Id = lector.GetInt32(lector.GetOrdinal("PreguntaId")),
                                        Nombre = lector.GetString(lector.GetOrdinal("NombrePregunta"))
                                    }
                                }
                            });
                        }
                        else
                        {
                            var encuesta = list.First(p => p.Nombre == nombreEncuesta);
                            encuesta.PreguntaList.Add(
                                new PreguntaEncuesta
                                {
                                    Id = lector.GetInt32(lector.GetOrdinal("PreguntaId")),
                                    Nombre = lector.GetString(lector.GetOrdinal("Nombre"))
                                });
                        }
                    }
                }
            }

            return list;
        }

        public List<PreguntaEncuesta> GetPreguntas()
        {
            var list = new List<PreguntaEncuesta>();
            using (var comando = _database.GetStoredProcCommand("Get_Encuestas"))
            {
                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(new PreguntaEncuesta
                        {
                            EncuestaId = lector.GetInt32(lector.GetOrdinal("EncuestaId")),
                            Id = lector.GetInt32(lector.GetOrdinal("PreguntaId")),
                            Nombre = lector.GetString(lector.GetOrdinal("NombrePregunta"))
                        });
                    }
                }
            }

            return list;
        }

        #endregion
    }
}
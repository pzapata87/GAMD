using System;
using System.Data;
using EDOSwit.Entity;
using GAMD.Business.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GAMD.DataAccess
{
    public class NotificacionRepository : Singleton<NotificacionRepository>
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create("DefaultConnection");

        #endregion

        #region Métodos

        public int Add(string username, string codigoGcm)
        {
            int respuesta;

            using (var comando = _database.GetStoredProcCommand("AddUser_Notificacion"))
            {
                _database.AddInParameter(comando, "@Username", DbType.String, username);
                _database.AddInParameter(comando, "@CodigoGCM", DbType.String, codigoGcm);

                var resultado = _database.ExecuteNonQuery(comando);
                if (resultado == 0) throw new Exception("Error al Agregar Notificacion");
                respuesta = 1;
            }

            return respuesta;
        }

        public Notificacion GetByUsername(string username)
        {
            Notificacion notificacion = null;

            using (var comando = _database.GetStoredProcCommand("Notificacion_GetByUsername"))
            {
                _database.AddInParameter(comando, "@Username", DbType.String, username);

                using (var lector = _database.ExecuteReader(comando))
                {
                    if (lector.Read())
                    {
                        notificacion = new Notificacion
                        {
                            Username = lector.GetString(lector.GetOrdinal("Username")),
                            CodigoGcm = lector.GetString(lector.GetOrdinal("CodigoGCM"))
                        };
                    }
                }
            }

            return notificacion;
        }

        #endregion  
    }
}
using System.Data;
using System;
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
                _database.AddInParameter(comando, "@Direccion", DbType.String, solicitud.Direccion);
                _database.AddInParameter(comando, "@CodServicio", DbType.String, solicitud.ServicioId);
                _database.AddInParameter(comando, "@Sintomas", DbType.String, solicitud.Sintomas);
                _database.AddInParameter(comando, "@Latitud", DbType.Decimal, solicitud.Latitud);
                _database.AddInParameter(comando, "@Longitud", DbType.Decimal, solicitud.Longitud);

                id = Convert.ToInt32(_database.ExecuteScalar(comando));
            }

            return id;
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
using System.Data;
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

        public void Add(SolicitudAtencion solicitud)
        {
            using (var comando = _database.GetStoredProcCommand("Insert_SolicitudAtencion"))
            {
                _database.AddInParameter(comando, "@FechaSolicitud", DbType.DateTime, solicitud.FechaSolicitud);
                _database.AddInParameter(comando, "@Direccion", DbType.String, solicitud.Direccion);
                _database.AddInParameter(comando, "@CodServicio", DbType.String, solicitud.ServicioId);
                _database.AddInParameter(comando, "@Sintomas", DbType.String, solicitud.Sintomas);

                _database.ExecuteNonQuery(comando);
            }
        }

        #endregion  
    }
}
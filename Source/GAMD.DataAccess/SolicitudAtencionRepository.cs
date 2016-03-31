using System.Data;
using EDOSwit.Entity;
using GAMD.Business.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GAMD.DataAccess
{
    public class SolicitudAtencionRepository : Singleton<SolicitudAtencionRepository>
    {
        #region Attributes

        private readonly Database _database = new DatabaseProviderFactory().Create("DefaultConnection");

        #endregion

        #region Métodos

        public void Add(SolicitudAtencion solicitud)
        {
            using (var comando = _database.GetStoredProcCommand("Insert_SolicitudAtencion"))
            {
                _database.AddInParameter(comando, "@FechaSolicitud", DbType.DateTime, solicitud.FechaSolicitud);
                _database.AddInParameter(comando, "@TipoServicio", DbType.Int32, solicitud.TipoServicio);
                _database.AddInParameter(comando, "@Ubicacion", DbType.String, solicitud.Ubicacion);
                _database.AddInParameter(comando, "@Especialidad", DbType.Int32, solicitud.Especialidad);
                _database.AddInParameter(comando, "@Sintomas", DbType.String, solicitud.Sintomas);

                _database.ExecuteNonQuery(comando);
            }
        }

        #endregion  
    }
}
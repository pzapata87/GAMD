using System.Collections.Generic;
using System.Data;
using EDOSwit.Entity;
using GAMD.Business.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GAMD.DataAccess
{
    public class EspecialistaRepository : Singleton<EspecialistaRepository>
    {
        #region Attributes

        private readonly Database _database = new DatabaseProviderFactory().Create("DefaultConnection");

        #endregion

        #region M�todos

        public List<Especialista> GetEspecialistas(decimal latitud, decimal longitud, int radio)
        {
            var list = new List<Especialista>();

            using (var comando = _database.GetStoredProcCommand("Insert_SolicitudAtencion"))
            {
                _database.AddInParameter(comando, "@Latitud", DbType.Decimal, latitud);
                _database.AddInParameter(comando, "@Longitud", DbType.Decimal, longitud);
                _database.AddInParameter(comando, "@Radio", DbType.Int32, radio);

                using (var lector = _database.ExecuteReader(comando))
                {
                    if (lector.Read())
                    {
                        list.Add(new Especialista
                        {
                            Nombre = lector.IsDBNull(lector.GetOrdinal("Nombre")) ? string.Empty : lector.GetString(lector.GetOrdinal("Nombre")),
                            Apellido = lector.IsDBNull(lector.GetOrdinal("Apellido")) ? string.Empty : lector.GetString(lector.GetOrdinal("Apellido")),
                            Longitud = lector.IsDBNull(lector.GetOrdinal("Longitud")) ? 0 : lector.GetDecimal(lector.GetOrdinal("Longitud")),
                            Latitud = lector.IsDBNull(lector.GetOrdinal("Latitud")) ? 0 : lector.GetDecimal(lector.GetOrdinal("Latitud"))
                        });
                    }
                }
            }

            return list;
        }

        #endregion  
    }
}
using System.Collections.Generic;
using System.Data;
using EDOSwit.Entity;
using GAMD.Business.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GAMD.DataAccess
{
    public class EspecialistaRepository : Singleton<EspecialistaRepository>
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create("DefaultConnection");

        #endregion

        #region Métodos

        public List<Especialista> GetEspecialistas(decimal latitud, decimal longitud, int radio)
        {
            var list = new List<Especialista>();

            using (var comando = _database.GetStoredProcCommand("Get_Especialistas"))
            {
                _database.AddInParameter(comando, "@Latitud", DbType.Decimal, latitud);
                _database.AddInParameter(comando, "@Longitud", DbType.Decimal, longitud);
                _database.AddInParameter(comando, "@Radio", DbType.Int32, radio);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(new Especialista
                        {
                            Id = lector.GetInt32(lector.GetOrdinal("Id")),
                            Nombre = lector.GetString(lector.GetOrdinal("Nombre")),
                            Apellido = lector.GetString(lector.GetOrdinal("Apellido")),
                            Direccion = lector.GetString(lector.GetOrdinal("Direccion")),
                            Latitud = lector.GetDecimal(lector.GetOrdinal("Latitud")),
                            Longitud = lector.GetDecimal(lector.GetOrdinal("Longitud")),
                            Email = lector.GetString(lector.GetOrdinal("Email"))
                        });
                    }
                }
            }

            return list;
        }

        #endregion  
    }
}
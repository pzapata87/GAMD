using System.Collections.Generic;
using EDOSwit.Entity;
using GAMD.Business.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GAMD.DataAccess
{
    public class TipoParametroRepository : Singleton<TipoParametroRepository>
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create("DefaultConnection");

        #endregion

        #region Métodos

        public List<TipoParametro> GetTipos()
        {
            var list = new List<TipoParametro>();

            using (var comando = _database.GetStoredProcCommand("Get_Tipos"))
            {
                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(new TipoParametro
                        {
                            Codigo = lector.GetString(lector.GetOrdinal("Codigo")),
                            Nombre = lector.GetString(lector.GetOrdinal("Nombre")),
                            CodigoParent = lector.GetString(lector.GetOrdinal("CodigoParent")),
                            Tipo = lector.GetString(lector.GetOrdinal("Tipo"))
                        });
                    }
                }
            }

            return list;
        }
        
        #endregion
    }
}
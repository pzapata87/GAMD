using System.Collections.Generic;
using EDOSwit.Entity;
using GAMD.Business.Entity;
using GAMD.DataAccess;

namespace GAMD.Business.Logic
{
    public class TipoParametroBL : Singleton<TipoParametroBL>
    {
        public List<TipoParametro> GetTipos()
        {
            return TipoParametroRepository.Instancia.GetTipos();
        }
    }
}
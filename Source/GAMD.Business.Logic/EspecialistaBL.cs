using System.Collections.Generic;
using EDOSwit.Entity;
using GAMD.Business.Entity;
using GAMD.DataAccess;

namespace GAMD.Business.Logic
{
    public class EspecialistaBL : Singleton<EspecialistaBL>
    {
        public List<Especialista> GetEspecialistas(decimal latitud, decimal longitud, int radio)
        {
            return EspecialistaRepository.Instancia.GetEspecialistas(latitud, longitud, radio);
        }
    }
}
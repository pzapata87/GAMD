using System.Collections.Generic;
using EDOSwit.Entity;
using GAMD.Business.Entity;
using GAMD.DataAccess;

namespace GAMD.Business.Logic
{
    public class EncuestaBL : Singleton<EncuestaBL>
    {
        public int Add(PreguntaEncuestaSolicitud respuesta)
        {
            return EncuestaRepository.Instancia.Add(respuesta);
        }

        public List<Encuesta> GetEncuestas()
        {
            return EncuestaRepository.Instancia.GetEncuestas();
        }

        public List<PreguntaEncuesta> GetPreguntas()
        {
            return EncuestaRepository.Instancia.GetPreguntas();
        }
    }
}
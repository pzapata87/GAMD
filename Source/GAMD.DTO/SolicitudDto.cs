﻿namespace GAMD.DTO
{
    public class SolicitudDto
    {
        public int ClienteId { get; set; }
        public string Direccion { get; set; }
        public string TipoServicioId { get; set; }
        public string EspecialidadId { get; set; }
        public string ServicioId { get; set; }
        public string Sintomas { get; set; }
        public decimal Latitud { get; set; }
        public decimal Longitud { get; set; }
        public string ClienteUserName { get; set; }
        public string FechaAtencion { get; set; }
        public string HoraAtencion { get; set; }
        public int SolicitudId { get; set; }
        public string Observacion { get; set; }
        public int EspecialistaId { get; set; }
    }
}
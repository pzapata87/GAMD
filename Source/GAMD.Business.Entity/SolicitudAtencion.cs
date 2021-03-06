﻿using System;

namespace GAMD.Business.Entity
{
    public class SolicitudAtencion
    {
        public int Id { get; set; }
        public int ClienteId { get; set; }
        public string ClienteUserName { get; set; }
        public string ClienteNombre { get; set; }
        public string NumSolicitud { get; set; }
        public string Direccion { get; set; }
        public DateTime FechaSolicitud { get; set; }
        public string ServicioId { get; set; }
        public string Sintomas { get; set; }
        public int EspecialistaId { get; set; }
        public string EspecialistaNombre { get; set; }
        public DateTime FechaCita { get; set; }
        public string HoraCita { get; set; }
        public decimal Latitud { get; set; }
        public decimal Longitud { get; set; }
        public int EstadoSolicitud { get; set; }
    }
}
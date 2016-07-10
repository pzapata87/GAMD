﻿using System;

namespace GAMD.Business.Entity
{
    public class Persona
    {
        public int Id { get; set; }
        public string Dni { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public DateTime? FechaNacimiento { get; set; }
        public string Direccion { get; set; }
        public string Email { get; set; }
    }
}
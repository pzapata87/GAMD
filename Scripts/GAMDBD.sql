USE [GAMDBD]
GO
CREATE TABLE [dbo].[CitaAtencion](
	[SolicitudAtencionId] [int] NOT NULL,
	[NumCita] [nvarchar](5) NULL,
	[FechaCita] [datetime] NOT NULL,
	[EspecialistaId] [int] NOT NULL,
	[EstadoCita] [int] NOT NULL,
	[Observacion] [nvarchar](max) NULL,
 CONSTRAINT [PK_CitaAtencion] PRIMARY KEY CLUSTERED 
(
	[SolicitudAtencionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[Id] [int] NOT NULL,
	[Telefono] [nvarchar](10) NULL,
	[Celular] [nvarchar](15) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Correlativo]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Correlativo](
	[Id] [int] NOT NULL,
	[Valor] [int] NOT NULL,
	[Descripcion] [nvarchar](200) NULL,
 CONSTRAINT [PK_Correlativo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Encuesta]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Encuesta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Encuesta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Especialidad]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Especialidad](
	[Codi] [nvarchar](5) NOT NULL,
	[Descripcion] [nvarchar](200) NOT NULL,
	[CodTipoServicio] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_Especialidad] PRIMARY KEY CLUSTERED 
(
	[Codi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Especialista]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Especialista](
	[Id] [int] NOT NULL,
	[Latitud] [decimal](18, 6) NOT NULL,
	[Longitud] [decimal](18, 6) NOT NULL,
	[CodEspecialidad] [nvarchar](5) NOT NULL,
	[Calificacion] [int] NULL,
 CONSTRAINT [PK_Especialista] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Notificacion]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notificacion](
	[Username] [nvarchar](50) NOT NULL,
	[CodigoGCM] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Notificacion] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Persona]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persona](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Dni] [nvarchar](8) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Apellido] [nvarchar](100) NOT NULL,
	[FechaNacimiento] [datetime] NULL,
	[Direccion] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
 CONSTRAINT [PK_dbo.Persona] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PreguntaEncuesta]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreguntaEncuesta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](200) NOT NULL,
	[EncuestaId] [int] NOT NULL,
 CONSTRAINT [PK_PreguntaEncuesta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PreguntaEncuestaSolicitud]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreguntaEncuestaSolicitud](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PreguntaEncuestaId] [int] NOT NULL,
	[SolicitudId] [int] NOT NULL,
	[Calificacion] [int] NOT NULL,
	[Observacion] [nvarchar](max) NULL,
 CONSTRAINT [PK_PreguntaEncuestaSolicitud] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Servicio]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servicio](
	[Codi] [nvarchar](5) NOT NULL,
	[Descripcion] [nvarchar](200) NULL,
	[CodEspecialidad] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_Servicio] PRIMARY KEY CLUSTERED 
(
	[Codi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SolicitudAtencion]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolicitudAtencion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NumSolicitud] [nvarchar](5) NULL,
	[ClienteId] [int] NOT NULL,
	[Direccion] [nvarchar](100) NOT NULL,
	[CodServicio] [nvarchar](5) NOT NULL,
	[Sintomas] [nvarchar](max) NOT NULL,
	[FechaSolicitud] [datetime] NULL,
	[EstadoSolicitud] [int] NOT NULL,
	[FechaCita] [datetime] NULL,
	[Latitud] [decimal](18, 6) NULL,
	[Longitud] [decimal](18, 6) NULL,
	[HoraCita] [nvarchar](20) NULL,
 CONSTRAINT [PK_SolicitudAtencion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoServicio]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoServicio](
	[Codi] [nvarchar](5) NOT NULL,
	[Descripcion] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_TipoServicio] PRIMARY KEY CLUSTERED 
(
	[Codi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[PersonaId] [int] NOT NULL,
	[Estado] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[CitaAtencion] ([SolicitudAtencionId], [NumCita], [FechaCita], [EspecialistaId], [EstadoCita], [Observacion]) VALUES (3, N'1', CAST(N'2016-07-12 00:00:00.000' AS DateTime), 1, 1, N'wdwed')
GO
INSERT [dbo].[Cliente] ([Id], [Telefono], [Celular]) VALUES (10, N'5555555', N'555454442')
GO
INSERT [dbo].[Correlativo] ([Id], [Valor], [Descripcion]) VALUES (1, 13, N'Correlativo para las Solicitudes')
GO
INSERT [dbo].[Correlativo] ([Id], [Valor], [Descripcion]) VALUES (2, 6, N'Correlativo para las Citas')
GO
SET IDENTITY_INSERT [dbo].[Encuesta] ON 

GO
INSERT [dbo].[Encuesta] ([Id], [Nombre]) VALUES (1, N'Encuesta 01')
GO
SET IDENTITY_INSERT [dbo].[Encuesta] OFF
GO
INSERT [dbo].[Especialidad] ([Codi], [Descripcion], [CodTipoServicio]) VALUES (N'1', N'Especialidad 01', N'1')
GO
INSERT [dbo].[Especialidad] ([Codi], [Descripcion], [CodTipoServicio]) VALUES (N'2', N'Especialidad 02', N'2')
GO
INSERT [dbo].[Especialidad] ([Codi], [Descripcion], [CodTipoServicio]) VALUES (N'3', N'Especialidad 03', N'3')
GO
INSERT [dbo].[Especialidad] ([Codi], [Descripcion], [CodTipoServicio]) VALUES (N'4', N'Especialidad 04', N'1')
GO
INSERT [dbo].[Especialidad] ([Codi], [Descripcion], [CodTipoServicio]) VALUES (N'5', N'especialidad 05', N'1')
GO
INSERT [dbo].[Especialista] ([Id], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (1, CAST(-12.098686 AS Decimal(18, 6)), CAST(-77.042952 AS Decimal(18, 6)), N'1', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (2, CAST(-12.095287 AS Decimal(18, 6)), CAST(-77.037201 AS Decimal(18, 6)), N'1', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (3, CAST(-12.096378 AS Decimal(18, 6)), CAST(-77.053552 AS Decimal(18, 6)), N'1', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (4, CAST(-11.958825 AS Decimal(18, 6)), CAST(-77.106201 AS Decimal(18, 6)), N'2', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (5, CAST(-12.004737 AS Decimal(18, 6)), CAST(-77.093743 AS Decimal(18, 6)), N'1', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (6, CAST(-11.998105 AS Decimal(18, 6)), CAST(-77.071448 AS Decimal(18, 6)), N'2', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (7, CAST(-12.041674 AS Decimal(18, 6)), CAST(-77.039690 AS Decimal(18, 6)), N'3', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (8, CAST(-12.041789 AS Decimal(18, 6)), CAST(-77.048370 AS Decimal(18, 6)), N'1', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (9, CAST(-12.048273 AS Decimal(18, 6)), CAST(-77.049582 AS Decimal(18, 6)), N'3', 1)
GO
INSERT [dbo].[Notificacion] ([Username], [CodigoGCM]) VALUES (N'cliente01@hotmail.com', N'dGKPfPwfiXE:APA91bEnCTlRkMhHKIOfEHUf6Xy5jpPP0sClZBNCiszR9R-Q5jJMu1uPKgGudDwE_d2irW70N8uAaNv3RY_dW7FHQ-PCtmkulUjZ6wcnBGuB5LJotqLVTgUoPAYtvCSoYzXGwL_0ad5z')
GO
SET IDENTITY_INSERT [dbo].[Persona] ON 

GO
INSERT [dbo].[Persona] ([Id], [Dni], [Nombre], [Apellido], [FechaNacimiento], [Direccion], [Email]) VALUES (1, N'12345678', N'Especilista 01', N'Apellido', NULL, N'San Isidro', NULL)
GO
INSERT [dbo].[Persona] ([Id], [Dni], [Nombre], [Apellido], [FechaNacimiento], [Direccion], [Email]) VALUES (2, N'12345678', N'Especilista 02', N'Apellido', NULL, N'San Isidro', NULL)
GO
INSERT [dbo].[Persona] ([Id], [Dni], [Nombre], [Apellido], [FechaNacimiento], [Direccion], [Email]) VALUES (3, N'12345678', N'Especilista 03', N'Apellido', NULL, N'San Isidro', NULL)
GO
INSERT [dbo].[Persona] ([Id], [Dni], [Nombre], [Apellido], [FechaNacimiento], [Direccion], [Email]) VALUES (4, N'12345678', N'Especilista 04', N'Apellido', NULL, N'San Isidro', NULL)
GO
INSERT [dbo].[Persona] ([Id], [Dni], [Nombre], [Apellido], [FechaNacimiento], [Direccion], [Email]) VALUES (5, N'12345678', N'Especilista 05', N'Apellido', NULL, N'San Isidro', NULL)
GO
INSERT [dbo].[Persona] ([Id], [Dni], [Nombre], [Apellido], [FechaNacimiento], [Direccion], [Email]) VALUES (6, N'12345678', N'Especilista 06', N'Apellido', NULL, N'San Isidro', NULL)
GO
INSERT [dbo].[Persona] ([Id], [Dni], [Nombre], [Apellido], [FechaNacimiento], [Direccion], [Email]) VALUES (7, N'12345678', N'Especilista 07', N'Apellido', NULL, N'San Isidro', NULL)
GO
INSERT [dbo].[Persona] ([Id], [Dni], [Nombre], [Apellido], [FechaNacimiento], [Direccion], [Email]) VALUES (8, N'12345678', N'Especilista 08', N'Apellido', NULL, N'San Isidro', NULL)
GO
INSERT [dbo].[Persona] ([Id], [Dni], [Nombre], [Apellido], [FechaNacimiento], [Direccion], [Email]) VALUES (9, N'12345678', N'Especilista 09', N'Apellido', NULL, N'San Isidro', NULL)
GO
INSERT [dbo].[Persona] ([Id], [Dni], [Nombre], [Apellido], [FechaNacimiento], [Direccion], [Email]) VALUES (10, N'31321321', N'Cliente 01', N'Apellido 01', NULL, NULL, N'cliente01@hotmail.com')
GO
SET IDENTITY_INSERT [dbo].[Persona] OFF
GO
SET IDENTITY_INSERT [dbo].[PreguntaEncuesta] ON 

GO
INSERT [dbo].[PreguntaEncuesta] ([Id], [Nombre], [EncuestaId]) VALUES (1, N'Pregunta 01', 1)
GO
INSERT [dbo].[PreguntaEncuesta] ([Id], [Nombre], [EncuestaId]) VALUES (2, N'Pregunta 02', 1)
GO
INSERT [dbo].[PreguntaEncuesta] ([Id], [Nombre], [EncuestaId]) VALUES (3, N'Pregunta 03', 1)
GO
SET IDENTITY_INSERT [dbo].[PreguntaEncuesta] OFF
GO
SET IDENTITY_INSERT [dbo].[PreguntaEncuestaSolicitud] ON 

GO
INSERT [dbo].[PreguntaEncuestaSolicitud] ([Id], [PreguntaEncuestaId], [SolicitudId], [Calificacion], [Observacion]) VALUES (3, 1, 2, 5, N'OBSERVACION 01')
GO
SET IDENTITY_INSERT [dbo].[PreguntaEncuestaSolicitud] OFF
GO
INSERT [dbo].[Servicio] ([Codi], [Descripcion], [CodEspecialidad]) VALUES (N'1', N'Servicio 01', N'1')
GO
INSERT [dbo].[Servicio] ([Codi], [Descripcion], [CodEspecialidad]) VALUES (N'2', N'Servicio 02', N'1')
GO
INSERT [dbo].[Servicio] ([Codi], [Descripcion], [CodEspecialidad]) VALUES (N'3', N'Servicio 03', N'2')
GO
INSERT [dbo].[Servicio] ([Codi], [Descripcion], [CodEspecialidad]) VALUES (N'4', N'Servicio 04', N'3')
GO
SET IDENTITY_INSERT [dbo].[SolicitudAtencion] ON 

GO
INSERT [dbo].[SolicitudAtencion] ([Id], [NumSolicitud], [ClienteId], [Direccion], [CodServicio], [Sintomas], [FechaSolicitud], [EstadoSolicitud], [FechaCita], [Latitud], [Longitud], [HoraCita]) VALUES (2, N'1', 10, N'AAAA', N'1', N'QQQQ', CAST(N'2016-07-12 00:00:00.000' AS DateTime), 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[SolicitudAtencion] ([Id], [NumSolicitud], [ClienteId], [Direccion], [CodServicio], [Sintomas], [FechaSolicitud], [EstadoSolicitud], [FechaCita], [Latitud], [Longitud], [HoraCita]) VALUES (3, N'10', 10, N'casa', N'1', N'1', CAST(N'2016-07-12 03:14:02.127' AS DateTime), 1, CAST(N'2016-07-12 00:00:00.000' AS DateTime), CAST(-12.096378 AS Decimal(18, 6)), CAST(-77.053552 AS Decimal(18, 6)), N'6:00 am - 8:00 am')
GO
INSERT [dbo].[SolicitudAtencion] ([Id], [NumSolicitud], [ClienteId], [Direccion], [CodServicio], [Sintomas], [FechaSolicitud], [EstadoSolicitud], [FechaCita], [Latitud], [Longitud], [HoraCita]) VALUES (4, N'11', 10, N'casa', N'1', N'1', CAST(N'2016-07-12 03:17:36.783' AS DateTime), 1, CAST(N'2016-07-12 00:00:00.000' AS DateTime), CAST(-12.096378 AS Decimal(18, 6)), CAST(-77.053552 AS Decimal(18, 6)), N'6:00 am - 8:00 am')
GO
INSERT [dbo].[SolicitudAtencion] ([Id], [NumSolicitud], [ClienteId], [Direccion], [CodServicio], [Sintomas], [FechaSolicitud], [EstadoSolicitud], [FechaCita], [Latitud], [Longitud], [HoraCita]) VALUES (5, N'12', 10, N'casa', N'1', N'1', CAST(N'2016-07-13 01:36:04.730' AS DateTime), 1, CAST(N'2016-07-12 00:00:00.000' AS DateTime), CAST(-12.096378 AS Decimal(18, 6)), CAST(-77.053552 AS Decimal(18, 6)), N'6:00 am - 8:00 am')
GO
INSERT [dbo].[SolicitudAtencion] ([Id], [NumSolicitud], [ClienteId], [Direccion], [CodServicio], [Sintomas], [FechaSolicitud], [EstadoSolicitud], [FechaCita], [Latitud], [Longitud], [HoraCita]) VALUES (6, N'13', 10, N'casa', N'1', N'1', CAST(N'2016-07-13 01:36:46.863' AS DateTime), 1, CAST(N'2016-07-12 00:00:00.000' AS DateTime), CAST(-12.096378 AS Decimal(18, 6)), CAST(-77.053552 AS Decimal(18, 6)), N'6:00 am - 8:00 am')
GO
SET IDENTITY_INSERT [dbo].[SolicitudAtencion] OFF
GO
INSERT [dbo].[TipoServicio] ([Codi], [Descripcion]) VALUES (N'1', N'Tipo Servicio 01')
GO
INSERT [dbo].[TipoServicio] ([Codi], [Descripcion]) VALUES (N'2', N'Tipo Servicio 02')
GO
INSERT [dbo].[TipoServicio] ([Codi], [Descripcion]) VALUES (N'3', N'Tipo Servicio 03')
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

GO
INSERT [dbo].[Usuario] ([Id], [UserName], [Password], [PersonaId], [Estado]) VALUES (1, N'cliente01@hotmail.com', N'1234', 10, 1)
GO
INSERT [dbo].[Usuario] ([Id], [UserName], [Password], [PersonaId], [Estado]) VALUES (2, N'especialista@hotmail.com', N'1234', 9, 1)
GO
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
ALTER TABLE [dbo].[CitaAtencion]  WITH CHECK ADD  CONSTRAINT [FK_CitaAtencion_Especialista] FOREIGN KEY([EspecialistaId])
REFERENCES [dbo].[Especialista] ([Id])
GO
ALTER TABLE [dbo].[CitaAtencion] CHECK CONSTRAINT [FK_CitaAtencion_Especialista]
GO
ALTER TABLE [dbo].[CitaAtencion]  WITH CHECK ADD  CONSTRAINT [FK_CitaAtencion_SolicitudAtencion] FOREIGN KEY([SolicitudAtencionId])
REFERENCES [dbo].[SolicitudAtencion] ([Id])
GO
ALTER TABLE [dbo].[CitaAtencion] CHECK CONSTRAINT [FK_CitaAtencion_SolicitudAtencion]
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Persona] FOREIGN KEY([Id])
REFERENCES [dbo].[Persona] ([Id])
GO
ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [FK_Cliente_Persona]
GO
ALTER TABLE [dbo].[Especialidad]  WITH CHECK ADD  CONSTRAINT [FK_Especialidad_TipoServicio] FOREIGN KEY([CodTipoServicio])
REFERENCES [dbo].[TipoServicio] ([Codi])
GO
ALTER TABLE [dbo].[Especialidad] CHECK CONSTRAINT [FK_Especialidad_TipoServicio]
GO
ALTER TABLE [dbo].[Especialista]  WITH CHECK ADD  CONSTRAINT [FK_Especialista_Especialidad] FOREIGN KEY([CodEspecialidad])
REFERENCES [dbo].[Especialidad] ([Codi])
GO
ALTER TABLE [dbo].[Especialista] CHECK CONSTRAINT [FK_Especialista_Especialidad]
GO
ALTER TABLE [dbo].[Especialista]  WITH CHECK ADD  CONSTRAINT [FK_Especialista_Persona] FOREIGN KEY([Id])
REFERENCES [dbo].[Persona] ([Id])
GO
ALTER TABLE [dbo].[Especialista] CHECK CONSTRAINT [FK_Especialista_Persona]
GO
ALTER TABLE [dbo].[PreguntaEncuesta]  WITH CHECK ADD  CONSTRAINT [FK_PreguntaEncuesta_Encuesta] FOREIGN KEY([EncuestaId])
REFERENCES [dbo].[Encuesta] ([Id])
GO
ALTER TABLE [dbo].[PreguntaEncuesta] CHECK CONSTRAINT [FK_PreguntaEncuesta_Encuesta]
GO
ALTER TABLE [dbo].[PreguntaEncuestaSolicitud]  WITH CHECK ADD  CONSTRAINT [FK_PreguntaEncuestaSolicitud_PreguntaEncuesta] FOREIGN KEY([PreguntaEncuestaId])
REFERENCES [dbo].[PreguntaEncuesta] ([Id])
GO
ALTER TABLE [dbo].[PreguntaEncuestaSolicitud] CHECK CONSTRAINT [FK_PreguntaEncuestaSolicitud_PreguntaEncuesta]
GO
ALTER TABLE [dbo].[PreguntaEncuestaSolicitud]  WITH CHECK ADD  CONSTRAINT [FK_PreguntaEncuestaSolicitud_SolicitudAtencion] FOREIGN KEY([SolicitudId])
REFERENCES [dbo].[SolicitudAtencion] ([Id])
GO
ALTER TABLE [dbo].[PreguntaEncuestaSolicitud] CHECK CONSTRAINT [FK_PreguntaEncuestaSolicitud_SolicitudAtencion]
GO
ALTER TABLE [dbo].[Servicio]  WITH CHECK ADD  CONSTRAINT [FK_Servicio_Servicio] FOREIGN KEY([CodEspecialidad])
REFERENCES [dbo].[Especialidad] ([Codi])
GO
ALTER TABLE [dbo].[Servicio] CHECK CONSTRAINT [FK_Servicio_Servicio]
GO
ALTER TABLE [dbo].[SolicitudAtencion]  WITH CHECK ADD  CONSTRAINT [FK_SolicitudAtencion_Cliente] FOREIGN KEY([ClienteId])
REFERENCES [dbo].[Cliente] ([Id])
GO
ALTER TABLE [dbo].[SolicitudAtencion] CHECK CONSTRAINT [FK_SolicitudAtencion_Cliente]
GO
ALTER TABLE [dbo].[SolicitudAtencion]  WITH CHECK ADD  CONSTRAINT [FK_SolicitudAtencion_Servicio] FOREIGN KEY([CodServicio])
REFERENCES [dbo].[Servicio] ([Codi])
GO
ALTER TABLE [dbo].[SolicitudAtencion] CHECK CONSTRAINT [FK_SolicitudAtencion_Servicio]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Persona] FOREIGN KEY([PersonaId])
REFERENCES [dbo].[Persona] ([Id])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Persona]
GO
/****** Object:  StoredProcedure [dbo].[AddUser_Notificacion]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddUser_Notificacion]
	@Username VARCHAR(50),
	@CodigoGCM VARCHAR(200)    
AS          
BEGIN   
	DECLARE @CantidadRegistros INT;

	SELECT
		@CantidadRegistros = COUNT(N.Username)
	FROM Notificacion N
	WHERE 
		N.Username = @Username;

	IF @CantidadRegistros = 0
	BEGIN
		INSERT INTO Notificacion(Username,CodigoGCM)
		VALUES(@Username, @CodigoGCM); 
	END
	ELSE
	BEGIN
		UPDATE Notificacion
		SET CodigoGCM = @CodigoGCM
		WHERE
			Username = @Username
	END
END

GO
/****** Object:  StoredProcedure [dbo].[AsignarMedico_SolicitudAtencion]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AsignarMedico_SolicitudAtencion]
	@Id int,
	@EspecialistaId int
AS    
BEGIN
	DECLARE @Correlativo int;

	SELECT @Correlativo = (Valor + 1) FROM Correlativo WHERE Id = 2;

	INSERT INTO CitaAtencion
		(SolicitudAtencionId, NumCita, FechaCita, EspecialistaId, EstadoCita)
	SELECT Id, @Correlativo, FechaCita, @EspecialistaId, 1
	FROM SolicitudAtencion
	WHERE Id = @Id;

	UPDATE Correlativo SET Valor = @Correlativo
	WHERE Id = 2;
END
GO
/****** Object:  StoredProcedure [dbo].[Get_CitaAtencionPorCliente]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Get_CitaAtencionPorCliente]
	@ClienteId int
AS    
BEGIN
	SELECT TOP 1
		sa.Id,
		[NumSolicitud],
		[ClienteId],
		[Direccion],
		[CodServicio] ServicioId,
		[Sintomas],
		[FechaSolicitud],
		[EstadoSolicitud],
		sa.[FechaCita],
		[HoraCita],
		[Latitud],
		[Longitud]
	FROM SolicitudAtencion sa
		INNER JOIN CitaAtencion ca ON sa.Id = ca.SolicitudAtencionId
	WHERE ClienteId = @ClienteId
		AND EstadoSolicitud = 1
		AND EstadoCita = 1 
END

GO
/****** Object:  StoredProcedure [dbo].[Get_CitaAtencionPorId]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Get_CitaAtencionPorId]
	@SolicitudId int
AS    
BEGIN
	SELECT TOP 1
		sa.Id,
		[NumSolicitud],
		[ClienteId],
		us.UserName ClienteUserName,
		CONCAT(pcl.Nombre, ' ', pcl.Apellido)  NombreCliente,		
		ca.EspecialistaId,
		CONCAT(pes.Nombre, ' ', pes.Apellido)  NombreEspecialista,
		sa.[Direccion],
		[CodServicio] ServicioId,
		[Sintomas],
		[FechaSolicitud],
		[EstadoSolicitud],
		sa.[FechaCita],
		[HoraCita],
		[Latitud],
		[Longitud]
	FROM SolicitudAtencion sa
		INNER JOIN Persona pcl ON pcl.Id = sa.ClienteId
		INNER JOIN CitaAtencion ca ON sa.Id = ca.SolicitudAtencionId
		INNER JOIN Persona pes ON pes.Id = ca.EspecialistaId
		INNER JOIN Usuario us ON us.PersonaId = sa.ClienteId
	WHERE sa.Id = @SolicitudId
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Encuestas]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Get_Encuestas]
AS    
BEGIN
	
	SELECT
		e.Id EncuestaId,
		e.Nombre NombreEcuenta,
		pe.Id PreguntaId,
		pe.Nombre NombrePregunta		
	FROM PreguntaEncuesta pe
		INNER JOIN Encuesta e ON e.Id = pe.EncuestaId

END

GO
/****** Object:  StoredProcedure [dbo].[Get_Especialistas]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Especialistas]
	@Latitud decimal(18,6),
	@Longitud decimal(18,6),
	@Radio INT -- KM
AS    
BEGIN
	SELECT 
			*
		FROM Especialista esp
			INNER JOIN Persona per ON per.Id = esp.Id
		WHERE (6371 *  
			ACOS(  
				COS(RADIANS(@Latitud))  
				*  COS(RADIANS(Latitud))  
				*  COS(RADIANS(Longitud) - RADIANS(@Longitud) )  
				+  SIN(RADIANS(@Latitud))  
				*  SIN(RADIANS(Latitud ))  
			)) <= @Radio
END

GO
/****** Object:  StoredProcedure [dbo].[Get_SolicitudesAtencion]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_SolicitudesAtencion]
	@EstadoSolicitud INT,
	@EspecialistaId INT
AS    
BEGIN
	
	SELECT
		sa.Id,
		[NumSolicitud],
		[ClienteId],
		[Direccion],
		[CodServicio] ServicioId,
		[Sintomas],
		[FechaSolicitud],
		[EstadoSolicitud],
		sa.[FechaCita],
		[HoraCita],
		[Latitud],
		[Longitud]
	FROM SolicitudAtencion sa
		INNER JOIN CitaAtencion ca ON sa.Id = ca.SolicitudAtencionId
	WHERE (@EstadoSolicitud = 0 
		OR EstadoSolicitud = @EstadoSolicitud)
		AND ca.EspecialistaId = @EspecialistaId;

END

GO
/****** Object:  StoredProcedure [dbo].[Get_User]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_User]
	@Username nvarchar(50),
	@Password nvarchar(50)
AS    
BEGIN
	SELECT TOP 1
		p.Id,
		Nombre,
		Apellido,
		UserName,
		CASE  
			 WHEN EXISTS (SELECT 1 FROM Especialista esp WHERE esp.Id = p.Id) 
			 THEN 2
			 ELSE 1
		END AS TipoUsuario,
		Estado
	FROM Usuario u
	INNER JOIN Persona p ON p.Id = u.PersonaId
	WHERE Username = @Username
		AND [Password] COLLATE Latin1_General_CS_AS = @Password
END
GO
/****** Object:  StoredProcedure [dbo].[GetByUsername_Notificacion]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetByUsername_Notificacion]
	@Username VARCHAR(50)    
AS          
BEGIN

	SELECT
		Username,
		CodigoGCM
	FROM Notificacion
	WHERE 
		Username = @Username;

END

GO
/****** Object:  StoredProcedure [dbo].[Insert_PreguntaEncuestaSolicitud]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_PreguntaEncuestaSolicitud]
	@PreguntaEncuestaId int,
	@SolicitudId int,
	@Calificacion int,
	@Observacion nvarchar(MAX)
AS    
BEGIN
	INSERT INTO 
		PreguntaEncuestaSolicitud (PreguntaEncuestaId, SolicitudId, Calificacion, Observacion)
	VALUES 
		(@PreguntaEncuestaId, @SolicitudId, @Calificacion, @Observacion);

	SELECT SCOPE_IDENTITY();
END

GO
/****** Object:  StoredProcedure [dbo].[Insert_SolicitudAtencion]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_SolicitudAtencion]
	@ClienteId int,
	@FechaSolicitud datetime,
	@FechaCita datetime,
	@HoraCita nvarchar(20),
	@Direccion nvarchar(100),
	@CodServicio nvarchar(5),
	@Sintomas nvarchar(max),
	@Latitud decimal(18,6),
	@Longitud decimal(18,6)
AS    
BEGIN	
	DECLARE @SolicitudId int;
	DECLARE @Correlativo int;

	SELECT TOP 1 @Correlativo = (Valor + 1) FROM Correlativo WHERE Id = 1;

	INSERT INTO 
		SolicitudAtencion (NumSolicitud, ClienteId, Direccion, CodServicio, Sintomas, FechaSolicitud, FechaCita, HoraCita,
			Latitud, Longitud, EstadoSolicitud)
	VALUES 
		(@Correlativo, @ClienteId, @Direccion, @CodServicio, @Sintomas, @FechaSolicitud, @FechaCita, @HoraCita, @Latitud, @Longitud, 1);

	SELECT @SolicitudId = SCOPE_IDENTITY();

	UPDATE Correlativo SET Valor = @Correlativo
	WHERE Id = 1;

	SELECT @SolicitudId;
END

GO
/****** Object:  StoredProcedure [dbo].[Update_EstadoSolicitudAtencion]    Script Date: 21/06/2017 18:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_EstadoSolicitudAtencion]
	@SolicitudAtencionId nvarchar(50),
	@EstadoSolicitud INT,
	@Observacion nvarchar(MAX)
AS    
BEGIN
	
	UPDATE SolicitudAtencion
	SET EstadoSolicitud = @EstadoSolicitud
	WHERE Id = @SolicitudAtencionId;

	UPDATE CitaAtencion
	SET EstadoCita = @EstadoSolicitud,
		Observacion = @Observacion
	WHERE SolicitudAtencionId = @SolicitudAtencionId;

END

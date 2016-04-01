CREATE DATABASE [GAMDBD]
GO
USE [GAMDBD]
GO
/****** Object:  StoredProcedure [dbo].[Get_Especialistas]    Script Date: 01/04/2016 15:25:58 ******/
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
		FROM Especialista
		where (6371 *  
			ACOS(  
				COS(RADIANS(@Latitud))  
				*  COS(RADIANS(Latitud))  
				*  COS(RADIANS(Longitud) - RADIANS(@Longitud) )  
				+  SIN(RADIANS(@Latitud))  
				*  SIN(RADIANS(Latitud ))  
			)) <= @Radio
END
GO
/****** Object:  StoredProcedure [dbo].[Insert_SolicitudAtencion]    Script Date: 01/04/2016 15:25:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_SolicitudAtencion]
	@FechaSolicitud datetime,
	@Direccion nvarchar(100),
	@CodServicio nvarchar(5),
	@Sintomas nvarchar(max)
AS    
BEGIN
	INSERT INTO 
		SolicitudAtencion (NumSolicitud, Direccion, CodServicio, Sintomas, FechaSolicitud)
	VALUES 
		(1, @Direccion, @CodServicio, @Sintomas, @FechaSolicitud)
END
GO
/****** Object:  Table [dbo].[Especialidad]    Script Date: 01/04/2016 15:25:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Especialidad](
	[Codigo] [nvarchar](5) NOT NULL,
	[Descripcion] [nvarchar](200) NOT NULL,
	[CodTipoServicio] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_Especialidad] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Especialista]    Script Date: 01/04/2016 15:25:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Especialista](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Dni] [char](8) NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Apellido] [nvarchar](100) NOT NULL,
	[Direccion] [nvarchar](100) NOT NULL,
	[Latitud] [decimal](18, 6) NOT NULL,
	[Longitud] [decimal](18, 6) NOT NULL,
	[CodEspecialidad] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_Especialista] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Servicio]    Script Date: 01/04/2016 15:25:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servicio](
	[Codigo] [nvarchar](5) NOT NULL,
	[Descripcion] [nvarchar](200) NULL,
	[CodEspecialidad] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_Servicio] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SolicitudAtencion]    Script Date: 01/04/2016 15:25:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolicitudAtencion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NumSolicitud] [int] NOT NULL,
	[Direccion] [nvarchar](100) NOT NULL,
	[CodServicio] [nvarchar](5) NOT NULL,
	[Sintomas] [nvarchar](max) NOT NULL,
	[FechaSolicitud] [datetime] NOT NULL,
 CONSTRAINT [PK_SolicitudAtencion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoServicio]    Script Date: 01/04/2016 15:25:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoServicio](
	[Codigo] [nvarchar](5) NOT NULL,
	[Descripcion] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_TipoServicio] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Especialidad] ([Codigo], [Descripcion], [CodTipoServicio]) VALUES (N'1', N'Especialidad 01', N'1')
GO
INSERT [dbo].[Especialidad] ([Codigo], [Descripcion], [CodTipoServicio]) VALUES (N'2', N'Especialidad 02', N'2')
GO
INSERT [dbo].[Especialidad] ([Codigo], [Descripcion], [CodTipoServicio]) VALUES (N'3', N'Especialidad 03', N'3')
GO
INSERT [dbo].[Especialidad] ([Codigo], [Descripcion], [CodTipoServicio]) VALUES (N'4', N'Especialidad 04', N'1')
GO
INSERT [dbo].[Especialidad] ([Codigo], [Descripcion], [CodTipoServicio]) VALUES (N'5', N'especialidad 05', N'1')
GO
SET IDENTITY_INSERT [dbo].[Especialista] ON 

GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad]) VALUES (1, NULL, N'Especilista 01', N'Apellido', N'San Isidro', CAST(-12.098686 AS Decimal(18, 6)), CAST(-77.042952 AS Decimal(18, 6)), N'1')
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad]) VALUES (2, NULL, N'Especilista 02', N'Apellido', N'San Isidro', CAST(-12.095287 AS Decimal(18, 6)), CAST(-77.037201 AS Decimal(18, 6)), N'1')
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad]) VALUES (3, NULL, N'Especilista 03', N'Apellido', N'San Isidro', CAST(-12.096378 AS Decimal(18, 6)), CAST(-77.053552 AS Decimal(18, 6)), N'1')
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad]) VALUES (4, NULL, N'Especilista 04', N'Apellido', N'San Isidro', CAST(-11.958825 AS Decimal(18, 6)), CAST(-77.106201 AS Decimal(18, 6)), N'2')
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad]) VALUES (5, NULL, N'Especilista 05', N'Apellido', N'San Isidro', CAST(-12.004737 AS Decimal(18, 6)), CAST(-77.093743 AS Decimal(18, 6)), N'1')
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad]) VALUES (6, NULL, N'Especilista 06', N'Apellido', N'San Isidro', CAST(-11.998105 AS Decimal(18, 6)), CAST(-77.071448 AS Decimal(18, 6)), N'2')
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad]) VALUES (7, NULL, N'Especilista 07', N'Apellido', N'San Isidro', CAST(-12.041674 AS Decimal(18, 6)), CAST(-77.039690 AS Decimal(18, 6)), N'3')
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad]) VALUES (8, NULL, N'Especilista 08', N'Apellido', N'San Isidro', CAST(-12.041789 AS Decimal(18, 6)), CAST(-77.048370 AS Decimal(18, 6)), N'1')
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad]) VALUES (9, NULL, N'Especilista 09', N'Apellido', N'San Isidro', CAST(-12.048273 AS Decimal(18, 6)), CAST(-77.049582 AS Decimal(18, 6)), N'3')
GO
SET IDENTITY_INSERT [dbo].[Especialista] OFF
GO
INSERT [dbo].[Servicio] ([Codigo], [Descripcion], [CodEspecialidad]) VALUES (N'1', N'Servicio 01', N'1')
GO
INSERT [dbo].[Servicio] ([Codigo], [Descripcion], [CodEspecialidad]) VALUES (N'2', N'Servicio 02', N'1')
GO
INSERT [dbo].[Servicio] ([Codigo], [Descripcion], [CodEspecialidad]) VALUES (N'3', N'Servicio 03', N'2')
GO
INSERT [dbo].[Servicio] ([Codigo], [Descripcion], [CodEspecialidad]) VALUES (N'4', N'Servicio 04', N'3')
GO
SET IDENTITY_INSERT [dbo].[SolicitudAtencion] ON 

GO
INSERT [dbo].[SolicitudAtencion] ([Id], [NumSolicitud], [Direccion], [CodServicio], [Sintomas], [FechaSolicitud]) VALUES (2, 1, N'Calle Belen 622', N'1', N'Fiebre, dolor de cabeza, dolor de garganta', CAST(0x0000A5DB00F01862 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[SolicitudAtencion] OFF
GO
INSERT [dbo].[TipoServicio] ([Codigo], [Descripcion]) VALUES (N'1', N'Tipo Servicio 01')
GO
INSERT [dbo].[TipoServicio] ([Codigo], [Descripcion]) VALUES (N'2', N'Tipo Servicio 02')
GO
INSERT [dbo].[TipoServicio] ([Codigo], [Descripcion]) VALUES (N'3', N'Tipo Servicio 03')
GO
ALTER TABLE [dbo].[Especialidad]  WITH CHECK ADD  CONSTRAINT [FK_Especialidad_TipoServicio] FOREIGN KEY([CodTipoServicio])
REFERENCES [dbo].[TipoServicio] ([Codigo])
GO
ALTER TABLE [dbo].[Especialidad] CHECK CONSTRAINT [FK_Especialidad_TipoServicio]
GO
ALTER TABLE [dbo].[Especialista]  WITH CHECK ADD  CONSTRAINT [FK_Especialista_Especialidad] FOREIGN KEY([CodEspecialidad])
REFERENCES [dbo].[Especialidad] ([Codigo])
GO
ALTER TABLE [dbo].[Especialista] CHECK CONSTRAINT [FK_Especialista_Especialidad]
GO
ALTER TABLE [dbo].[Servicio]  WITH CHECK ADD  CONSTRAINT [FK_Servicio_Servicio] FOREIGN KEY([CodEspecialidad])
REFERENCES [dbo].[Especialidad] ([Codigo])
GO
ALTER TABLE [dbo].[Servicio] CHECK CONSTRAINT [FK_Servicio_Servicio]
GO
ALTER TABLE [dbo].[SolicitudAtencion]  WITH CHECK ADD  CONSTRAINT [FK_SolicitudAtencion_Servicio] FOREIGN KEY([CodServicio])
REFERENCES [dbo].[Servicio] ([Codigo])
GO
ALTER TABLE [dbo].[SolicitudAtencion] CHECK CONSTRAINT [FK_SolicitudAtencion_Servicio]

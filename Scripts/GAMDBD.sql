CREATE DATABASE [GAMDBD]
GO
/****** Object:  StoredProcedure [dbo].[AddUser_Notificacion]    Script Date: 12/04/2016 14:14:03 ******/
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
/****** Object:  StoredProcedure [dbo].[AsignarMedico_SolicitudAtencion]    Script Date: 12/04/2016 14:14:03 ******/
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

	UPDATE SolicitudAtencion 
	SET EstadoSolicitud = 2
	WHERE Id = @Id;

	INSERT INTO CitaAtencion
		(SolicitudAtencionId, NumCita, FechaCita, EspecialistaId)
	SELECT Id, @Correlativo, FechaCita, @EspecialistaId
	FROM SolicitudAtencion
	WHERE Id = @Id;

	UPDATE Correlativo SET Valor = @Correlativo
	WHERE Id = 2;
END

GO
/****** Object:  StoredProcedure [dbo].[Get_Especialistas]    Script Date: 12/04/2016 14:14:03 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_UserCliente]    Script Date: 12/04/2016 14:14:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Get_UserCliente]
	@Username nvarchar(50),
	@Password nvarchar(50)
AS    
BEGIN
	SELECT TOP 1
		Id,
		Nombre,
		Apellido,
		Username,
		ISNULL(Celular,'') Celular,
		Estado
	FROM Cliente
	WHERE Username = @Username
		AND [Password] COLLATE Latin1_General_CS_AS = @Password
END

GO
/****** Object:  StoredProcedure [dbo].[GetByUsername_Notificacion]    Script Date: 12/04/2016 14:14:03 ******/
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
/****** Object:  StoredProcedure [dbo].[Insert_SolicitudAtencion]    Script Date: 12/04/2016 14:14:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_SolicitudAtencion]
	@ClienteId int,
	@FechaSolicitud datetime,
	@FechaCita datetime,
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
		SolicitudAtencion (NumSolicitud, ClienteId, Direccion, CodServicio, Sintomas, FechaSolicitud, FechaCita,
			Latitud, Longitud, EstadoSolicitud)
	VALUES 
		(@Correlativo, @ClienteId, @Direccion, @CodServicio, @Sintomas, @FechaSolicitud, @FechaCita, @Latitud, @Longitud, 1);

	SELECT @SolicitudId = SCOPE_IDENTITY();

	UPDATE Correlativo SET Valor = @Correlativo
	WHERE Id = 1;

	SELECT @SolicitudId;
END

GO
/****** Object:  Table [dbo].[CitaAtencion]    Script Date: 12/04/2016 14:14:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CitaAtencion](
	[SolicitudAtencionId] [int] NOT NULL,
	[NumCita] [int] NOT NULL,
	[FechaCita] [datetime] NOT NULL,
	[EspecialistaId] [int] NOT NULL,
 CONSTRAINT [PK_CitaAtencion] PRIMARY KEY CLUSTERED 
(
	[SolicitudAtencionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 12/04/2016 14:14:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Dni] [nvarchar](8) NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Apellido] [nvarchar](100) NOT NULL,
	[Direccion] [nvarchar](100) NULL,
	[FechaNacimiento] [datetime] NULL,
	[Telefono] [nvarchar](10) NULL,
	[Celular] [nvarchar](15) NULL,
	[Email] [nvarchar](100) NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Estado] [int] NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Correlativo]    Script Date: 12/04/2016 14:14:03 ******/
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
/****** Object:  Table [dbo].[Especialidad]    Script Date: 12/04/2016 14:14:03 ******/
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
/****** Object:  Table [dbo].[Especialista]    Script Date: 12/04/2016 14:14:03 ******/
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
	[Calificacion] [int] NULL,
 CONSTRAINT [PK_Especialista] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notificacion]    Script Date: 12/04/2016 14:14:03 ******/
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
/****** Object:  Table [dbo].[Servicio]    Script Date: 12/04/2016 14:14:03 ******/
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
/****** Object:  Table [dbo].[SolicitudAtencion]    Script Date: 12/04/2016 14:14:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolicitudAtencion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NumSolicitud] [int] NOT NULL,
	[ClienteId] [int] NOT NULL,
	[Direccion] [nvarchar](100) NOT NULL,
	[CodServicio] [nvarchar](5) NOT NULL,
	[Sintomas] [nvarchar](max) NOT NULL,
	[FechaSolicitud] [datetime] NULL,
	[EstadoSolicitud] [int] NOT NULL,
	[FechaCita] [datetime] NULL,
	[Latitud] [decimal](18, 6) NULL,
	[Longitud] [decimal](18, 6) NULL,
 CONSTRAINT [PK_SolicitudAtencion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoServicio]    Script Date: 12/04/2016 14:14:03 ******/
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
SET IDENTITY_INSERT [dbo].[Cliente] ON 

GO
INSERT [dbo].[Cliente] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [FechaNacimiento], [Telefono], [Celular], [Email], [Username], [Password], [Estado]) VALUES (1, N'12345678', N'Cliente', N'Cliente Apellido', NULL, NULL, N'012654477', N'997111222', N'cliente01@hotmail.com', N'cliente01@hotmail.com', N'1234', 1)
GO
SET IDENTITY_INSERT [dbo].[Cliente] OFF
GO
INSERT [dbo].[Correlativo] ([Id], [Valor], [Descripcion]) VALUES (1, 4, N'Correlativo para las Solicitudes')
GO
INSERT [dbo].[Correlativo] ([Id], [Valor], [Descripcion]) VALUES (2, 3, N'Correlativo para las Citas')
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
SET IDENTITY_INSERT [dbo].[Especialista] ON 

GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (1, NULL, N'Especilista 01', N'Apellido', N'San Isidro', CAST(-12.098686 AS Decimal(18, 6)), CAST(-77.042952 AS Decimal(18, 6)), N'1', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (2, NULL, N'Especilista 02', N'Apellido', N'San Isidro', CAST(-12.095287 AS Decimal(18, 6)), CAST(-77.037201 AS Decimal(18, 6)), N'1', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (3, NULL, N'Especilista 03', N'Apellido', N'San Isidro', CAST(-12.096378 AS Decimal(18, 6)), CAST(-77.053552 AS Decimal(18, 6)), N'1', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (4, NULL, N'Especilista 04', N'Apellido', N'San Isidro', CAST(-11.958825 AS Decimal(18, 6)), CAST(-77.106201 AS Decimal(18, 6)), N'2', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (5, NULL, N'Especilista 05', N'Apellido', N'San Isidro', CAST(-12.004737 AS Decimal(18, 6)), CAST(-77.093743 AS Decimal(18, 6)), N'1', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (6, NULL, N'Especilista 06', N'Apellido', N'San Isidro', CAST(-11.998105 AS Decimal(18, 6)), CAST(-77.071448 AS Decimal(18, 6)), N'2', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (7, NULL, N'Especilista 07', N'Apellido', N'San Isidro', CAST(-12.041674 AS Decimal(18, 6)), CAST(-77.039690 AS Decimal(18, 6)), N'3', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (8, NULL, N'Especilista 08', N'Apellido', N'San Isidro', CAST(-12.041789 AS Decimal(18, 6)), CAST(-77.048370 AS Decimal(18, 6)), N'1', 1)
GO
INSERT [dbo].[Especialista] ([Id], [Dni], [Nombre], [Apellido], [Direccion], [Latitud], [Longitud], [CodEspecialidad], [Calificacion]) VALUES (9, NULL, N'Especilista 09', N'Apellido', N'San Isidro', CAST(-12.048273 AS Decimal(18, 6)), CAST(-77.049582 AS Decimal(18, 6)), N'3', 1)
GO
SET IDENTITY_INSERT [dbo].[Especialista] OFF
GO
INSERT [dbo].[Servicio] ([Codi], [Descripcion], [CodEspecialidad]) VALUES (N'1', N'Servicio 01', N'1')
GO
INSERT [dbo].[Servicio] ([Codi], [Descripcion], [CodEspecialidad]) VALUES (N'2', N'Servicio 02', N'1')
GO
INSERT [dbo].[Servicio] ([Codi], [Descripcion], [CodEspecialidad]) VALUES (N'3', N'Servicio 03', N'2')
GO
INSERT [dbo].[Servicio] ([Codi], [Descripcion], [CodEspecialidad]) VALUES (N'4', N'Servicio 04', N'3')
GO
INSERT [dbo].[TipoServicio] ([Codi], [Descripcion]) VALUES (N'1', N'Tipo Servicio 01')
GO
INSERT [dbo].[TipoServicio] ([Codi], [Descripcion]) VALUES (N'2', N'Tipo Servicio 02')
GO
INSERT [dbo].[TipoServicio] ([Codi], [Descripcion]) VALUES (N'3', N'Tipo Servicio 03')
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

CREATE PROCEDURE [dbo].[Get_Especialistas]
	@Latitud decimal(18,6),
	@Longitud decimal(18,6),
	@Radio INT -- KM
AS    
BEGIN
	SELECT 
			Nombre,
			Apellido,
			Direccion
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
USE Proyect1;
Go

IF OBJECT_ID('SPEMPLEADO')IS NOT NULL
BEGIN
DROP PROCEDURE SPEMPLEADO;
END;
GO

CREATE PROCEDURE SPEMPLEADO(
@Accion CHAR(100),
@Id_Empleado int =NULL,
@Contrasena varchar(30)=NULL,
@Nombre varchar(30)=NULL,
@Apellido_Paterno varchar(30)=NULL,
@Apellido_Materno varchar(30)=NULL,
@Curp varchar(30)=NULL,
@Fecha_Nacimiento DATE=NULL,
@Email varchar(30)=NULL,
@No_Nomina varchar(30)= NULL,
@Fecha_Ingreso date = NULL
)
AS
BEGIN

DECLARE @HOY SMALLDATETIME;
SET @HOY = GETDATE();

IF @Accion = 'Insert'
BEGIN
 INSERT INTO Empleado(Contrasena,Nombre,Apellido_Paterno,Apellido_Materno,
Curp,Fecha_Nacimiento,Email,No_Nomina,Fecha_Ingreso,Activo,Administrador)
VALUES(@Contrasena, @Nombre, @Apellido_Paterno, @Apellido_Materno,
@Curp, @Fecha_Nacimiento, @Email, @No_Nomina, @Fecha_Ingreso,1,'0');
END;

IF @Accion = 'Actu'
BEGIN
UPDATE Empleado
SET
Contrasena=@Contrasena,
Nombre=@Nombre,
Apellido_Paterno=@Apellido_Paterno,
Apellido_Materno=@Apellido_Materno,
Curp=@Curp,
Fecha_Nacimiento=@Fecha_Nacimiento,
Email=@Email,
No_Nomina=@No_Nomina,
Fecha_Ingreso=@Fecha_Ingreso
WHERE Id_Empleado=@Id_Empleado;
END

 IF @Accion = 'E'
BEGIN
DELETE FROM Empleado WHERE  Id_Empleado = @Id_Empleado;
END;

IF @Accion = 'B'
BEGIN
UPDATE Empleado SET
Activo = 0 WHERE  Id_Empleado = @Id_Empleado;
END;

IF @Accion = 'R'
BEGIN
UPDATE Empleado SET
Activo = 1 WHERE Id_Empleado = @Id_Empleado;
END;


IF @Accion = 'Admini'
BEGIN
SELECT  Nombre, Administrador, Id_Empleado
 FROM Empleado  WHERE Id_Empleado = @Id_Empleado AND Contrasena = @Contrasena;

 END;

 IF @Accion = 'W'
BEGIN
SELECT Id_Empleado, Contrasena, Nombre, Apellido_Paterno,Apellido_Materno, Curp,
 Fecha_Nacimiento, Email,No_Nomina,  Fecha_Ingreso,  Activo
 FROM Empleado 
 END;

  IF @Accion = 'S'
BEGIN
SELECT Id_Empleado, Contrasena, Nombre, Apellido_Paterno,Apellido_Materno, Curp,
 Fecha_Nacimiento, Email,No_Nomina,  Fecha_Ingreso,  Activo
 FROM Empleado
 WHERE Id_Empleado=@Id_Empleado;
 END;
 
END;



 SELECT*FROM Empleado
EXEC SPEMPLEADO 'Insert',NULL,'a','Carlos','Valdes','Hernandez',
'ODLDHG01840','19990709','carlos@gmail.com', 81288,'20200202';
UPDATE Empleado 
SET  Administrador = '1' where Id_Empleado = 1

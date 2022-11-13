USE TERMINAL5;
Go

IF OBJECT_ID('SPEmpleado')IS NOT NULL
BEGIN
DROP PROCEDURE GesEmpleado;
END;
GO

CREATE PROCEDURE GesEmpleado(
@Accion CHAR(1),
@Id_Empleado int =NULL,
@Contrasena varchar=NULL,
@Nombre varchar=NULL,
@Apellido_Paterno varchar(30)=NULL,
@Apellido_Materno varchar(30)=NULL,
@Curp varchar(30)=NULL,
@Fecha_Nacimiento DATE=NULL,
@Email varchar(30)=NULL,
@No_Nomina varchar(30)= NULL,
@Fecha_Ingreso datetime NOT NULL
)
AS
BEGIN

DECLARE @HOY SMALLDATETIME;
SET @HOY = GETDATE();

IF @Accion = 'I'
BEGIN
INSERT INTO Empleado(Contrasena,Nombre,Apellido_Paterno,Apellido_Materno,
Curp,Fecha_Nacimiento,Email,No_Nomina,Fecha_Ingreso,Activo,Administrador)
VALUES(@Contrasena, @Nombre, @Apellido_Materno, @Apellido_Paterno,
@Curp, @Fecha_Nacimiento, @Email, @No_Nomina, @Fecha_Ingreso,'0');
END;

IF @Accion = 'U'
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

 IF @Accion = 'z'
BEGIN
DELETE FROM Empleado WHERE  Id_Empleado = @Id_Empleado;
END;

IF @Accion = 'D'
BEGIN
UPDATE Empleado SET
Activo = 0 WHERE  Id_Empleado = @Id_Empleado;
END;

IF @Accion = 'A'
BEGIN
UPDATE Empleado SET
Activo = 1 WHERE Id_Empleado = @Id_Empleado;
END;


IF @Accion = 'K'
BEGIN
SELECT  Nombre, Administrador, Id_Empleado
 FROM Empleado  WHERE Id_Empleado = @Id_Empleado AND Contrasena = @Contrasena;

 END;


END;


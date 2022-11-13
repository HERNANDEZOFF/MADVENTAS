use TERMINAL5
go

IF OBJECT_ID('SProducto')IS NOT NULL
BEGIN
DROP PROCEDURE GesProducto;
END;
GO

CREATE PROCEDURE GesProducto(
@Accion CHAR(1),
@IdProducto int NOT NULL,
@Descripcion varchar(50) NOT NULL,
@Unidad int NOT NULL,
@Costo money NOT NULL,
@PrecioU money NOT NULL,
@PuntoDeReorden datetime NOT NULL,
@Stock int NOT NULL,
@FechaAlta datetime NOT NULL,
@IdDepartamento int NOT NULL,
@Activo bit NULL
)
AS
BEGIN

DECLARE @HOY SMALLDATETIME;
SET @HOY = GETDATE();

IF @Accion = 'I'
BEGIN
INSERT INTO Productos(Descripcion,Unidad,Costo,PrecioU,PuntoDeReorden,Stock,FechaAlta)
VALUES(@Descripcion, @Unidad, @Costo,@PrecioU,@PuntoDeReorden, @Stock, @FechaAlta);
END;


IF @Accion = 'U'
BEGIN
UPDATE Productos
SET
Descripcion=@Descripcion,
Unidad=@Unidad,
Costo=@Costo,
PrecioU=@PrecioU,
PuntoDeReorden=@PuntoDeReorden,
Fecha_Nacimiento=@Fecha_Nacimiento,
Email=@Email,
No_Nomina=@No_Nomina,
Fecha_Ingreso=@Fecha_Ingreso
WHERE Id_Empleado=@Id_Empleado;
END

END;
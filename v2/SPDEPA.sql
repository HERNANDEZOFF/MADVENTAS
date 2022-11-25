USE Proyect1;
Go

IF OBJECT_ID('SPDEPA')IS NOT NULL
BEGIN
DROP PROCEDURE SPDEPA;
END;
GO

CREATE PROCEDURE SPDEPA(
@IdDepartamento int = NULL,
@Nombre varchar(20)=NULL,
@Activo bit=NULL,
@PermiteDevoluciones bit=NULL,
@IdDescuento int =NULL,
@Accion CHAR(100)
)
AS

BEGIN

IF @Accion='Insert'
BEGIN
	INSERT INTO Departamentos(Nombre,Activo,PermiteDevoluciones,IdDescuento)
	VALUES(@Nombre, @Activo,@PermiteDevoluciones,@IdDescuento)
END

IF @Accion='E'
BEGIN
	SELECT*FROM Departamentos
END

IF @Accion='Actu'
BEGIN
	UPDATE Departamentos
	SET Nombre=@Nombre,Activo=@Activo,PermiteDevoluciones=@PermiteDevoluciones,IdDescuento=@IdDescuento
	WHERE IdDepartamento=@IdDepartamento
END
IF @Accion='D'
	BEGIN
		DELETE FROM Departamentos WHERE IdDepartamento=@IdDepartamento
	END

END
CREATE DATABASE Proyect1;
USE Proyect1



CREATE TABLE Descuentos(
	IdDescuento int IDENTITY(1,1) NOT NULL,
	Nombre Varchar(30) NOT NULL,
	Porcentaje money NOT NULL,
	Fecha1 datetime NOT NULL,
	Fecha2 datetime NOT NULL,
 CONSTRAINT PK_Descuentos 
 PRIMARY KEY (IdDescuento)
) 

CREATE TABLE Empleado(
	Id_Empleado int IDENTITY(1,1) NOT NULL,
	Contrasena varchar(30) NOT NULL,
	Nombre varchar(30) NOT NULL,
	Apellido_Paterno varchar(30) NOT NULL,
	Apellido_Materno varchar(30) NULL,
	Curp varchar(30) NOT NULL,
	Fecha_Nacimiento date NOT NULL,
	Email varchar(30) NOT NULL,
	No_Nomina varchar(30) NOT NULL,
	Fecha_Ingreso datetime NOT NULL,
	Administrador varchar(1) NULL,
	Activo bit NULL,
 CONSTRAINT PK_Empleado 
 PRIMARY KEY CLUSTERED (Id_Empleado)
 ) 

 CREATE TABLE Departamentos(
	IdDepartamento int IDENTITY(1,1) NOT NULL,
	Nombre varchar(20) NOT NULL,
	Activo bit NULL,
	PermiteDevoluciones bit NOT NULL,
	IdDescuento Int NOT NULL,
 CONSTRAINT PK_Departamentos 
 PRIMARY KEY (IdDepartamento), 
 CONSTRAINT FKDescuento FOREIGN KEY (IdDescuento)
 REFERENCES Descuentos(IdDescuento)
) 


CREATE TABLE Medidas(
	IdMedidas int IDENTITY(1,1)NOT NULL,
	MedidaCod varchar(50) NOT NULL,
	Nombre varchar(50) NOT NULL,
	PRIMARY KEY CLUSTERED (IdMedidas),
)

CREATE TABLE Productos(
	IdProducto int IDENTITY(1,1)NOT NULL,
	IdDepartamento int NOT NULL,
	IdDescuento int NOT NULL,
	Unidad int NOT NULL, 
	Nombre varchar(50) NOT NULL,
	Descripcion varchar(50) NOT NULL,
	Costo money NOT NULL,
	PrecioU money NOT NULL,
	PuntoDeReorden decimal NOT NULL,
	Stock decimal NOT NULL,
	FechaAlta datetime NOT NULL,
	Merma decimal NOT NULL,
	Vendidos decimal NOT NULL,
	Activo bit NULL,
 PRIMARY KEY CLUSTERED (IdProducto),
 CONSTRAINT FKDepartamento FOREIGN KEY (IdDepartamento)
 REFERENCES Departamentos (IdDepartamento),
 CONSTRAINT FKDescuentos FOREIGN KEY (IdDescuento) 
 REFERENCES Descuentos (IdDescuento),
 CONSTRAINT FKMedida FOREIGN KEY(Unidad) 
 REFERENCES Medidas (IdMedidas)
) 


CREATE TABLE RegistroAcc(
	IdCambios int IDENTITY(1,1) NOT NULL,
	accion varchar(50) NOT NULL,
	Fecha date NOT NULL,
	IdProducto int NOT NULL,
	IdUser int NOT NULL,
	PRIMARY KEY (IdCambios),
	CONSTRAINT FKProductos FOREIGN KEY(IdProducto) 
	REFERENCES Productos(IdProducto)
)

CREATE TABLE Cajas(
	IdCaja int IDENTITY(1,1) NOT NULL,
	Nombre VARCHAR(50) NOT NULL,
 CONSTRAINT PK_Cajas 
 PRIMARY KEY (IdCaja)
) 

/*ventas*/
CREATE TABLE Ticket(
	IdTicket int IDENTITY(1,1)NOT NULL,
	Id_Empleado int NOT NULL,
	IdCaja int NOT NULL,
	Total money NOT NULL,
	Fecha datetime NOT NULL,
	PaEfectivo decimal NOT NULL,
	PaDebito decimal NOT NULL,
	PaCredito decimal NOT NULL,
	PaCheque decimal NOT NULL,
	PaVales decimal NOT NULL,
 CONSTRAINT PK_Ticket
 PRIMARY KEY (IdTicket),
 CONSTRAINT FK_Empleado FOREIGN KEY (Id_Empleado) 
 REFERENCES Empleado(Id_Empleado),
 CONSTRAINT FK_Caja FOREIGN KEY (IdCaja) REFERENCES Cajas(IdCaja)
 ) 


 /*detalle venta*/
CREATE TABLE Ticket_Productos(
	IdTicket_Pro int NOT NULL,
	IdProducto int NOT NULL,
	IdTicket int NOT NULL,
	Cantidad int NOT NULL,
 CONSTRAINT PK_Ticket_Productos
 PRIMARY KEY (IdTicket_Pro),
CONSTRAINT PK_TicketVenta FOREIGN KEY(IdTicket) REFERENCES Ticket(IdTicket),
CONSTRAINT PK_Producto FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
 ) 

 drop table Descuentos
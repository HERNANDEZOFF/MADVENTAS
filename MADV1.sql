USE TERMINAL1
GO

CREATE TABLE Cajas(
	IdCaja int NOT NULL,
 CONSTRAINT PK_Cajas
 PRIMARY KEY(IdCaja),
 )

CREATE TABLE Credito(
	IdCredito int NOT NULL,
	Saldo money NOT NULL
	CONSTRAINT PK_Credito
	PRIMARY KEY(IdCredito),
)

CREATE TABLE  devolucion_credito(
	IdDevcredit int NOT NULL,
	IdProduc int NOT NULL,
	IdDevolu int NOT NULL,
	IdCredito int NOT NULL,
	saldo money NOT NULL,
	CONSTRAINT PK_devolucion_credito
	PRIMARY KEY (IdDevcredit),
)

CREATE TABLE devolucion_producto(
	IdDev_prod int NOT NULL,
	IdProduc int NOT NULL,
	IdDevolu int NOT NULL,
	Merma bit NOT NULL,
	CONSTRAINT PK_devolucion_credito
	PRIMARY KEY (IdDev_prod),
)

CREATE TABLE BusquedaProc(
	IdBusqueda int NOT NULL,
	 CONSTRAINT PK_BusquedaProc
	 PRIMARY KEY(IdBusqueda),
)

CREATE TABLE Descuentos(
	Porcentaje money NOT NULL,
	Fecha datetime NOT NULL,
	 CONSTRAINT PK_Descuentos
	 PRIMARY KEY(Porcentaje),
)

CREATE TABLE Departamentos(
	IdDepaartamento int NOT NULL,
	Nombre varchar(20) NOT NULL,
	PermiteDevoluciones bit NOT NULL,
 CONSTRAINT PK_Departamentos 
 PRIMARY KEY(IdDepaartamento),
 )

CREATE TABLE Devolucion(
	IdDevoluciones int NOT NULL,
	Producto int NOT NULL,
	Departamento int NOT NULL,
 CONSTRAINT PK_Devoluciones 
 PRIMARY KEY (IdDevoluciones),
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
 CONSTRAINT PK_Empleado 
 PRIMARY KEY (Id_Empleado),
)

CREATE TABLE FormasDePago(
	IdForPago int NOT NULL,
	Nombre varchar(20) NOT NULL,
 CONSTRAINT PK_FormasDePago 
 PRIMARY KEY(IdForPago),
) 

CREATE TABLE Jornadas(
	IdEmpl_Caja int NOT NULL,
	IdEmployee int NOT NULL,
	IdCaja int NOT NULL,
	SesionActiva bit NOT NULL,
	FechaHrInicio datetime NOT NULL,
	FechaHrFinal datetime NOT NULL,
 CONSTRAINT PK_Jornadas 
 PRIMARY KEY (IdEmpl_Caja),
) 

CREATE TABLE Productos(
	IdProducto int NOT NULL,
	Descripcion varchar(50) NOT NULL,
	Unidad int NOT NULL,
	Costo money NOT NULL,
	PrecioU money NOT NULL,
	PuntoDeReorden datetime NOT NULL,
	Stock int NOT NULL,
	FechaAlta datetime NOT NULL,
	IdDepartamento int NOT NULL
) 

CREATE TABLE Ticket(
	IdTicket int NOT NULL,
	Fecha datetime NOT NULL,
	IdCaja int NOT NULL,
	subTotal money NOT NULL,
	IVA money NOT NULL,
	Total money NOT NULL,
 CONSTRAINT PK_Ticket 
 PRIMARY KEY(IdTicket)
) 

CREATE TABLE Ticket_ForPago(
	Id int NOT NULL,
	IdTicket int NOT NULL,
	IdForPago int NOT NULL,
 CONSTRAINT PK_Ticket_ForPago 
 PRIMARY KEY (Id)
) 

CREATE TABLE Ticket_Productos(
	IdTicket_Pro int NOT NULL,
	IdProducto int NOT NULL,
	IdTicket int NOT NULL,
 CONSTRAINT PK_Ticket_Productos 
 PRIMARY KEY(IdTicket_Pro)
) 


ALTER TABLE Departamentos  WITH CHECK ADD  CONSTRAINT FK_Departamentos_Devoluciones FOREIGN KEY(IdDepaartamento)
REFERENCES Devoluciones (IdDevoluciones)
GO
ALTER TABLE Departamentos CHECK CONSTRAINT FK_Departamentos_Devoluciones
GO
ALTER TABLE Jornadas  WITH CHECK ADD  CONSTRAINT FK_Jornadas_Cajas FOREIGN KEY(IdCaja)
REFERENCES Cajas (IdCaja)
GO
ALTER TABLE Jornadas CHECK CONSTRAINT FK_Jornadas_Cajas
GO
ALTER TABLE Jornadas  WITH CHECK ADD  CONSTRAINT FK_Jornadas_Empleado FOREIGN KEY(IdEmployee)
REFERENCES Empleado (Id_Empleado)
GO
ALTER TABLE Jornadas CHECK CONSTRAINT FK_Jornadas_Empleado
GO
ALTER TABLE Productos  WITH CHECK ADD  CONSTRAINT FK_Productos_Departamentos FOREIGN KEY(IdDepartamento)
REFERENCES Departamentos (IdDepaartamento)
GO
ALTER TABLE Productos CHECK CONSTRAINT FK_Productos_Departamentos
GO
ALTER TABLE Productos  WITH CHECK ADD  CONSTRAINT FK_Productos_Ticket_Productos FOREIGN KEY(IdProducto)
REFERENCES Ticket_Productos (IdTicket_Pro)
GO
ALTER TABLE Productos CHECK CONSTRAINT FK_Productos_Ticket_Productos
GO
ALTER TABLE Ticket  WITH CHECK ADD  CONSTRAINT FK_Ticket_Cajas FOREIGN KEY(IdCaja)
REFERENCES Cajas (IdCaja)
GO
ALTER TABLE Ticket CHECK CONSTRAINT FK_Ticket_Cajas
GO
ALTER TABLE Ticket  WITH CHECK ADD  CONSTRAINT FK_Ticket_Devoluciones FOREIGN KEY(IdTicket)
REFERENCES Devoluciones (IdDevoluciones)
GO
ALTER TABLE Ticket CHECK CONSTRAINT FK_Ticket_Devoluciones
GO
ALTER TABLE Ticket_ForPago  WITH CHECK ADD  CONSTRAINT FK_Ticket_ForPago_FormasDePago FOREIGN KEY(IdForPago)
REFERENCES FormasDePago (IdForPago)
GO
ALTER TABLE Ticket_ForPago CHECK CONSTRAINT FK_Ticket_ForPago_FormasDePago
GO
ALTER TABLE Ticket_ForPago  WITH CHECK ADD  CONSTRAINT FK_Ticket_ForPago_Ticket FOREIGN KEY(Id)
REFERENCES Ticket (IdTicket)
GO
ALTER TABLE Ticket_ForPago CHECK CONSTRAINT FK_Ticket_ForPago_Ticket
GO
ALTER TABLE Ticket_Productos  WITH CHECK ADD  CONSTRAINT FK_Ticket_Productos_Ticket FOREIGN KEY(IdTicket)
REFERENCES Ticket (IdTicket)
GO
ALTER TABLE Ticket_Productos CHECK CONSTRAINT FK_Ticket_Productos_Ticket
GO

USE [master]
GO
/****** Object:  Database [STRDB_V1]    Script Date: 23/10/2018 02:59:46 p. m. ******/
CREATE DATABASE [STRDB_V1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'STRDB_V1', FILENAME = N'C:\Users\STRDB_V1.mdf' , SIZE = 7360KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'STRDB_V1_log', FILENAME = N'C:\Users\STRDB_V1_log.LDF' , SIZE = 3904KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [STRDB_V1] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [STRDB_V1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [STRDB_V1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [STRDB_V1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [STRDB_V1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [STRDB_V1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [STRDB_V1] SET ARITHABORT OFF 
GO
ALTER DATABASE [STRDB_V1] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [STRDB_V1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [STRDB_V1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [STRDB_V1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [STRDB_V1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [STRDB_V1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [STRDB_V1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [STRDB_V1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [STRDB_V1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [STRDB_V1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [STRDB_V1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [STRDB_V1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [STRDB_V1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [STRDB_V1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [STRDB_V1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [STRDB_V1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [STRDB_V1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [STRDB_V1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [STRDB_V1] SET  MULTI_USER 
GO
ALTER DATABASE [STRDB_V1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [STRDB_V1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [STRDB_V1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [STRDB_V1] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [STRDB_V1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [STRDB_V1] SET QUERY_STORE = OFF
GO
USE [STRDB_V1]
GO
/****** Object:  Table [dbo].[Agenda]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agenda](
	[IdCita] [int] IDENTITY(100,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Hora] [varchar](5) NULL,
	[IdCliente] [int] NULL,
	[MotivoCita] [varchar](100) NULL,
	[Estado] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Agenda_FechaHora]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Agenda_FechaHora]
as select IdCita, Agenda.Fecha+' '+Agenda.Hora as 'FechaHora' from Agenda
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[IdCliente] [int] IDENTITY(101,1) NOT NULL,
	[ApPaterno] [varchar](40) NULL,
	[ApMaterno] [varchar](40) NULL,
	[Nombre] [varchar](50) NULL,
	[Empresa] [varchar](150) NULL,
	[Tel1] [varchar](15) NULL,
	[Tel2] [varchar](15) NULL,
	[Cel] [varchar](15) NULL,
	[Email] [varchar](50) NULL,
	[Estado] [varchar](20) NULL,
	[Municipio] [varchar](50) NULL,
	[Colonia] [varchar](50) NULL,
	[Calle] [varchar](40) NULL,
	[NumExt] [varchar](6) NULL,
	[NumInt] [varchar](6) NULL,
	[CodPos] [varchar](10) NULL,
	[RFC] [varchar](13) NULL,
	[IdFacturapi] [nchar](30) NULL,
	[RazonSocial] [nchar](180) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[idCodigoClientes]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[idCodigoClientes]
as
select cast(IdCliente as varchar(10)) + '  -  ' + Empresa + '   ' + Nombre + ' ' + ApPaterno + ' ' + ApMaterno as Cliente
from Clientes
GO
/****** Object:  View [dbo].[ClienteID]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ClienteID]
as
select (cast (IdCliente as varchar(9)))+'  -  '+ISNULL(Empresa,'')+'   '+Nombre+' '+ApPaterno +' '+ISNULL(ApMaterno,'') AS Cliente
from Clientes
GO
/****** Object:  Table [dbo].[CategoriaServicio]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriaServicio](
	[IdCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Categoria] [varchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ColoniasCP]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ColoniasCP](
	[d_codigo] [nvarchar](255) NULL,
	[d_asenta] [nvarchar](255) NULL,
	[d_tipo_asenta] [nvarchar](255) NULL,
	[D_mnpio] [nvarchar](255) NULL,
	[d_estado] [nvarchar](255) NULL,
	[d_ciudad] [nvarchar](255) NULL,
	[d_CP] [nvarchar](255) NULL,
	[c_estado] [nvarchar](255) NULL,
	[c_oficina] [nvarchar](255) NULL,
	[c_CP] [nvarchar](255) NULL,
	[c_tipo_asenta] [nvarchar](255) NULL,
	[c_mnpio] [nvarchar](255) NULL,
	[id_asenta_cpcons] [nvarchar](255) NULL,
	[d_zona] [nvarchar](255) NULL,
	[c_cve_ciudad] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Compras]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Compras](
	[IdCompras] [int] IDENTITY(1000,1) NOT NULL,
	[IdProveedor] [int] NULL,
	[Fecha] [varchar](10) NULL,
	[Producto] [varchar](30) NULL,
	[Cantidad] [varchar](5) NULL,
	[Unidad] [varchar](4) NULL,
	[PrecioUNI] [float] NULL,
	[Importe] [float] NULL,
	[IVA] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCompras] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cotizaciones]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cotizaciones](
	[IdCotizacion] [int] IDENTITY(1001,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[IdCliente] [int] NULL,
	[Subtotal] [money] NULL,
	[IVA] [money] NULL,
	[IVARet] [money] NULL,
	[TOTAL] [money] NULL,
	[Ubicacion] [varchar](180) NULL,
	[Categoria] [varchar](20) NULL,
	[Subcategoria] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados](
	[IdEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[ApPaterno] [varchar](30) NULL,
	[ApMaterno] [varchar](30) NULL,
	[Nombre] [varchar](50) NULL,
	[Puesto] [varchar](30) NULL,
	[Tel] [varchar](15) NULL,
	[Cel] [varchar](15) NULL,
	[Email] [varchar](40) NULL,
	[Estado] [varchar](20) NULL,
	[Municipio] [varchar](20) NULL,
	[Colonia] [varchar](20) NULL,
	[Calle] [varchar](30) NULL,
	[NumExt] [varchar](5) NULL,
	[NumInt] [varchar](5) NULL,
	[CodPos] [varchar](10) NULL,
	[RFC] [varchar](13) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facturas](
	[Folio] [int] IDENTITY(101,1) NOT NULL,
	[IdCliente] [int] NULL,
	[FechaEMISION] [datetime] NULL,
	[MetodoPAGO] [varchar](30) NULL,
	[SubTotal] [money] NULL,
	[Descuento] [money] NULL,
	[IVA] [money] NULL,
	[Total] [money] NULL,
	[Ubicacion] [varchar](250) NULL,
	[Estado] [varchar](20) NULL,
	[Categoria] [varchar](20) NULL,
	[Subcategoria] [varchar](20) NULL,
	[FolioFiscal] [varchar](40) NULL,
	[Series] [varchar](2) NULL,
	[IdFacturapi] [varchar](50) NULL,
	[EstadoPago] [varchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[Folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gastos]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gastos](
	[IdGasto] [int] IDENTITY(1,1) NOT NULL,
	[NombreGasto] [varchar](15) NULL,
	[FechaVEN] [varchar](10) NULL,
	[DiasRES] [varchar](2) NULL,
	[CostoMEN] [float] NULL,
	[CostoDIA] [float] NULL,
	[CostoSem] [float] NULL,
	[MontoPAG] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdGasto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingresos]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingresos](
	[IdIngresos] [int] IDENTITY(1,1) NOT NULL,
	[FechaING] [varchar](10) NULL,
	[IdCliente] [int] NULL,
	[IdServiciosRealizados] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdIngresos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 23/10/2018 02:59:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[IdProveedor] [int] IDENTITY(100,1) NOT NULL,
	[ApPaterno] [varchar](30) NULL,
	[ApMaterno] [varchar](30) NULL,
	[Nombre] [varchar](50) NULL,
	[Empresa] [varchar](150) NULL,
	[Tel1] [varchar](15) NULL,
	[Tel2] [varchar](15) NULL,
	[Cel] [varchar](15) NULL,
	[Email] [varchar](40) NULL,
	[Estado] [varchar](20) NULL,
	[Municipio] [varchar](50) NULL,
	[Colonia] [varchar](20) NULL,
	[Calle] [varchar](30) NULL,
	[NumExt] [varchar](5) NULL,
	[NumInt] [varchar](5) NULL,
	[CodPos] [varchar](10) NULL,
	[RFC] [varchar](13) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportesServicio]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportesServicio](
	[IdReporte] [int] IDENTITY(101,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[IdCliente] [int] NULL,
	[Descripcion] [varchar](700) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdReporte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiciosRealizados]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiciosRealizados](
	[IdServiciosRealizados] [int] IDENTITY(1,1) NOT NULL,
	[FechaInicio] [varchar](10) NULL,
	[FechaTermino] [varchar](10) NULL,
	[IdCliente] [int] NULL,
	[TOTAL] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdServiciosRealizados] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubCategoria]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubCategoria](
	[IdSubCategoria] [int] IDENTITY(1,1) NOT NULL,
	[SubCategoria] [varchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdSubCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trabajos_Cotizaciones]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trabajos_Cotizaciones](
	[IdTrabajoCotizacion] [int] IDENTITY(1,1) NOT NULL,
	[IdCotizacion] [int] NULL,
	[Partida] [int] NULL,
	[Descripcion] [varchar](470) NOT NULL,
	[Cantidad] [float] NULL,
	[PrecioUnitario] [money] NULL,
	[Importe] [money] NULL,
	[Unidad] [varchar](5) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTrabajoCotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trabajos_Facturas]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trabajos_Facturas](
	[IdTrabajoFactura] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](270) NULL,
	[Cantidad] [int] NULL,
	[PrecioUnitario] [money] NULL,
	[Importe] [money] NULL,
	[Unidad] [varchar](5) NULL,
	[Folio] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTrabajoFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trabajos_SerRealizados]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trabajos_SerRealizados](
	[IdTrabajoServicio] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Cantidad] [int] NULL,
	[PrecioUnitario] [float] NULL,
	[Importe] [float] NULL,
	[IdCategoria] [int] NULL,
	[IdSubCategoria] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTrabajoServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] NOT NULL,
	[ApPaterno] [varchar](30) NULL,
	[ApMaterno] [varchar](30) NULL,
	[Nombre] [varchar](50) NULL,
	[Contra] [varchar](20) NULL,
	[Tipo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarCotizacion]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ActualizarCotizacion]

@date datetime, @subtotal money, @iva money, @ivaret money, @total money,
@path varchar(180), @cat varchar(20), @subcat varchar(30), @idcoti int
AS
UPDATE [STRDB_V1].[dbo].[Cotizaciones]
   SET [Fecha] = @date
      ,[Subtotal] = @subtotal
      ,[IVA] = @iva
      ,[IVARet] = @ivaret
      ,[TOTAL] = @total
      ,[Ubicacion] = @path
      ,[Categoria] = @cat
      ,[Subcategoria] = @subcat
 WHERE IdCotizacion=@idcoti
GO
/****** Object:  StoredProcedure [dbo].[ActualizarTrabajosCoti]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ActualizarTrabajosCoti]
@idcot int,@item int,@descripcion varchar(250), @cant float, @unitprice money, @importe money,
@unidad varchar(5)

AS
UPDATE [STRDB_V1].[dbo].[Trabajos_Cotizaciones]
   SET [IdCotizacion] = @idcot
      ,[Partida] = @item
      ,[Descripcion] = @descripcion
      ,[Cantidad] = @cant
      ,[PrecioUnitario] = @unitprice
      ,[Importe] = @importe
      ,[Unidad] = @unidad
 WHERE IdCotizacion=@idcot
GO
/****** Object:  StoredProcedure [dbo].[AddFactura]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON 
GO
CREATE procedure [dbo].[AddFactura]

           @IdCliente int
           ,@FechaEMISION datetime
           ,@MetodoPAGO varchar(30)
           ,@SubTotal money
           ,@Descuento money
           ,@IVA money
           ,@Total money
           ,@Ubicacion varchar(250)
           ,@Estado varchar(20)
           ,@Categoria varchar(20)
           ,@Subcategoria varchar(20)
           ,@FolioFiscal varchar(40)
           ,@Series varchar(2)
           ,@IdFacturapi varchar(50)
           ,@EstadoPago varchar(25)

as

INSERT INTO [STRDB_V1].[dbo].[Facturas]
           ([IdCliente]
           ,[FechaEMISION]
           ,[MetodoPAGO]
           ,[SubTotal]
           ,[Descuento]
           ,[IVA]
           ,[Total]
           ,[Ubicacion]
           ,[Estado]
           ,[Categoria]
           ,[Subcategoria]
           ,[FolioFiscal]
           ,[Series]
           ,[IdFacturapi]
           ,[EstadoPago])
     VALUES
           (
           @IdCliente
           ,@FechaEMISION
           ,@MetodoPAGO
           ,@SubTotal
           ,@Descuento
           ,@IVA
           ,@Total
           ,@Ubicacion
           ,@Estado
           ,@Categoria
           ,@Subcategoria
           ,@FolioFiscal 
           ,@Series
           ,@IdFacturapi
           ,@EstadoPago)

GO
/****** Object:  StoredProcedure [dbo].[AddTrabajosFactura]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddTrabajosFactura]

@Descripcion varchar(270)
           ,@Cantidad int
           ,@PrecioUnitario money
           ,@Importe money
           ,@Unidad varchar(5)
           ,@Folio int
           
           as

INSERT INTO [STRDB_V1].[dbo].[Trabajos_Facturas]
           ([Descripcion]
           ,[Cantidad]
           ,[PrecioUnitario]
           ,[Importe]
           ,[Unidad]
           ,[Folio])
     VALUES
           (@Descripcion
           ,@Cantidad
           ,@PrecioUnitario
           ,@Importe
           ,@Unidad
           ,@Folio)
GO
/****** Object:  StoredProcedure [dbo].[AgregarCotizacion]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AgregarCotizacion]

@date datetime, @idclient int, @subtotal money, @iva money, @ivaret money, @total money,
@path varchar(180), @cat varchar(20), @subcat varchar(30)


AS


INSERT INTO [STRDB_V1].[dbo].[Cotizaciones]
           ([Fecha]
           ,[IdCliente]
           ,[Subtotal]
           ,[IVA]
           ,[IVARet]
           ,[TOTAL]
           ,[Ubicacion]
           ,[Categoria]
           ,[Subcategoria])
     VALUES(@date
           ,@idclient
           ,@subtotal
           ,@iva
           ,@ivaret
           ,@total
           ,@path
           ,@cat
           ,@subcat)



GO
/****** Object:  StoredProcedure [dbo].[AgregarTrabajosCotizacion]    Script Date: 23/10/2018 02:59:47 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AgregarTrabajosCotizacion]
@idcot int,@item int,@descripcion varchar(250), @cant float, @unitprice money, @importe money,
@unidad varchar(5)
as
INSERT INTO [STRDB_V1].[dbo].[Trabajos_Cotizaciones]
           ([IdCotizacion]
           ,[Partida]
           ,[Descripcion]
           ,[Cantidad]
           ,[PrecioUnitario]
           ,[Importe]
           ,[Unidad])
     VALUES(@idcot
           ,@item
           ,@descripcion
           ,@cant
           ,@unitprice
           ,@importe
           ,@unidad)
GO
USE [master]
GO
ALTER DATABASE [STRDB_V1] SET  READ_WRITE 
GO

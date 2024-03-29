USE [master]
GO
/****** Object:  Database [Practica1]    Script Date: 16/9/2023 17:43:10 ******/
CREATE DATABASE [Practica1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Practica1', FILENAME = N'C:\SQLData\MSSQL16.SQLEXPRESS\MSSQL\DATA\Practica1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Practica1_log', FILENAME = N'C:\SQLData\MSSQL16.SQLEXPRESS\MSSQL\DATA\Practica1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Practica1] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Practica1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Practica1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Practica1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Practica1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Practica1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Practica1] SET ARITHABORT OFF 
GO
ALTER DATABASE [Practica1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Practica1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Practica1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Practica1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Practica1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Practica1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Practica1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Practica1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Practica1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Practica1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Practica1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Practica1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Practica1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Practica1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Practica1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Practica1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Practica1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Practica1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Practica1] SET  MULTI_USER 
GO
ALTER DATABASE [Practica1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Practica1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Practica1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Practica1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Practica1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Practica1] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Practica1] SET QUERY_STORE = ON
GO
ALTER DATABASE [Practica1] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Practica1]
GO
/****** Object:  User [steeven]    Script Date: 16/9/2023 17:43:10 ******/
CREATE USER [steeven] FOR LOGIN [steeven] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[compra]    Script Date: 16/9/2023 17:43:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[compra](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DescripcionCompra] [varchar](100) NULL,
	[ValorCompra] [decimal](10, 2) MASKED WITH (FUNCTION = 'default()') NULL,
	[TipoPago] [varchar](50) MASKED WITH (FUNCTION = 'default()') NULL,
	[FechaCompra] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 16/9/2023 17:43:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [varchar](50) NULL,
	[Contrasena] [varchar](50) NULL,
	[Email] [varchar](100) NULL,
	[FechaCreacion] [date] MASKED WITH (FUNCTION = 'datetime("Y")') NULL,
	[Edad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[compra] ON 

INSERT [dbo].[compra] ([ID], [DescripcionCompra], [ValorCompra], [TipoPago], [FechaCompra]) VALUES (1, N'Teléfono móvil', CAST(299.99 AS Decimal(10, 2)), N'Tarjeta de crédito', CAST(N'2023-01-01' AS Date))
INSERT [dbo].[compra] ([ID], [DescripcionCompra], [ValorCompra], [TipoPago], [FechaCompra]) VALUES (2, N'Laptop', CAST(1150.99 AS Decimal(10, 2)), N'Tarjeta de crédito', CAST(N'2023-02-05' AS Date))
INSERT [dbo].[compra] ([ID], [DescripcionCompra], [ValorCompra], [TipoPago], [FechaCompra]) VALUES (3, N'Smart TV', CAST(599.99 AS Decimal(10, 2)), N'Efectivo', CAST(N'2023-03-10' AS Date))
INSERT [dbo].[compra] ([ID], [DescripcionCompra], [ValorCompra], [TipoPago], [FechaCompra]) VALUES (4, N'Tablet', CAST(320.99 AS Decimal(10, 2)), N'Efectivo', CAST(N'2023-04-15' AS Date))
INSERT [dbo].[compra] ([ID], [DescripcionCompra], [ValorCompra], [TipoPago], [FechaCompra]) VALUES (5, N'CPU', CAST(899.99 AS Decimal(10, 2)), N'Tarjeta de débito', CAST(N'2023-05-20' AS Date))
SET IDENTITY_INSERT [dbo].[compra] OFF
GO
SET IDENTITY_INSERT [dbo].[usuario] ON 

INSERT [dbo].[usuario] ([ID], [NombreUsuario], [Contrasena], [Email], [FechaCreacion], [Edad]) VALUES (1, N'Sergio Ramirez', N'srg1990', N'sergio@gmail.com', CAST(N'2023-01-01' AS Date), 33)
INSERT [dbo].[usuario] ([ID], [NombreUsuario], [Contrasena], [Email], [FechaCreacion], [Edad]) VALUES (2, N'Santiago Cabrera', N'1998SC', N'santicab@gmail.com', CAST(N'2023-02-05' AS Date), 25)
INSERT [dbo].[usuario] ([ID], [NombreUsuario], [Contrasena], [Email], [FechaCreacion], [Edad]) VALUES (3, N'Maria Lopez', N'febrero2000', N'mariaL@gmail.com', CAST(N'2023-03-10' AS Date), 23)
INSERT [dbo].[usuario] ([ID], [NombreUsuario], [Contrasena], [Email], [FechaCreacion], [Edad]) VALUES (4, N'Gabriel Proaño', N'elgabo24', N'gaboPV@gmail.com', CAST(N'2023-04-15' AS Date), 30)
INSERT [dbo].[usuario] ([ID], [NombreUsuario], [Contrasena], [Email], [FechaCreacion], [Edad]) VALUES (5, N'Sofía Rodriguez', N'sofia15', N'rodriguez@gmail.com', CAST(N'2023-05-20' AS Date), 25)
SET IDENTITY_INSERT [dbo].[usuario] OFF
GO
/****** Object:  StoredProcedure [dbo].[EnmascararColumna]    Script Date: 16/9/2023 17:43:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EnmascararColumna]
  @nombreTabla NVARCHAR(100),
  @nombreColumna NVARCHAR(100),
  @opcionEnmascaramiento INT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @sql NVARCHAR(MAX);

  IF @opcionEnmascaramiento = 1
  BEGIN
    -- Lógica para enmascarar la columna según la opción 1 (Default)
	SET @sql = 'ALTER TABLE ' + QUOTENAME(@nombreTabla) + ' ALTER COLUMN ' + QUOTENAME(@nombreColumna) + ' ADD MASKED WITH (FUNCTION = ''default()'')';
  END
  ELSE IF @opcionEnmascaramiento = 2
  BEGIN
    -- Lógica para enmascarar la columna según la opción 2 (email)
    SET @sql = 'ALTER TABLE ' + QUOTENAME(@nombreTabla) + ' ALTER COLUMN ' + QUOTENAME(@nombreColumna) + ' ADD MASKED WITH (FUNCTION = ''email()'')';
  END
  ELSE IF @opcionEnmascaramiento = 3
  BEGIN
    -- Lógica para enmascarar la columna según la opción 3 (random)
    SET @sql = 'ALTER TABLE ' + QUOTENAME(@nombreTabla) + ' ALTER COLUMN ' + QUOTENAME(@nombreColumna) + ' ADD MASKED WITH (FUNCTION = ''random(1,50)'')';
  END
  ELSE IF @opcionEnmascaramiento = 4
  BEGIN
    -- Lógica para enmascarar la columna según la opción 4 (partial)
    SET @sql = 'ALTER TABLE ' + QUOTENAME(@nombreTabla) + ' ALTER COLUMN ' + QUOTENAME(@nombreColumna) + ' ADD MASKED WITH (FUNCTION = ''partial(1, "XXXXXXX", 1)'')';
  END
  ELSE IF @opcionEnmascaramiento = 5
  BEGIN
    -- Lógica para desenmascarar la columna según la opción 5 
    SET @sql = 'ALTER TABLE ' + QUOTENAME(@nombreTabla) + ' ALTER COLUMN ' + QUOTENAME(@nombreColumna) + ' DROP MASKED';
  END
  ELSE IF @opcionEnmascaramiento = 6
  BEGIN
  -- Lógica para enmascarar la columna como fecha
  SET @sql = 'ALTER TABLE ' + QUOTENAME(@nombreTabla) + ' ALTER COLUMN ' + QUOTENAME(@nombreColumna) + ' ADD MASKED WITH (FUNCTION = ''datetime("Y")'')';
  END

  
  -- Agrega más bloques IF/ELSEIF según las opciones de enmascaramiento que necesites

  -- Ejecutar la consulta dinámica
  EXEC sp_executesql @sql;
  
END

GO
USE [master]
GO
ALTER DATABASE [Practica1] SET  READ_WRITE 
GO

USE [master]
GO
/****** Object:  Database [Practica]    Script Date: 14/9/2023 22:43:29 ******/
CREATE DATABASE [Practica]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Práctica', FILENAME = N'C:\SQLData\MSSQL16.SQLEXPRESS\MSSQL\DATA\Práctica.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Práctica_log', FILENAME = N'C:\SQLData\MSSQL16.SQLEXPRESS\MSSQL\DATA\Práctica_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Practica] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Practica].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Practica] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Practica] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Practica] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Practica] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Practica] SET ARITHABORT OFF 
GO
ALTER DATABASE [Practica] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Practica] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Practica] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Practica] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Practica] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Practica] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Practica] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Practica] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Practica] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Practica] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Practica] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Practica] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Practica] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Practica] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Practica] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Practica] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Practica] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Practica] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Practica] SET  MULTI_USER 
GO
ALTER DATABASE [Practica] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Practica] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Practica] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Practica] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Practica] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Practica] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Practica] SET QUERY_STORE = ON
GO
ALTER DATABASE [Practica] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Practica]
GO
/****** Object:  User [steevenSP]    Script Date: 14/9/2023 22:43:29 ******/
CREATE USER [steevenSP] FOR LOGIN [steeven] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [steeven1]    Script Date: 14/9/2023 22:43:29 ******/
CREATE USER [steeven1] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [steeven]    Script Date: 14/9/2023 22:43:29 ******/
CREATE USER [steeven] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [002]    Script Date: 14/9/2023 22:43:29 ******/
CREATE USER [002] FOR LOGIN [002] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [001]    Script Date: 14/9/2023 22:43:29 ******/
CREATE USER [001] FOR LOGIN [001] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[SeguridadFila]    Script Date: 14/9/2023 22:43:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SeguridadFila] (@CodigoJefe VARCHAR(50))
RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN SELECT 1 AS Resultado
        WHERE @CodigoJefe  = USER_NAME() OR USER_NAME() = 'dbo';
GO
/****** Object:  UserDefinedFunction [dbo].[SeguridadfilaOrdenes]    Script Date: 14/9/2023 22:43:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SeguridadfilaOrdenes] (@ProcesadoPor VARCHAR(100))
RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN SELECT 1 AS Resultado
        WHERE @ProcesadoPor = USER_NAME() OR USER_NAME() = 'dbo';
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 14/9/2023 22:43:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[nombreUsuario] [varchar](50) NOT NULL,
	[contraseña] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[contraseñaEncriptByKey] [varbinary](100) NULL,
	[contraseñaEncriptByPassphrase] [varbinary](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ventas]    Script Date: 14/9/2023 22:43:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ventas](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[numero_orden] [varchar](50) NULL,
	[nombre_producto] [varchar](100) NULL,
	[monto_venta] [decimal](10, 2) NULL,
	[vendedor] [varchar](50) NULL,
	[fecha_pedido] [date] NULL,
	[sucursal] [varchar](50) NULL,
	[CodigoJefe] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  SecurityPolicy [dbo].[SeguridadFilas]    Script Date: 14/9/2023 22:43:29 ******/
CREATE SECURITY POLICY [dbo].[SeguridadFilas] 
ADD FILTER PREDICATE [dbo].[SeguridadFila]([CodigoJefe]) ON [dbo].[ventas]
WITH (STATE = ON, SCHEMABINDING = ON)
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([ID], [nombreUsuario], [contraseña], [email], [contraseñaEncriptByKey], [contraseñaEncriptByPassphrase]) VALUES (1, N'juan_perez', N'juanP123', N'juan.perez@gmail.com', 0x0096529851C396458829989AF62A7D980200000030DEC02C072082517CC2ACD3CB4629BB5ADCBD90CBFD0866A92E1CC7D3DA3B65E8C1C5880FE50B43978B9B818079D573, 0x02000000EBE6E47DCA77141F94F0928FE3C13130CA95AB440568EABC56E9D705B5F4A22BD5DEDCA227250295D1295F054EE79D26)
INSERT [dbo].[Usuario] ([ID], [nombreUsuario], [contraseña], [email], [contraseñaEncriptByKey], [contraseñaEncriptByPassphrase]) VALUES (2, N'maria_gomez', N'claveMG', N'maria.gomez@gmail.com', 0x0096529851C396458829989AF62A7D9802000000FF20353F7B25D18DDA545829DE8E99B57ADA411474040140DD0437A38A026CDD, 0x02000000C9BA04C0F84364B253059E5F6C8AB875D3F14249261C6ADC97AB7FBAE89D8F41)
INSERT [dbo].[Usuario] ([ID], [nombreUsuario], [contraseña], [email], [contraseñaEncriptByKey], [contraseñaEncriptByPassphrase]) VALUES (3, N'pedro_rodriguez', N'passwordPD', N'pedro.rodriguez@gmail.com', 0x0096529851C396458829989AF62A7D9802000000B91F50E68BC41DBF54A2319D69F7A751DEED88227E537F1795290E8B945F64F35BEF6399D148D00B2203B7B0F1CE6457, 0x02000000867186FE333F9ADBBCDAA9550AD62D68078EBBB37861619DF4353D6C2D768772F7E9B007501CD6FE1F1BA1C342F9B6A5)
INSERT [dbo].[Usuario] ([ID], [nombreUsuario], [contraseña], [email], [contraseñaEncriptByKey], [contraseñaEncriptByPassphrase]) VALUES (4, N'laura_martinez', N'lauraM', N'laura.martinez@gmail.com', 0x0096529851C396458829989AF62A7D980200000056175A79AAC39CD5FD34ED86D03450F28311756A35D47E87AB864AEEB4B69153, 0x0200000021202B22A8A121E4CB8D53E57E16C6467BDE45F583F5705850A961D43EBA74E6)
INSERT [dbo].[Usuario] ([ID], [nombreUsuario], [contraseña], [email], [contraseñaEncriptByKey], [contraseñaEncriptByPassphrase]) VALUES (5, N'carlos_sanchez', N'contraseña123', N'carlos.sanchez@gmail.com', 0x0096529851C396458829989AF62A7D98020000000186C631955D4B5D2F92883002D9FE4EEBCE53F62D8C453ACC3560B1E983B90229CC592FDF491BA2A2A9E12E0C8F3687, 0x02000000DAAC11BAF278A09A6009B711ABC2BEBEF1C48D779ABDB9330DF8215DD0334A6D19BB3E7878CF903ED841D62EAE9179D9)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET IDENTITY_INSERT [dbo].[ventas] ON 

INSERT [dbo].[ventas] ([ID], [numero_orden], [nombre_producto], [monto_venta], [vendedor], [fecha_pedido], [sucursal], [CodigoJefe]) VALUES (4, N'ORD-004', N'Tablet', CAST(360.00 AS Decimal(10, 2)), N'Laura Torres', CAST(N'2023-06-04' AS Date), N'Sucursal 1', N'001')
INSERT [dbo].[ventas] ([ID], [numero_orden], [nombre_producto], [monto_venta], [vendedor], [fecha_pedido], [sucursal], [CodigoJefe]) VALUES (5, N'ORD-005', N'Cámara fotográfica', CAST(175.90 AS Decimal(10, 2)), N'Pedro Gómez', CAST(N'2023-06-05' AS Date), N'Sucursal 2', N'002')
INSERT [dbo].[ventas] ([ID], [numero_orden], [nombre_producto], [monto_venta], [vendedor], [fecha_pedido], [sucursal], [CodigoJefe]) VALUES (6, N'ORD-006', N'Smartphone', CAST(355.00 AS Decimal(10, 2)), N'Sofía Ramírez', CAST(N'2023-06-05' AS Date), N'Sucursal 1', N'001')
INSERT [dbo].[ventas] ([ID], [numero_orden], [nombre_producto], [monto_venta], [vendedor], [fecha_pedido], [sucursal], [CodigoJefe]) VALUES (7, N'ORD-007', N'Impresora', CAST(200.00 AS Decimal(10, 2)), N'Eduardo Torres', CAST(N'2023-06-15' AS Date), N'Sucursal 2', N'002')
INSERT [dbo].[ventas] ([ID], [numero_orden], [nombre_producto], [monto_venta], [vendedor], [fecha_pedido], [sucursal], [CodigoJefe]) VALUES (8, N'ORD-008', N'Auriculares inalámbricos', CAST(60.99 AS Decimal(10, 2)), N'María López', CAST(N'2023-06-07' AS Date), N'Sucursal 2', N'002')
INSERT [dbo].[ventas] ([ID], [numero_orden], [nombre_producto], [monto_venta], [vendedor], [fecha_pedido], [sucursal], [CodigoJefe]) VALUES (9, N'ORD-009', N'Monitor', CAST(250.00 AS Decimal(10, 2)), N'Carlos García', CAST(N'2023-06-10' AS Date), N'Sucursal 1', N'001')
INSERT [dbo].[ventas] ([ID], [numero_orden], [nombre_producto], [monto_venta], [vendedor], [fecha_pedido], [sucursal], [CodigoJefe]) VALUES (10, N'ORD-010', N'Teclado y mouse', CAST(45.50 AS Decimal(10, 2)), N'Eduardo Torres', CAST(N'2023-06-10' AS Date), N'Sucursal 2', N'002')
INSERT [dbo].[ventas] ([ID], [numero_orden], [nombre_producto], [monto_venta], [vendedor], [fecha_pedido], [sucursal], [CodigoJefe]) VALUES (19, N'ORD-020', N'Teléfono móvil', CAST(1500.00 AS Decimal(10, 2)), N'Juan Pérez', CAST(N'2023-07-01' AS Date), N'Sucursal 1', N'001')
INSERT [dbo].[ventas] ([ID], [numero_orden], [nombre_producto], [monto_venta], [vendedor], [fecha_pedido], [sucursal], [CodigoJefe]) VALUES (20, N'ORD-019', N'Camara', CAST(255.00 AS Decimal(10, 2)), N'Maria Salas', CAST(N'2023-07-30' AS Date), N'Sucursal 2', N'002')
SET IDENTITY_INSERT [dbo].[ventas] OFF
GO
/****** Object:  StoredProcedure [dbo].[DesenmascararCodigo]    Script Date: 14/9/2023 22:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Crear el procedimiento almacenado
CREATE PROCEDURE [dbo].[DesenmascararCodigo]
AS
BEGIN
    SET NOCOUNT ON;

    -- Desenmascarar la columna 'codigo' con DROP MASKED
    ALTER TABLE Usuario
		ALTER COLUMN Código DROP MASKED
END;
GO
/****** Object:  StoredProcedure [dbo].[EncriptacionContraseñas]    Script Date: 14/9/2023 22:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EncriptacionContraseñas]
    @metodoEncriptacion INT
AS
BEGIN
    -- Verificar si existe la Master Key
    IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'Clave1')
    BEGIN
        CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'ClaveSegura';
    END

    -- Verificar si existe el Certificate
    IF NOT EXISTS (SELECT * FROM sys.certificates WHERE name = 'Certificado')
    BEGIN
        CREATE CERTIFICATE Certificado WITH SUBJECT = 'Proteccion Datos';
    END

	-- Declarar variable para consulta dinámica
    DECLARE @sql NVARCHAR(MAX);

    -- Elegir el método de encriptación
    IF @metodoEncriptacion = 1
    BEGIN
        IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'Clave1')
        BEGIN
            CREATE SYMMETRIC KEY Clave1 WITH ALGORITHM = AES_128 ENCRYPTION BY CERTIFICATE Certificado;
        END

        -- Abrir clave simétrica
        OPEN SYMMETRIC KEY Clave1 DECRYPTION BY CERTIFICATE Certificado;

        -- Ver la tabla con el campo encriptado
        SET @sql = 'SELECT ID, nombreUsuario, CONVERT(varbinary, EncryptByKey(Key_GUID(''Clave1''), contraseña)) AS Contraseña, email FROM Usuario;'

        -- Cerrar clave simétrica
        CLOSE SYMMETRIC KEY Clave1;
    END
    ELSE IF @metodoEncriptacion = 2
    BEGIN
        --Ver la tabla con el campo encriptado
        SET @sql = 'SELECT ID, nombreUsuario, CONVERT(varbinary,  ENCRYPTBYPASSPHRASE(''clave12345678912'', contraseña)) AS Contraseña from Usuario;'
    END

	-- Ejecutar la consulta dinámica
    EXEC sp_executesql @sql;

    
END;

GO
/****** Object:  StoredProcedure [dbo].[EnmascararCodigo]    Script Date: 14/9/2023 22:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Crear el procedimiento almacenado
CREATE PROCEDURE [dbo].[EnmascararCodigo]
AS
BEGIN
    SET NOCOUNT ON;

    -- Enmascarar la columna 'codigo' con MASKED WITH FUNCTION
    ALTER TABLE Usuario
		ALTER COLUMN Código VARCHAR(50) MASKED WITH (FUNCTION = 'default()') 
END;
GO
/****** Object:  StoredProcedure [dbo].[EnmascararColumna]    Script Date: 14/9/2023 22:43:30 ******/
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
ALTER DATABASE [Practica] SET  READ_WRITE 
GO

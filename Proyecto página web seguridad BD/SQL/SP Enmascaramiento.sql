CREATE PROCEDURE EnmascararColumna
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



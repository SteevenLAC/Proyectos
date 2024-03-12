CREATE FUNCTION dbo.SeguridadFila (@CodigoJefe VARCHAR(50))
RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN SELECT 1 AS Resultado
        WHERE @CodigoJefe  = USER_NAME() OR USER_NAME() = 'dbo';
GO



-- Asociar la función de filtro de fila a la política de seguridad
CREATE SECURITY POLICY SeguridadFilas
ADD FILTER PREDICATE dbo.SeguridadFila(CodigoJefe)
ON dbo.ventas
WITH (STATE = OFF);   -- Inicia apagada , si la quiero usar pongo On para prenderla
GO

EXECUTE AS USER = '001';
SELECT * FROM ventas;
GO

REVERT




ALTER SECURITY POLICY SeguridadFilas
WITH (STATE = ON);
go

ALTER SECURITY POLICY SeguridadFilas
WITH (STATE = OFF);
go



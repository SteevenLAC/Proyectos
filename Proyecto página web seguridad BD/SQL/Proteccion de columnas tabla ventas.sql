GRANT SELECT ON ventas(ID, numero_orden, nombre_producto, monto_venta, fecha_pedido, sucursal, CodigoJefe) TO [001];
GRANT SELECT ON ventas(ID, numero_orden, nombre_producto, monto_venta, fecha_pedido, sucursal, CodigoJefe) TO [002];

GO
REVOKE SELECT ON ventas(ID, numero_orden, nombre_producto, monto_venta, fecha_pedido, sucursal, CodigoJefe) TO [001];
REVOKE SELECT ON ventas(ID, numero_orden, nombre_producto, monto_venta, fecha_pedido, sucursal, CodigoJefe) TO [002];

GO

GRANT SELECT ON ventas TO [001];
GRANT SELECT ON ventas TO [002];
GO

REVOKE SELECT ON ventas TO [001];
REVOKE SELECT ON ventas TO [002];
GO

EXECUTE AS USER = '001';
SELECT * FROM ventas;

REVERT
GO


SELECT ID, numero_orden, nombre_producto, monto_venta, fecha_pedido, sucursal, CodigoJefe FROM ventas

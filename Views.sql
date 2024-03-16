USE computecno;

CREATE VIEW vista_venta_cliente AS
SELECT v.cant_vendida, v.precio, v.fecha_registro,
       c.nombre AS NombreCliente, c.apellido, c.dir AS Direccion, c.cuit
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente;

CREATE VIEW vw_stock_producto AS 
SELECT s.id_producto, s.cantidad_en_stock, s.fecha_actualizacion,
	p.nombre AS nombre_producto, p.precio
FROM stock s
INNER JOIN producto p ON p.id_producto = s.id_producto;

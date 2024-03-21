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


CREATE VIEW vw_facturacion AS 
SELECT f.id_factura, f.id_pedido, f.id_cliente, f.id_producto,
c.nombre AS NombreCliente, c.apellido, c.dir AS Direccion
FROM facturacion f
INNER JOIN clientes c ON c.id_cliente = f.id_cliente;

CREATE VIEW vw_compra_producto AS
SELECT c.id_producto, c.cantidad_compra, c.fecha_compra,
p.nombre AS NombreProducto, p.precio AS PrecioProducto
FROM compras c
INNER JOIN producto p ON p.id_producto = c.id_producto;
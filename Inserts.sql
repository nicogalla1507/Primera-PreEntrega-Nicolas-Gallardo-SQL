USE computecno;

INSERT INTO proveedor(nombre_proveedor, localidad, numero) VALUES
('SOMOS COMPUTACION','Ramos Mejia',1134357545),
('AsusArgentina','CABA',1134398723);

INSERT INTO producto(nombre,precio,id_proveedor) VALUES
('RTX 3060Ti', 641766,1),
('RTX 4070', 1500000, 2);

INSERT INTO clientes(id_cliente,nombre, apellido, email, dir,localidad, telefono, cuit, fecha_registro) VALUES
(1,'Jose','Perez','joseperez@gmail.com','Balcarce150','Chivilcoy',1134357545,1021020201,'2024-02-25'),
(2,'María', 'González', 'mariagonzalez@example.com', 'Av. Rivadavia 123', 'Buenos Aires', 1134567890, 2030405060, '2024-02-25');

INSERT INTO compras(id_producto,cantidad_compra,fecha_compra) VALUES
(1,3,NOW());

INSERT INTO pedidos(id_producto,id_cliente,cantidad_pedido,fecha_pedido,estado_pedido) VALUES
(1,1,2,NOW(),'f');


-- llamo al procedure para actualizar el stock ya que despues de registrar producto nuevo. en la tabla stock (el campo cantidad_en_stock) se asigna por default en 0
CALL sp_actualizar_stock(1,2);



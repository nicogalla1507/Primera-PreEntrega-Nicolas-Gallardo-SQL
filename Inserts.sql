USE computecno;

INSERT INTO fabricante(nombre_fabricante, localidad) VALUES
('Gigabyte','Ramos Mejia'),
('Asus','CABA');

INSERT INTO producto(nombre,precio,id_fabricante) VALUES
('RTX 3060Ti', 641766,1),
('RTX 4070', 1500000, 2);

INSERT INTO clientes(id_cliente,nombre, apellido, email, dir,localidad, telefono, cuit, fecha_registro) VALUES
(1,'Jose','Perez','joseperez@gmail.com','Balcarce150','Chivilcoy',1134357545,1021020201,'2024-02-25'),
(2,'María', 'González', 'mariagonzalez@example.com', 'Av. Rivadavia 123', 'Buenos Aires', 1134567890, 2030405060, '2024-02-25');


-- llamo al procedure para actualizar el stock ya que despues de registrar producto nuevo. en la tabla stock (el campo cantidad_en_stock) se asigna por default en 0
CALL sp_actualizar_stock(1,2);

INSERT INTO venta (id_cliente,id_producto,cant_vendida,precio,fecha_registro) VALUES
(1,1,1,1400000,'2024-02-25');


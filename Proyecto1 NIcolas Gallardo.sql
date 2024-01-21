-- Aca le dejo como fui armando el script

CREATE SCHEMA computecno; -- primero creo el schema 

USE computecno;  -- luego lo uso por default

CREATE TABLE producto(
	id_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- creo una primary key auto increment para que a medida que ingresen productos nuevos 
    nombre VARCHAR(80) NOT NULL,
    precio FLOAT NOT NULL,
    id_fabricante INT
);

SELECT * FROM producto;

DESCRIBE producto;

ALTER TABLE producto
ADD CONSTRAINT fk_id_fabricante
FOREIGN KEY (id_fabricante)
REFERENCES fabricante(id_fabricante);

INSERT INTO producto(nombre,precio,id_fabricante) 
VALUES ('RTX 3060 Ti', 400000,1),('RTX 3070 Ti',800000,1),('Monitor Gigabyte 27',238000,1);

CREATE TABLE fabricante(
	id_fabricante INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_fabricante VARCHAR(80) NOT NULL,
    localidad VARCHAR (80) NOT NULL
);

CREATE TABLE stock(
	id_stock INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_producto INT NOT NULL ,
    cant_compra INT,
    cant_venta INT,
    fecha_movimiento DATE
);

ALTER TABLE stock 
ADD CONSTRAINT fk_id_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto);

SELECT * FROM stock;

CREATE VIEW stock_vista AS 
SELECT s.id_stock, s.id_producto, s.cant_compra, s.cant_venta, s.fecha_movimiento,
p.nombre as NombreProducto, p.precio, p.id_fabricante
FROM stock s
INNER JOIN producto p ON s.id_producto = p.id_producto; 


CREATE TABLE venta(
	id_venta INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_cliente INT,
    id_producto INT,
    cant INT,
    precio FLOAT,
    total_venta FLOAT,
    fecha_registro DATE
);

ALTER TABLE venta 
ADD CONSTRAINT fk_id_cod_prod
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto);

SELECT * FROM venta;
DESCRIBE venta;
INSERT INTO venta(id_cliente,id_producto,cant,precio,total_venta,fecha_registro)
VALUES (1,2,2,800000,750000,'2024-01-20');

CREATE TABLE clientes(
	id_cliente INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    dir VARCHAR (100) NOT NULL,
    localidad VARCHAR (80),
    telefono INT,
    cuit INT NOT NULL,
    fecha_registro DATE NOT NULL
);

ALTER TABLE clientes
MODIFY id_cliente INT PRIMARY KEY NOT NULL;

SELECT * FROM clientes;
DESCRIBE clientes;
INSERT INTO clientes (id_cliente, nombre, dir, localidad,telefono,cuit,fecha_registro)
VALUES (1, 'Pedro Peralta','Venezuela 130','San Justo', 44438585,01-120578110,'2024-01-19');

UPDATE clientes
SET cuit = '1-112057811-0'
WHERE id_cliente = 1;

ALTER TABLE clientes
MODIFY COLUMN cuit VARCHAR(13) NOT NULL;

ALTER TABLE venta
ADD CONSTRAINT fk_id_cliente
FOREIGN KEY (id_cliente)
REFERENCES clientes(id_cliente);


SELECT * FROM fabricante;

INSERT INTO fabricante(nombre_fabricante,localidad) 
VALUES ('Gigabyte', 'CABA'), ('Asus', 'Ramos Mejia');
SELECT * FROM producto;

INSERT INTO producto(nombre,precio,id_fabricante) 
VALUES ('RTX 3060 Ti','400000',1);


SELECT f.nombre_fabricante, p.nombre AS NombreProducto, p.precio -- aca quise hacer una prueba haciendo un JOIN para ver si la foreign key estaba bien
FROM fabricante f
JOIN producto p ON f.id_fabricante = p.id_fabricante
WHERE p.id_fabricante = 1;


SELECT * FROM stock;
INSERT INTO stock(id_producto, cant_compra, fecha_movimiento)
VALUES (1, 2,'2024-1-16');


ALTER TABLE stock
MODIFY COLUMN cant_venta INT NOT NULL;

ALTER TABLE stock
MODIFY COLUMN cant_compra INT NOT NULL;

SELECT SUM(cant_compra - cant_venta) AS stock
FROM stock
WHERE id_producto = 1;

-- creacion de indice sobre id_producto
CREATE UNIQUE INDEX indice_prod ON producto(id_producto);

-- CREACION DE VISTA PARA AGILIZAR LA CONSULTA ENTRE LAS DOS TABLAS 

CREATE VIEW vista_fabricante_producto AS 
SELECT p.nombre,p.id_fabricante, p.precio, p.id_producto, f.nombre_fabricante
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id_fabricante;

SELECT * FROM vista_fabricante_producto;


UPDATE producto 
SET id_fabricante = 2
WHERE nombre LIKE 'Monitor Gigabyte 27';

SELECT * FROM venta;

SELECT * FROM clientes;

-- OTRA CREACION DE VISTA PARA AGILIZAR LA BUSQUEDA DE LAS VENTAS Y EL NOMBRE DEL CLIENTE

CREATE VIEW vista_venta_cliente AS
SELECT v.cant, v.precio, v.total_venta, v.fecha_registro,
c.nombre AS NombreCLiente, c.dir AS Direccion, c.cuit
FROM venta v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente;

SELECT * FROM vista_venta_cliente;

SELECT * FROM stock_vista;

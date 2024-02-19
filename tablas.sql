CREATE SCHEMA computecno; -- primero creo el schema 

USE computecno;  -- luego lo uso por default

CREATE TABLE producto(
	id_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- creo una primary key auto increment para que a medida que ingresen productos nuevos 
    nombre VARCHAR(80) NOT NULL,
    precio FLOAT NOT NULL,
    id_fabricante INT
);





CREATE TABLE fabricante(				-- una tabla fabricante para poder registrar los distintos fabricantes con los que computecno trabaja
	id_fabricante INT PRIMARY KEY AUTO_INCREMENT NOT NULL,		
    nombre_fabricante VARCHAR(80) NOT NULL,
    localidad VARCHAR (80) NOT NULL
);

CREATE TABLE stock(
	id_stock INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_producto INT NOT NULL ,
    cantidad_en_stock INT NOT NULL,
    fecha_actualizacion DATE
);




CREATE TABLE venta(
	id_venta INT PRIMARY KEY AUTO_INCREMENT NOT NULL,		-- PRIMARY KEY AUTO_INCREMENT NOT NULL, para que el programa autoincremente de forma ascendente a medida que se generen nuevas ventas
    id_cliente INT,
    id_producto INT,
    cant_vendida INT,
    precio FLOAT,
    fecha_registro DATE
);




CREATE TABLE clientes(						-- tabla clientes para poder registrar los distintos clientes que compraron en COMPUTECNO
	id_cliente INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    email VARCHAR(100) NOT NULL,
    dir VARCHAR (100) NOT NULL,
    localidad VARCHAR (80),
    telefono INT,
    cuit INT NOT NULL,
    fecha_registro DATE NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT fk_id_fabricante
FOREIGN KEY (id_fabricante)
REFERENCES fabricante(id_fabricante)
ON DELETE CASCADE;


ALTER TABLE venta ADD CONSTRAINT fk_venta
FOREIGN KEY (id_cliente)
REFERENCES clientes(id_cliente)
ON DELETE CASCADE;

ALTER TABLE venta     				-- otra FOREIGN KEY para poder relacionar el campo ID_PRODUCTO de la tabla VENTA y el campo ID_PRODUCTO de la tabla PRODUCTO. 
ADD CONSTRAINT fk_id_cod_prod		
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto)
ON DELETE CASCADE;

ALTER TABLE stock ADD CONSTRAINT fk_cliente
FOREIGN KEY (id_producto)
REFERENCES producto (id_producto)
ON DELETE CASCADE;

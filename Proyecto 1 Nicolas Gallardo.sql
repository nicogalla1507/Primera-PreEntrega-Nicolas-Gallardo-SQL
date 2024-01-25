CREATE SCHEMA computecno; -- primero creo el schema 

USE computecno;  -- luego lo uso por default

CREATE TABLE producto(
	id_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- creo una primary key auto increment para que a medida que ingresen productos nuevos 
    nombre VARCHAR(80) NOT NULL,
    precio FLOAT NOT NULL,
    id_fabricante INT
);


ALTER TABLE producto 				-- altero la tabla PRODUCTO para agregar una foreign key que se relaciona con la tabla fabricante(id_fabricante) para posteriormente poder relacionar los productos con su correspondiente fabricante mediante su id
ADD CONSTRAINT fk_id_fabricante
FOREIGN KEY (id_fabricante)
REFERENCES fabricante(id_fabricante);



CREATE TABLE fabricante(				-- una tabla fabricante para poder registrar los distintos fabricantes con los que computecno trabaja
	id_fabricante INT PRIMARY KEY AUTO_INCREMENT NOT NULL,		
    nombre_fabricante VARCHAR(80) NOT NULL,
    numero INT NOT NULL,
    localidad VARCHAR (80) NOT NULL
);

CREATE TABLE stock(
	id_stock INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_producto INT NOT NULL ,
    cant_compra INT,
    cant_venta INT,
    fecha_movimiento DATE
);

ALTER TABLE stock 					-- agregue otra foreign key sobre la tabla STOCK para poder relacionar el ID_PRODUCTO de la tabla PRODUCTO. (Para posteriores consultas)
ADD CONSTRAINT fk_id_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto);


CREATE TABLE venta(
	id_venta INT PRIMARY KEY AUTO_INCREMENT NOT NULL,		-- PRIMARY KEY AUTO_INCREMENT NOT NULL, para que el programa autoincremente de forma ascendente a medida que se generen nuevas ventas
    id_cliente INT,
    id_producto INT,
    cant INT,
    precio FLOAT,
    total_venta FLOAT,
    fecha_registro DATE
);

ALTER TABLE venta     				-- otra FOREIGN KEY para poder relacionar el campo ID_PRODUCTO de la tabla VENTA y el campo ID_PRODUCTO de la tabla PRODUCTO. 
ADD CONSTRAINT fk_id_cod_prod		
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto);


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

ALTER TABLE venta		-- FOREIGN KEY sobre el campo ID_CLIENTE en la tabla venta que referencia al campo ID_CLIENTE de la tabla CLIENTES
ADD CONSTRAINT fk_id_cliente
FOREIGN KEY (id_cliente)
REFERENCES clientes(id_cliente);

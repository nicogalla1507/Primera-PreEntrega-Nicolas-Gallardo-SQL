CREATE SCHEMA computecno; -- primero creo el schema 

USE computecno;  -- luego lo uso por default

CREATE TABLE producto(
	id_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL, -- creo una primary key auto increment para que a medida que ingresen productos nuevos 
    nombre VARCHAR(80) NOT NULL,
    precio FLOAT NOT NULL,
    id_proveedor INT
);





CREATE TABLE proveedor(				-- una tabla proveedor para poder registrar los distintos proveedores con los que computecno trabaja
	id_proveedor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,		
    nombre_proveedor VARCHAR(80) NOT NULL,
    localidad VARCHAR (80) NOT NULL,
    numero INT NOT NULL
);

CREATE TABLE stock(
	id_stock INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_producto INT NOT NULL ,
    cantidad_en_stock INT NOT NULL,
    fecha_actualizacion DATE
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


CREATE TABLE historial_precios(
	id_historial INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_producto INT NOT NULL,
    fecha_actualizacion TIMESTAMP NOT NULL,
    precio_anterior FLOAT NOT NULL,
    precio_nuevo FLOAT NOT NULL,
    FOREIGN KEY(id_producto) REFERENCES producto(id_producto)
    );


CREATE TABLE compras(
	id_compra INT PRIMARY KEY auto_increment NOT NULL,
    id_producto INT NOT NULL,
    cantidad_compra INT NOT NULL,
    fecha_compra TIMESTAMP NOT NULL,
    FOREIGN KEY(id_producto) REFERENCES producto(id_producto)
    ON DELETE CASCADE
    );
    

CREATE TABLE pedidos(
	id_pedido INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_producto INT NOT NULL,
    id_cliente INT NOT NULL,
    cantidad_pedido INT NOT NULL,
    fecha_pedido TIMESTAMP NOT NULL,
    estado_pedido CHAR NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
    ON DELETE CASCADE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
    ON DELETE CASCADE
    );
    
    
CREATE TABLE ventas(
	id_venta INT PRIMARY KEY AUTO_INCREMENT NOT NULL,		-- PRIMARY KEY AUTO_INCREMENT NOT NULL, para que el programa autoincremente de forma ascendente a medida que se generen nuevas ventas
    id_cliente INT,
    id_pedido INT NOT NULL,
    id_producto INT,
    cant_vendida INT,
    precio FLOAT,
    fecha_registro DATE,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

CREATE TABLE facturacion(
	id_factura INT PRIMARY KEY auto_increment NOT NULL,
    id_pedido INT NOT NULL,
    id_cliente INT NOT NULL,
    id_producto INT,
    precio FLOAT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);



ALTER TABLE producto ADD CONSTRAINT fk_id_proveedor
FOREIGN KEY (id_proveedor)
REFERENCES proveedor(id_proveedor)
ON DELETE CASCADE;


ALTER TABLE ventas ADD CONSTRAINT fk_venta
FOREIGN KEY (id_cliente)
REFERENCES clientes(id_cliente)
ON DELETE CASCADE;

ALTER TABLE ventas     				-- otra FOREIGN KEY para poder relacionar el campo ID_PRODUCTO de la tabla VENTA y el campo ID_PRODUCTO de la tabla PRODUCTO. 
ADD CONSTRAINT fk_id_cod_prod		
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto)
ON DELETE CASCADE;

ALTER TABLE stock ADD CONSTRAINT fk_cliente
FOREIGN KEY (id_producto)
REFERENCES producto (id_producto)
ON DELETE CASCADE;

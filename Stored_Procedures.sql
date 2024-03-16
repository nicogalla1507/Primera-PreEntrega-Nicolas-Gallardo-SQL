-- creacion de stored procedures

-- un stored procedure para registrar ventas
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_venta`(
    IN p_id_producto INT,
    IN p_id_cliente INT,
    IN p_cantidad_vendida INT,
    IN p_precio FLOAT
)
BEGIN
    -- Insertar la nueva venta en la tabla con la fecha actual
    INSERT INTO ventas (id_producto, id_cliente, cant_vendida, precio, fecha_registro)
    VALUES (p_id_producto, p_id_cliente, p_cantidad_vendida, p_precio, NOW());

    -- Actualizar el stock después de la venta
    UPDATE stock
    SET cantidad_en_stock = cantidad_en_stock - p_cantidad_vendida
    WHERE id_producto = p_id_producto;
END;
//
DELIMITER ;

-- otro para actualizar precios 
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_precios`(IN p_id_producto INT, IN p_porcentaje_cambio FLOAT)
BEGIN
    DECLARE precio_viejo FLOAT;

    -- Obtener el precio anterior del producto
    SELECT precio INTO precio_viejo
    FROM producto 
    WHERE id_producto = p_id_producto;

    -- Actualizar el precio del producto
    UPDATE producto
    SET precio = precio_viejo * (1 + p_porcentaje_cambio / 100)
    WHERE id_producto = p_id_producto;

    -- Insertar un registro en el historial de precios
    INSERT INTO historial_precios (id_producto, fecha_actualizacion, precio_anterior, precio_nuevo)
    VALUES (p_id_producto, NOW(), precio_viejo, precio_viejo * (1 + p_porcentaje_cambio / 100));
END
//
DELIMITER ;

-- Stored Procedure para bajar precios
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_bajar_precios`(IN p_porcentaje_bajada FLOAT)
BEGIN
    DECLARE precio_viejo FLOAT;

    -- Obtener el precio anterior del producto
    SELECT precio INTO precio_viejo
    FROM producto 
    WHERE id_producto = p_id_producto;

    -- Actualizar el precio del producto
    UPDATE producto
    SET precio = precio_viejo * (1 - p_porcentaje_bajada / 100)
    WHERE id_producto = p_id_producto;

    -- Insertar un registro en el historial de precios
    INSERT INTO historial_precios (id_producto, fecha_actualizacion, precio_anterior, precio_nuevo)
    VALUES (p_id_producto, NOW(), precio_viejo, precio_viejo * (1 - p_porcentaje_bajada / 100));
END
//
DELIMITER ;




-- Otro para actualizar el stock pasando por parametro el id_producto, y la cantidad
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_stock`(IN p_id INT, IN p_cantidad INT)
BEGIN
	DECLARE stock_existente INT; 
    DECLARE nueva_cantidad INT;
    
    SELECT COUNT(*) INTO stock_existente FROM stock WHERE id_producto = p_id;
    
    
    IF stock_existente > 0 THEN 
    
		UPDATE stock 
		SET cantidad_en_stock = cantidad_en_stock + p_cantidad,
		fecha_actualizacion = CURRENT_TIMESTAMP
		WHERE id_producto = p_id;
	ELSE
    
		INSERT INTO stock (id_producto, cantidad_en_stock, fecha_actualizacion)
        VALUES (p_id, p_cantidad, CURRENT_TIMESTAMP);
        
	END IF;
END;
//
DELIMITER ;

-- otro para registrar nuevos productos
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_nuevo_producto`(IN nombre_producto VARCHAR(80), IN precio_producto FLOAT, IN id_fabricante_producto INT)
BEGIN
	INSERT INTO producto(nombre, precio, id_fabricante) VALUES
    (nombre_producto, precio_producto, id_fabricante_producto);
END;
//

DELIMITER ;

-- otro para registrar ventas y por cada venta baja la cantidad de producto que tengo en la tabla stock
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_venta`(
    IN p_id_producto INT,
    IN p_id_cliente INT,
    IN p_cantidad_vendida INT,
    IN p_precio FLOAT
)
BEGIN
    -- Insertar la nueva venta en la tabla con la fecha actual
    INSERT INTO ventas (id_producto, id_cliente, cant_vendida, precio, fecha_registro)
    VALUES (p_id_producto, p_id_cliente, p_cantidad_vendida, p_precio, CURRENT_TIMESTAMP);

    -- Actualizar el stock después de la venta
    UPDATE stock
    SET cantidad_en_stock = cantidad_en_stock - p_cantidad_vendida
    WHERE id_producto = p_id_producto;
END;
//
DELIMITER ;





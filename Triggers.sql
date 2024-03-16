DELIMITER //

CREATE TRIGGER tg_venta_stock
AFTER INSERT ON ventas
FOR EACH ROW 
BEGIN 
    DECLARE nueva_cantidad INT;

    -- Calcular la nueva cantidad de stock
    SET nueva_cantidad = (SELECT cantidad_en_stock - NEW.cant_vendida FROM stock WHERE id_producto = NEW.id_producto);

    -- Verificar si la nueva cantidad sería negativa
    IF nueva_cantidad < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '¡Alerta! No hay suficiente stock para realizar esta venta.';
    ELSE
        -- Restar la cantidad vendida del stock
        UPDATE stock
        SET cantidad_en_stock = nueva_cantidad
        WHERE id_producto = NEW.id_producto;
    END IF;
END;
//

DELIMITER ;

DELIMITER //
CREATE TRIGGER tg_producto_stock
AFTER INSERT ON producto
FOR EACH ROW 
BEGIN 
    -- Añadir la cantidad de stock del nuevo producto
    INSERT INTO stock (id_producto, cantidad_en_stock, fecha_actualizacion)
    VALUES (NEW.id_producto, 0, CURRENT_TIMESTAMP);
END;
//
DELIMITER ;

DELIMITER //

CREATE TRIGGER tg_historial_precios
AFTER INSERT ON producto
FOR EACH ROW 
BEGIN 
    DECLARE precio_viejo FLOAT;
    
    -- Obtener el precio anterior del producto (si existe)
    SELECT precio_nuevo INTO precio_viejo
    FROM historial_precios
    WHERE id_producto = NEW.id_producto
    ORDER BY fecha_actualizacion DESC
    LIMIT 1;

    -- Si no hay precio anterior registrado, establecerlo como el precio actual
    IF precio_viejo IS NULL THEN
        SET precio_viejo = NEW.precio;
    END IF;
    
    -- Insertar un nuevo registro en el historial de precios
    INSERT INTO historial_precios (id_producto, fecha_actualizacion, precio_anterior, precio_nuevo)
    VALUES (NEW.id_producto, NOW(), precio_viejo, NEW.precio);
END//

DELIMITER ;
    






    
    
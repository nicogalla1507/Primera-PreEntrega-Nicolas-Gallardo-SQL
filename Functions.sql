DELIMITER // 

CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_stock`(id_stock INT) RETURNS float
    DETERMINISTIC
BEGIN
    DECLARE total_productos FLOAT;
    
    SELECT SUM(p.precio * s.cantidad_en_stock) INTO total_productos
    FROM producto p
    JOIN stock s ON p.id_producto = s.id_producto
    WHERE s.id_stock = id_stock;
    
    IF total_productos IS NULL THEN 
        RETURN NULL; -- Devolver un valor nulo si no se puede calcular el stock
    ELSE
        RETURN total_productos;
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_ventas`(id_producto INT) RETURNS float
    DETERMINISTIC
BEGIN
    DECLARE total FLOAT;
    
    -- Inicializar total
    SET total = 0;
    
    -- Calcular total de ventas del producto
    SELECT SUM(p.precio * v.cant_vendida) INTO total
    FROM producto p
    JOIN ventas v ON p.id_producto = v.id_producto
    WHERE p.id_producto = id_producto;
    
    -- Retornar total de ventas
    RETURN total;
END;
//
DELIMITER ;




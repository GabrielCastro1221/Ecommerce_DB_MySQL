USE petshop;

DELIMITER / /

CREATE FUNCTION fn_ingresos_totales()
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(15, 2);
    SELECT IFNULL(SUM(quantity * price), 0) INTO total FROM ticket_products;
    RETURN total;
END;
//

CREATE FUNCTION fn_mayor_venta()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE max_amount DECIMAL(10,2);
    SELECT IFNULL(MAX(amount), 0) INTO max_amount FROM tickets_online;
    RETURN max_amount;
END;
//

CREATE FUNCTION fn_menor_venta()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE min_amount DECIMAL(10,2);
    SELECT IFNULL(MIN(amount), 0) INTO min_amount FROM tickets_online;
    RETURN min_amount;
END;
//

CREATE FUNCTION fn_numero_clientes()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT purchaser_id) INTO total FROM tickets_online;
    RETURN total;
END;
//

CREATE FUNCTION fn_numero_ventas()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM tickets_online WHERE status = 'pagado';
    RETURN total;
END;
//

CREATE FUNCTION fn_promedio_ventas()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT IFNULL(AVG(amount), 0) INTO promedio FROM tickets_online WHERE status = 'pagado';
    RETURN promedio;
END;
//

DELIMITER;

SELECT fn_ingresos_totales () AS total_ingresos;

SELECT fn_mayor_venta () AS mayor_venta;

SELECT fn_menor_venta () AS menor_venta;

SELECT fn_numero_clientes () AS total_clientes;

SELECT fn_numero_ventas () AS total_ventas;

SELECT fn_promedio_ventas () AS promedio_ventas;
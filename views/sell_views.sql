USE petshop;

CREATE OR REPLACE VIEW vw_resumen_ventas_productos AS
SELECT
    p.id AS producto_id,
    p.title AS nombre_producto,
    SUM(tp.quantity) AS cantidad_total_vendida,
    SUM(tp.quantity * tp.price) AS ingreso_total
FROM
    ticket_products tp
    JOIN products p ON p.id = tp.product_id
GROUP BY
    p.id,
    p.title;

CREATE OR REPLACE VIEW vw_ingresos_por_tipo_tienda AS
SELECT tp.store_type AS tipo_tienda, SUM(tp.quantity * tp.price) AS ingreso_total
FROM ticket_products tp
GROUP BY
    tp.store_type;

CREATE OR REPLACE VIEW vw_rango_ventas_productos AS
SELECT
    MAX(sub.total_vendido) AS maximo_producto_vendido,
    MIN(sub.total_vendido) AS minimo_producto_vendido
FROM (
        SELECT product_id, SUM(quantity) AS total_vendido
        FROM ticket_products
        GROUP BY
            product_id
    ) AS sub;

CREATE OR REPLACE VIEW vw_compras_por_usuario AS
SELECT
    u.id AS usuario_id,
    CONCAT(u.name, ' ', u.last_name) AS nombre_completo,
    COUNT(DISTINCT t.id) AS total_tickets,
    SUM(tp.quantity) AS productos_comprados,
    SUM(tp.quantity * tp.price) AS total_gastado
FROM
    users u
    JOIN tickets_online t ON t.purchaser_id = u.id
    JOIN ticket_products tp ON tp.ticket_id = t.id
GROUP BY
    u.id,
    nombre_completo;

SELECT * FROM vw_resumen_ventas_productos;

SELECT * FROM vw_ingresos_por_tipo_tienda;

SELECT * FROM vw_rango_ventas_productos;

SELECT * FROM vw_compras_por_usuario;
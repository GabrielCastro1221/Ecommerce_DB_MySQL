USE petshop;

CREATE OR REPLACE VIEW vw_top_productos_mas_vendidos AS
SELECT tp.product_id, p.title, SUM(tp.quantity) AS total_vendido
FROM
    ticket_products tp
    JOIN products p ON p.id = tp.product_id
GROUP BY
    tp.product_id,
    p.title
ORDER BY total_vendido DESC
LIMIT 10;

CREATE OR REPLACE VIEW vw_productos_menos_vendidos AS
SELECT tp.product_id, p.title, SUM(tp.quantity) AS total_vendido
FROM
    ticket_products tp
    JOIN products p ON p.id = tp.product_id
GROUP BY
    tp.product_id,
    p.title
ORDER BY total_vendido ASC
LIMIT 10;

CREATE OR REPLACE VIEW vw_destacados_top_ventas AS
SELECT p.id, p.title, SUM(tp.quantity) AS total_vendido
FROM
    ticket_products tp
    JOIN products p ON p.id = tp.product_id
WHERE
    p.type_product = 'destacado'
GROUP BY
    p.id,
    p.title
ORDER BY total_vendido DESC;

CREATE OR REPLACE VIEW vw_inventario_actual AS
SELECT
    id AS product_id,
    title,
    stock,
    CASE
        WHEN stock = 0 THEN 'Agotado'
        WHEN stock < 10 THEN 'Bajo'
        ELSE 'Disponible'
    END AS estado_stock
FROM products;

CREATE OR REPLACE VIEW vw_productos_mayor_oferta AS
SELECT
    id AS product_id,
    title,
    price,
    offer_percentage,
    ROUND(
        price * (1 - offer_percentage / 100),
        2
    ) AS precio_oferta
FROM products
WHERE
    offer_percentage > 0
ORDER BY offer_percentage DESC;

CREATE OR REPLACE VIEW vw_productos_por_categoria AS
SELECT
    category,
    COUNT(*) AS total_productos,
    SUM(stock) AS stock_total
FROM products
GROUP BY
    category
ORDER BY total_productos DESC;

CREATE OR REPLACE VIEW vw_productos_sin_ventas AS
SELECT p.id, p.title, p.stock
FROM
    products p
    LEFT JOIN ticket_products tp ON p.id = tp.product_id
WHERE
    tp.product_id IS NULL;

CREATE OR REPLACE VIEW vw_top_ventas_por_tipo AS
SELECT p.type_product, p.title, SUM(tp.quantity) AS total_vendido
FROM
    ticket_products tp
    JOIN products p ON p.id = tp.product_id
GROUP BY
    p.type_product,
    p.title
ORDER BY p.type_product, total_vendido DESC;

CREATE OR REPLACE VIEW vw_productos_top_recaudacion AS
SELECT tp.product_id, p.title, SUM(tp.quantity * tp.price) AS total_recaudado
FROM
    ticket_products tp
    JOIN products p ON p.id = tp.product_id
GROUP BY
    tp.product_id,
    p.title
ORDER BY total_recaudado DESC;

CREATE OR REPLACE VIEW vw_productos_multicliente AS
SELECT tp.product_id, p.title, COUNT(DISTINCT t.purchaser_id) AS clientes_distintos
FROM
    ticket_products tp
    JOIN products p ON p.id = tp.product_id
    JOIN tickets_online t ON t.id = tp.ticket_id
GROUP BY
    tp.product_id,
    p.title
HAVING
    clientes_distintos > 1
ORDER BY clientes_distintos DESC;

SELECT * FROM vw_top_productos_mas_vendidos;

SELECT * FROM vw_productos_menos_vendidos;

SELECT * FROM vw_destacados_top_ventas;

SELECT * FROM vw_inventario_actual;

SELECT * FROM vw_productos_mayor_oferta;

SELECT * FROM vw_productos_por_categoria;

SELECT * FROM vw_productos_sin_ventas;

SELECT * FROM vw_top_ventas_por_tipo;

SELECT * FROM vw_productos_top_recaudacion;

SELECT * FROM vw_productos_multicliente;
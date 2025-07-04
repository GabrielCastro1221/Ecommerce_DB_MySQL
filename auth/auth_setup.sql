USE petshop;

CREATE USER IF NOT EXISTS 'admin_petshop' @'%' IDENTIFIED BY 'AdminSeguro123!';

GRANT ALL PRIVILEGES ON petshop.* TO 'admin_petshop' @'%';

CREATE USER IF NOT EXISTS 'vendedor_petshop' @'%' IDENTIFIED BY 'Vendedor123!';

GRANT
SELECT,
INSERT
,
UPDATE ON petshop.products TO 'vendedor_petshop' @'%';

GRANT
SELECT,
INSERT
,
UPDATE ON petshop.ticket_products TO 'vendedor_petshop' @'%';

GRANT
SELECT,
INSERT
,
UPDATE ON petshop.tickets_online TO 'vendedor_petshop' @'%';

GRANT SELECT ON petshop.users TO 'vendedor_petshop' @'%';

CREATE USER IF NOT EXISTS 'usuario_petshop' @'%' IDENTIFIED BY 'Usuario123!';

GRANT SELECT ON petshop.products TO 'usuario_petshop' @'%';

GRANT SELECT ON petshop.ticket_products TO 'usuario_petshop' @'%';

GRANT SELECT ON petshop.tickets_online TO 'usuario_petshop' @'%';

FLUSH PRIVILEGES;
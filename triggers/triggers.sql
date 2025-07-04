USE petshop;

DELIMITER / /

CREATE TRIGGER trg_actualizar_fecha_producto
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    IF NEW.stock != OLD.stock OR NEW.price != OLD.price THEN
        SET NEW.updated_at = CURRENT_TIMESTAMP;
    END IF;
END;
//

DELIMITER;

CREATE TABLE IF NOT EXISTS auditoria_tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id CHAR(36),
    estado_anterior ENUM(
        'pagado',
        'cancelado',
        'en proceso'
    ),
    estado_nuevo ENUM(
        'pagado',
        'cancelado',
        'en proceso'
    ),
    modificado_en DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER / /

CREATE TRIGGER trg_auditar_cambio_estado_ticket
AFTER UPDATE ON tickets_online
FOR EACH ROW
BEGIN
    IF NEW.status != OLD.status THEN
        INSERT INTO auditoria_tickets(ticket_id, estado_anterior, estado_nuevo)
        VALUES (NEW.id, OLD.status, NEW.status);
    END IF;
END;
//

DELIMITER;

DELIMITER / /

CREATE TRIGGER trg_prevenir_stock_negativo_insert
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF NEW.stock < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El stock no puede ser negativo';
    END IF;
END;
//

DELIMITER;

DELIMITER / /

CREATE TRIGGER trg_prevenir_stock_negativo_update
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    IF NEW.stock < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El stock no puede ser negativo';
    END IF;
END;
//

DELIMITER;

CREATE TABLE IF NOT EXISTS auditoria_eliminacion_productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id CHAR(36),
    eliminado_en DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER / /

CREATE TRIGGER trg_auditar_eliminacion_producto
AFTER DELETE ON products
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_eliminacion_productos(product_id)
    VALUES (OLD.id);
END;
//

DELIMITER;

DELIMITER / /

CREATE TRIGGER trg_prevenir_eliminacion_admin
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    IF OLD.role = 'admin' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se puede eliminar un usuario con rol admin';
    END IF;
END;
//

DELIMITER;

UPDATE tickets_online SET status = 'pagado' WHERE id = 'uuid-ticket';

INSERT INTO
    products (
        id,
        title,
        price,
        description,
        stock,
        code,
        category,
        brand
    )
VALUES (
        UUID(),
        'Producto inválido',
        99.99,
        'Prueba',
        -5,
        'P001',
        'alimento',
        'marca'
    );

DELETE FROM products WHERE id = 'uuid-producto-existente';

DELETE FROM users WHERE id = 'uuid-admin';
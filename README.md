# 🐾 Petshop - Base de Datos para Tienda de Mascotas

## 📌 Descripción

Este repositorio contiene el diseño completo de la base de datos **Petshop**, una solución pensada para gestionar de forma integral una tienda de mascotas. Incluye el manejo de productos, usuarios, carritos de compras, tickets (ventas), wishlist, estadísticas de negocio, vistas analíticas, auditoría y control de permisos.

---

## 🧱 Estructura de Tablas

* **`products`**: Información de productos disponibles, incluyendo precio, stock, categoría, tipo, marca, etc.
* **`users`**: Registro de usuarios con sus datos personales, roles, géneros y suscripción al boletín.
* **`tickets_online`**: Representa las compras hechas en la tienda virtual.
* **`ticket_products`**: Detalla los productos comprados por ticket (tienda online y física).
* **`carts`**: Carritos de compras por usuario.
* **`cart_products`**: Productos asociados a cada carrito.
* **`wishlists`**: Listas de deseos por usuario.
* **`wishlist_products`**: Productos en cada wishlist.
* **`product_thumbnails`**: Galería de imágenes adicionales por producto.
* **`tickets_tienda_fisica`**: Tickets de compras presenciales.
* **`auditoria_tickets`**: Historial de cambios de estado de los tickets.
* **`auditoria_eliminacion_productos`**: Registro de productos eliminados.

---

## ⚙️ Procedimientos Almacenados

Gestión avanzada con `PROCEDURES` para:

* Carrito: `add_product_to_cart`, `get_products_from_cart`, `delete_product_from_cart`, `empty_cart`, `get_cart_by_id`
* Wishlist: `add_product_to_wishlist`, `get_products_from_wishlist`, `delete_product_from_wishlist`, `empty_wishlist`, `get_wishlist_by_id`
* Usuarios: `create_user`, `update_user`, `delete_user`, `change_user_role`, `get_all_users`
* Tickets: `create_ticket`, `update_ticket_status`, `pay_ticket`, `pay_cancel`, `pay_process`, `delete_ticket`
* Consultas auxiliares: `find_user_by_cart_id`, `get_user_by_id`, `get_all_tickets`, `get_ticket_by_id`

📌 **Ejemplo**:

```sql
CALL create_user('uuid-user', 'Carlos', 'Pérez', ...);
CALL get_products_from_cart('uuid-cart');
```

---

## 🧮 Funciones SQL

Funciones útiles para reportes y analítica:

* `obtener_ingresos_totales()` → Total en ingresos por ventas.
* `mayor_venta()` → Ticket con mayor valor.
* `menor_venta()` → Ticket con menor valor.
* `numero_clientes()` → Clientes únicos que han comprado.
* `numero_ventas()` → Total de tickets pagados.
* `promedio_ventas()` → Promedio de ventas pagadas.

---

## 👁️ Vistas SQL

Vistas preconstruidas para reportes y dashboard:

* `top_productos_mas_vendidos` → Top 10 productos más vendidos.
* `productos_menos_vendidos` → Top 10 productos menos vendidos.
* `destacados_top_ventas` → Productos destacados más vendidos.
* `resumen_ventas_productos` → Totales vendidos e ingresos por producto.
* `ingresos_por_tienda` → Ingresos agrupados por tipo de tienda.
* `rango_ventas_productos` → Máximo y mínimo ventas por producto.
* `compras_por_usuario` → Total de compras e inversión por usuario.

---

## 🧐 Triggers y Auditoría

Automatizaciones y control de integridad:

* `tr_actualizar_producto_fecha` → Actualiza `updated_at` si cambian `stock` o `price`.
* `tr_cambio_estado_ticket` → Registra cada cambio de estado en la tabla `auditoria_tickets`.
* `tr_prevenir_stock_negativo` → Impide insertar productos con stock negativo.
* `tr_auditar_eliminacion_producto` → Registra en auditoría al eliminar un producto.
* `tr_prevenir_borrado_admin` → Impide eliminar usuarios con rol `admin`.

---

## 🔐 Control de Acceso (Usuarios y Permisos)

Usuarios SQL con diferentes niveles de privilegios:

| Usuario            | Privilegios                              |
| ------------------ | ---------------------------------------- |
| `admin_petshop`    | Todos los privilegios (`ALL PRIVILEGES`) |
| `vendedor_petshop` | `SELECT`, `INSERT`, `UPDATE`             |
| `usuario_petshop`  | Solo `SELECT`                            |

📌 Ejemplo:

```sql
CREATE USER 'admin_petshop'@'%' IDENTIFIED BY 'AdminSeguro123!';
GRANT ALL PRIVILEGES ON petshop.* TO 'admin_petshop'@'%';
```

---

## 🛠️ Requisitos

* MySQL 8.0 o superior.
* Cliente MySQL (Workbench, CLI, DBeaver o compatible).
* Script `petshop_schema.sql` incluido para importación rápida.

---

## 🚀 Instalación

```bash
git clone https://github.com/tuusuario/petshop-db.git
mysql -u root -p < petshop_schema.sql
```

---

## 📊 Ejemplos de Consultas

```sql
-- Total de ingresos
SELECT obtener_ingresos_totales();

-- Compras por usuario
SELECT * FROM compras_por_usuario;

-- Productos más vendidos
SELECT * FROM top_productos_mas_vendidos;
```

---

## 🪪 Licencia

Este proyecto está bajo la Licencia MIT. Puedes usarlo, modificarlo y adaptarlo libremente.

---

## 👨‍💼 Autor

**Gabriel Castro Ramírez**
📧 [gbrlcstr@hotmail.com](mailto:gbrlcstr@hotmail.com)
🔗 [LinkedIn](https://www.linkedin.com/in/gabrielcastro1221)
📁 [Portafolio](https://github.com/GabrielCastro1221)

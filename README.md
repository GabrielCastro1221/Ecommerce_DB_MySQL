# 🐾 Petshop - Base de Datos para Tienda de Mascotas

## 📌 Descripción

Este repositorio contiene el diseño completo de la base de datos **Petshop**, una solución pensada para gestionar de forma integral una tienda de mascotas. Incluye el manejo de productos, usuarios, carritos de compras, tickets (ventas), wishlist, estadísticas de negocio, vistas analíticas, auditoría y control de permisos.

---

## 🧩 Modelo Entidad-Relación

> Puedes reemplazar la ruta con tu imagen local o en línea:

![Modelo Entidad-Relación](/assets/DiagramaER.png)

---

## 🔄 Flujo de Datos y Relaciones entre Tablas

El modelo Petshop está diseñado con una estructura relacional clara y modular, que permite administrar tanto el comercio electrónico como el punto de venta físico de forma eficiente. A continuación se describe cómo fluye la información a través del sistema:

### 1. 👤 Registro y autenticación de usuarios

**Tablas involucradas:**
- `users` (PK: `id`)
- `carts` (PK: `id`)
- `wishlists` (PK: `id`)

**Flujo:**
1. Al crear un usuario, se genera automáticamente un carrito (`carts`) y una lista de deseos (`wishlists`).
2. El usuario queda vinculado a su carrito mediante `users.cart_id` y a su wishlist por medio de procedimientos o lógica adicional.

---

### 2. 🔎 Exploración del catálogo

**Tablas involucradas:**
- `products` (PK: `id`)
- `product_thumbnails` (FK: `product_id → products.id`)

**Flujo:**
1. El usuario consulta la lista de productos.
2. Cada producto puede tener varias imágenes adicionales en `product_thumbnails`.

---

### 3. 🛒 Carrito y Wishlist

**Tablas involucradas:**
- `cart_products` (FK: `cart_id`, `product_id`)
- `wishlist_products` (FK: `wishlist_id`, `product_id`)

**Flujo:**
1. Al agregar productos, se insertan en `cart_products` o `wishlist_products`.
2. Cada registro asocia una cantidad al producto en el carrito.

---

### 4. 🧾 Compra online

**Tablas involucradas:**
- `tickets_online` (FK: `purchaser_id`, `cart_id`)
- `ticket_products` (FK: `ticket_id`, `product_id`)
- `payments` (FK: `ticket_id`)

**Flujo:**
1. El usuario realiza checkout: se genera un ticket (`tickets_online`).
2. Los productos comprados se guardan en `ticket_products`.
3. Se registra el pago con `payments`.

---

### 5. 🧾 Compra en tienda física

**Tablas involucradas:**
- `tickets_tienda_fisica` (FK: `purchaser_id`, `seller_id`, `store_location_id`)
- `ticket_products` (compartida con ecommerce, pero con `store_type = 'tienda_fisica'`)

**Flujo:**
1. Un vendedor procesa la venta.
2. Se registra en `tickets_tienda_fisica` y los productos se vinculan en `ticket_products`.

---

### 6. 💳 Pagos

**Tabla involucrada:**
- `payments`

**Flujo:**
1. Cada compra se vincula con un pago mediante `ticket_id`.
2. Se detalla el método, estado y código de transacción.

---

### 7. 📦 Inventario

**Tabla involucrada:**
- `inventory_movements`

**Flujo:**
1. Las ventas registran salidas (`salida`).
2. El abastecimiento se registra como entrada (`entrada`).
3. Las devoluciones como `devolución`.
4. Estas acciones modifican el campo `stock` en `products`.

---

### 8. 🧭 Sucursales

**Tablas involucradas:**
- `store_locations`
- `tickets_tienda_fisica`

**Flujo:**
1. Cada venta en tienda física se vincula a una sucursal mediante `store_location_id`.

---

## 🧱 Estructura de Tablas

* **`products`**, **`users`**, **`tickets_online`**, **`ticket_products`**, **`carts`**, **`cart_products`**, **`wishlists`**, **`wishlist_products`**, **`product_thumbnails`**, **`tickets_tienda_fisica`**, **`auditoria_tickets`**, **`auditoria_eliminacion_productos`**

---

## ⚙️ Procedimientos Almacenados

Procedimientos como:

```sql
CALL add_product_to_cart('cart_id', 'product_id', 1);
CALL create_user('uuid-user', 'Carlos', 'Pérez', ...);
```

Consulta el README original para la lista completa.

---

## 🧮 Funciones SQL

Funciones como:

```sql
SELECT obtener_ingresos_totales();
SELECT mayor_venta();
SELECT numero_clientes();
```

---

## 👁️ Vistas SQL

Reportes como:

- `top_productos_mas_vendidos`
- `compras_por_usuario`
- `resumen_ventas_productos`

---

## 🧐 Triggers y Auditoría

Incluye triggers para:

- Auditoría de cambios de estado en tickets.
- Prevención de eliminación de administradores.
- Registro de productos eliminados.

---

## 🔐 Control de Acceso (Usuarios y Permisos)

| Usuario            | Privilegios                              |
|--------------------|-------------------------------------------|
| `admin_petshop`    | `ALL PRIVILEGES`                          |
| `vendedor_petshop` | `SELECT`, `INSERT`, `UPDATE`              |
| `usuario_petshop`  | `SELECT`                                  |

---

## 🚀 Instalación

```bash
git clone https://github.com/tuusuario/petshop-db.git
mysql -u root -p < petshop_schema.sql
```

---

## 📊 Ejemplos de Consultas

```sql
SELECT obtener_ingresos_totales();
SELECT * FROM compras_por_usuario;
SELECT * FROM top_productos_mas_vendidos;
```

---

## 🪪 Licencia

Este proyecto está bajo la Licencia MIT.

---

## 👨‍💼 Autor

**Gabriel Castro Ramírez**  
📧 [gbrlcstr@hotmail.com](mailto:gbrlcstr@hotmail.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/gabrielcastro1221)  
📁 [Portafolio](https://github.com/GabrielCastro1221)

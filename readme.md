
# 🍕 Sistema de Gestión de Pizzería – Base de Datos MySQL

## 📋 Descripción del Proyecto 


Proyecto académico enfocado en el diseño e implementación de una base de datos relacional para una pizzería utilizando MySQL. La solución centraliza la información de productos, ingredientes, combos, pedidos, clientes y adiciones, incorporando vistas y disparadores que facilitan la operación diaria y el análisis de datos.

## 🎯 Objetivo

- Centralizar el catálogo completo de productos y combos.
- Facilitar la personalización de pedidos mediante adiciones.
- Llevar el control de pedidos para consumir en el local o recoger.
- Automatizar cálculos de subtotales y totales.
- Generar reportes que ayuden a entender ventas, ingresos y preferencias de clientes.

## 🌟 Características Destacadas

- Modelo en tercera forma normal con integridad referencial.
- Vistas como `vista_productos_ingredientes`, `vista_combos_detalle` y `vista_pedidos_completos`.
- Disparadores que recalculan montos al insertar, actualizar o eliminar pedidos y adiciones.
- Datos de ejemplo para probar el comportamiento del sistema.
- Consultas analíticas que cubren ventas por categoría, combos, adiciones, hábitos de clientes y tendencias diarias.

## 🧰 Tecnologías Utilizadas

- MySQL 8.0 (motor InnoDB, vistas y triggers).
- SQL para definición y consulta de datos.
- Herramientas de modelado recomendadas: MySQL Workbench, DrawSQL o StarUML.
- Control de versiones con Git y GitHub.

## 🗂️ Estructura del Sistema

- **Cliente**: datos de contacto y estado.
- **Producto** y **Categoria_producto**: catálogo clasificado, incluidas bebidas y postres.
- **Ingrediente** y **Producto_ingrediente**: recetas detalladas para productos elaborados.
- **Adicion** y **Detalle_adicion**: extras personalizables asociados a cada pedido.
- **Combo** y **Combo_producto**: promociones con vigencia, descuentos y composición.
- **Menu** y **Menu_item**: planificación de menús por periodos.
- **Pedido** y **Detalle_pedido**: registro completo de pedidos con cálculos automáticos.

## 📦 Qué Hace Cada Archivo

| Archivo | Descripción |
| --- | --- |
| `codigo sql` | Script maestro que crea la base `pizzeria_db`, define tablas, restricciones, disparadores y carga datos de ejemplo. |
| `codigo _consulta.sql` | Colección de 20 consultas analíticas para explorar ventas, combos, adiciones y clientes. |
| `ERDDiagram1.jpg` | Diagrama entidad-relación del modelo. |
| `readme.md` | Documento de referencia del proyecto. |

## 👨‍💻 Autor

**Valentina Mancilla**.



# 🍕 Sistema de Gestión de Pizzería – Base de Datos MySQL

## 📋 Descripción del Proyecto

Este proyecto consiste en el diseño e implementación de una **base de datos relacional en MySQL** para una pizzería.
El sistema permite gestionar de manera eficiente los **productos, combos, pedidos, clientes y adiciones**, centralizando toda la información en una única plataforma.
El propósito principal es facilitar el control del menú, la gestión de ventas y la personalización de pedidos, permitiendo generar reportes que apoyen la toma de decisiones.

---

## 🎯 Objetivo

Desarrollar una base de datos que permita:

* Registrar y administrar todos los productos del menú (pizzas, panzarottis, bebidas, postres, etc.).
* Gestionar adiciones personalizadas para los clientes.
* Controlar la venta de **combos especiales**.
* Registrar y analizar los **pedidos**, ya sean para **consumir en el lugar** o **recoger**.
* Facilitar consultas analíticas sobre ventas, productos más vendidos e ingresos generados.

---

## 🌟 Características Destacadas

* **Gestión de Productos:** Control completo de productos elaborados y no elaborados, incluyendo sus ingredientes.
* **Gestión de Adiciones:** Posibilidad de agregar extras a los productos (como queso, salsas, etc.).
* **Gestión de Combos:** Administración de combos con varios productos a precio promocional.
* **Gestión de Pedidos:** Registro detallado de cada pedido, tipo, fecha, cliente y monto total.
* **Consultas Analíticas:** Permite obtener reportes sobre ventas, ingresos, preferencias de clientes y productos más vendidos.

---

## 🧰 Tecnologías Utilizadas

* **Base de Datos:** MySQL 8.0
* **Lenguaje de Consultas:** SQL
* **Herramientas de Diseño:** MySQL Workbench / DrawSQL / StarUML
* **Control de Versiones:** Git y GitHub

---

## 🗂️ Estructura del Sistema

El sistema está compuesto por las siguientes entidades principales:

* **Producto:** Registra información de pizzas, panzarottis, bebidas y postres.
* **Ingrediente:** Almacena los ingredientes de los productos elaborados.
* **Adición:** Contiene las opciones adicionales que puede elegir el cliente.
* **Combo:** Agrupa varios productos con un precio especial.
* **Cliente:** Guarda la información básica de los clientes.
* **Pedido:** Registra cada pedido realizado, incluyendo fecha, tipo y total.
* **Pedido_Producto / Pedido_Combo / Pedido_Adición:** Enlazan los pedidos con los productos, combos y adiciones correspondientes.

---

## 📦 Qué Hace Cada Archivo

| Archivo            | Descripción                                                                                                           |
| ------------------ | --------------------------------------------------------------------------------------------------------------------- |
| **estructura.sql** | Contiene la estructura completa de la base de datos: creación de tablas, claves primarias, foráneas y restricciones.  |
| **datos.sql**      | Incluye los datos de prueba (clientes, productos, combos, pedidos, adiciones, etc.) para validar el sistema.          |
| **README.md**      | Documento de guía del proyecto: explica la finalidad, características, estructura, archivos y tecnologías utilizadas. |

---

## 👨‍💻 Autor

**valentina mancilla **




## 🏆 Análisis de Ventas por Producto

### 1. Productos más vendidos
Lista todos los productos vendidos con sus detalles.

```sql
SELECT 
    p.nombre AS producto,
    c.nombre AS categoria,
    dp.cantidad AS cantidad_vendida,
    dp.subtotal_detalle AS ingresos,
    dp.precio_unitario AS precio
FROM detalle_pedido AS dp
JOIN producto AS p ON dp.id_producto = p.id_producto
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido;
```

### 5. Cantidad total de productos vendidos por categoría
Lista todas las ventas agrupadas por categoría.

```sql
SELECT 
    c.nombre AS categoria,
    p.nombre AS producto,
    dp.cantidad AS unidades_vendidas,
    dp.subtotal_detalle AS ingresos
FROM categoria_producto AS c
JOIN producto AS p ON c.id_categoria = p.id_categoria
JOIN detalle_pedido AS dp ON p.id_producto = dp.id_producto
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido;
```

---

## 🎁 Análisis de Combos

### 2. Total de ingresos generados por cada combo
Lista todos los combos vendidos con sus ingresos.

```sql
SELECT 
    c.nombre AS combo,
    c.precio_combo,
    c.descuento_porcentaje,
    dp.cantidad AS veces_vendido,
    dp.subtotal_detalle AS ingresos
FROM combo AS c
JOIN detalle_pedido AS dp ON c.id_combo = dp.id_combo
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido;
```

### 13. Total de combos vendidos en el último mes
Lista los combos vendidos recientemente.

```sql
SELECT 
    c.nombre AS combo,
    dp.cantidad AS cantidad_vendida,
    dp.subtotal_detalle AS ingresos,
    ped.fecha_hora AS fecha_venta
FROM detalle_pedido AS dp
JOIN combo AS c ON dp.id_combo = c.id_combo
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido;
```

### 9. Pedidos que incluyen bebidas como parte de un combo
Identifica pedidos con combos que tienen bebidas.

```sql
SELECT 
    ped.id_pedido,
    c.nombre AS combo,
    cli.nombre AS cliente,
    cli.apellido,
    ped.fecha_hora,
    p.nombre AS bebida
FROM pedido AS ped
JOIN cliente AS cli ON ped.id_cliente = cli.id_cliente
JOIN detalle_pedido AS dp ON ped.id_pedido = dp.id_pedido
JOIN combo AS c ON dp.id_combo = c.id_combo
JOIN combo_producto AS cp ON c.id_combo = cp.id_combo
JOIN producto AS p ON cp.id_producto = p.id_producto
JOIN categoria_producto AS cat ON p.id_categoria = cat.id_categoria;
```

---

## 🍕 Análisis de Adiciones

### 4. Adiciones más solicitadas en pedidos personalizados
Lista todas las adiciones solicitadas.

```sql
SELECT 
    a.nombre AS adicion,
    a.tipo,
    da.cantidad AS cantidad_solicitada,
    da.subtotal_adicion AS ingreso_adicion,
    da.precio_adicion AS precio
FROM adicion AS a
JOIN detalle_adicion AS da ON a.id_adicion = da.id_adicion
JOIN detalle_pedido AS dp ON da.id_detalle = dp.id_detalle
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido;
```

### 8. Cantidad de panzarottis vendidos con extra queso
Lista panzarottis que tienen extra queso.

```sql
SELECT 
    p.nombre AS panzarotti,
    dp.cantidad AS unidades,
    dp.subtotal_detalle AS ingreso_producto,
    da.subtotal_adicion AS ingreso_extra_queso,
    a.nombre AS adicion
FROM producto AS p
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
JOIN detalle_pedido AS dp ON p.id_producto = dp.id_producto
JOIN detalle_adicion AS da ON dp.id_detalle = da.id_detalle
JOIN adicion AS a ON da.id_adicion = a.id_adicion
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido;
```

### 12. Promedio de adiciones por pedido
Lista todos los pedidos con sus adiciones.

```sql
SELECT 
    ped.id_pedido,
    cli.nombre AS cliente,
    da.cantidad AS cantidad_adiciones,
    da.subtotal_adicion AS total_adiciones
FROM pedido AS ped
JOIN cliente AS cli ON ped.id_cliente = cli.id_cliente
JOIN detalle_pedido AS dp ON ped.id_pedido = dp.id_pedido
JOIN detalle_adicion AS da ON dp.id_detalle = da.id_detalle;
```

### 15. Total de productos personalizados con adiciones
Lista productos que han sido personalizados.

```sql
SELECT 
    p.nombre AS producto,
    c.nombre AS categoria,
    dp.cantidad AS veces_personalizado,
    a.nombre AS adicion_agregada,
    da.subtotal_adicion AS ingreso_adicion
FROM producto AS p
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
JOIN detalle_pedido AS dp ON p.id_producto = dp.id_producto
JOIN detalle_adicion AS da ON dp.id_detalle = da.id_detalle
JOIN adicion AS a ON da.id_adicion = a.id_adicion
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido;
```

---

## 📊 Análisis de Pedidos

### 3. Pedidos realizados para recoger vs. comer en la pizzería
Lista todos los pedidos según su tipo.

```sql
SELECT 
    ped.id_pedido,
    ped.tipo_pedido,
    ped.total_final AS total,
    cli.nombre AS cliente,
    cli.apellido,
    ped.fecha_hora
FROM pedido AS ped
JOIN cliente AS cli ON ped.id_cliente = cli.id_cliente;
```

### 16. Pedidos con más de 3 productos diferentes
Lista pedidos y sus productos.

```sql
SELECT 
    ped.id_pedido,
    cli.nombre AS cliente,
    cli.apellido,
    ped.fecha_hora,
    p.nombre AS producto,
    c.nombre AS combo,
    ped.total_final
FROM pedido AS ped
JOIN cliente AS cli ON ped.id_cliente = cli.id_cliente
JOIN detalle_pedido AS dp ON ped.id_pedido = dp.id_pedido
LEFT JOIN producto AS p ON dp.id_producto = p.id_producto
LEFT JOIN combo AS c ON dp.id_combo = c.id_combo;
```

### 20. Día de la semana con mayor número de pedidos para recoger
Lista pedidos para recoger con día de la semana.

```sql
SELECT 
    ped.id_pedido,
    ped.fecha_hora,
    ped.tipo_pedido,
    ped.total_final AS ingreso,
    cli.nombre AS cliente
FROM pedido AS ped
JOIN cliente AS cli ON ped.id_cliente = cli.id_cliente;
```

---

## 💰 Análisis de Ingresos

### 7. Total de ventas por día de la semana
Lista todas las ventas con fecha.

```sql
SELECT 
    ped.id_pedido,
    ped.fecha_hora,
    ped.total_final AS ingresos,
    ped.subtotal AS subtotal_productos,
    ped.total_adiciones,
    cli.nombre AS cliente
FROM pedido AS ped
JOIN cliente AS cli ON ped.id_cliente = cli.id_cliente;
```

### 11. Ingresos totales generados por productos no elaborados
Lista productos simples vendidos (bebidas, postres).

```sql
SELECT 
    c.nombre AS categoria,
    p.nombre AS producto,
    p.es_elaborado,
    dp.cantidad AS unidades_vendidas,
    dp.subtotal_detalle AS ingresos,
    dp.precio_unitario AS precio
FROM producto AS p
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
JOIN detalle_pedido AS dp ON p.id_producto = dp.id_producto
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido;
```

### 17. Promedio de ingresos generados por día
Lista ingresos diarios.

```sql
SELECT 
    ped.id_pedido,
    ped.fecha_hora,
    ped.total_final AS ingreso_pedido,
    cli.nombre AS cliente,
    cli.apellido
FROM pedido AS ped
JOIN cliente AS cli ON ped.id_cliente = cli.id_cliente;
```

### 19. Porcentaje de ventas provenientes de productos no elaborados
Lista ventas de productos elaborados y no elaborados.

```sql
SELECT 
    p.nombre AS producto,
    p.es_elaborado,
    c.nombre AS categoria,
    dp.cantidad,
    dp.subtotal_detalle AS ingresos
FROM detalle_pedido AS dp
JOIN producto AS p ON dp.id_producto = p.id_producto
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido;
```

---

## 👥 Análisis de Clientes

### 6. Promedio de pizzas pedidas por cliente
Lista clientes y sus pizzas pedidas.

```sql
SELECT 
    cli.id_cliente,
    cli.nombre,
    cli.apellido,
    ped.id_pedido,
    p.nombre AS pizza,
    dp.cantidad AS pizzas_pedidas
FROM cliente AS cli
JOIN pedido AS ped ON cli.id_cliente = ped.id_cliente
JOIN detalle_pedido AS dp ON ped.id_pedido = dp.id_pedido
JOIN producto AS p ON dp.id_producto = p.id_producto
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria;
```

### 10. Clientes que han realizado más de 5 pedidos en el último mes
Lista todos los clientes con sus pedidos.

```sql
SELECT 
    cli.id_cliente,
    cli.nombre,
    cli.apellido,
    cli.telefono,
    cli.email,
    ped.id_pedido,
    ped.total_final AS gasto,
    ped.fecha_hora
FROM cliente AS cli
JOIN pedido AS ped ON cli.id_cliente = ped.id_cliente;
```

### 14. Clientes con pedidos tanto para recoger como para consumir en el lugar
Lista clientes con sus tipos de pedidos.

```sql
SELECT 
    cli.id_cliente,
    cli.nombre,
    cli.apellido,
    cli.telefono,
    ped.id_pedido,
    ped.tipo_pedido,
    ped.total_final AS gasto
FROM cliente AS cli
JOIN pedido AS ped ON cli.id_cliente = ped.id_cliente;
```

### 18. Clientes que han pedido pizzas con adiciones
Lista clientes que personalizan sus pizzas.

```sql
SELECT 
    cli.id_cliente,
    cli.nombre,
    cli.apellido,
    ped.id_pedido,
    p.nombre AS pizza,
    a.nombre AS adicion,
    da.subtotal_adicion AS gasto_adicion
FROM cliente AS cli
JOIN pedido AS ped ON cli.id_cliente = ped.id_cliente
JOIN detalle_pedido AS dp ON ped.id_pedido = dp.id_pedido
JOIN producto AS p ON dp.id_producto = p.id_producto
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
LEFT JOIN detalle_adicion AS da ON dp.id_detalle = da.id_detalle
LEFT JOIN adicion AS a ON da.id_adicion = a.id_adicion;
```



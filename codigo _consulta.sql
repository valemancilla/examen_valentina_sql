
-- ============================================================================
-- 1. PRODUCTOS MÁS VENDIDOS (pizza, panzarottis, bebidas, etc.)
-- ============================================================================
SELECT 
    p.nombre AS producto,
    c.nombre AS categoria,
    SUM(dp.cantidad) AS total_vendido,
    SUM(dp.subtotal_detalle) AS ingresos_generados
FROM detalle_pedido AS dp
JOIN producto AS p ON dp.id_producto = p.id_producto
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido
GROUP BY p.id_producto, p.nombre, c.nombre
ORDER BY total_vendido DESC;


-- ============================================================================
-- 2. TOTAL DE INGRESOS GENERADOS POR CADA COMBO
-- ============================================================================
SELECT 
    co.nombre AS combo,
    co.precio_combo,
    COUNT(dp.id_detalle) AS veces_vendido,
    SUM(dp.subtotal_detalle) AS ingresos_totales
FROM detalle_pedido AS dp
JOIN combo AS co ON dp.id_combo = co.id_combo
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido
GROUP BY co.id_combo, co.nombre, co.precio_combo
ORDER BY ingresos_totales DESC;


-- ============================================================================
-- 3. PEDIDOS REALIZADOS PARA RECOGER VS. COMER EN LA PIZZERÍA
-- ============================================================================
SELECT 
    tipo_pedido,
    COUNT(*) AS cantidad_pedidos,
    SUM(total_final) AS ingresos_totales,
    AVG(total_final) AS promedio_por_pedido
FROM pedido
GROUP BY tipo_pedido
ORDER BY cantidad_pedidos DESC;


-- ============================================================================
-- 4. ADICIONES MÁS SOLICITADAS EN PEDIDOS PERSONALIZADOS
-- ============================================================================
SELECT 
    a.nombre AS adicion,
    a.tipo,
    SUM(da.cantidad) AS total_solicitado,
    COUNT(da.id_detalle) AS pedidos_con_adicion,
    SUM(da.subtotal_adicion) AS ingresos_generados
FROM detalle_adicion AS da
JOIN adicion AS a ON da.id_adicion = a.id_adicion
JOIN detalle_pedido AS dp ON da.id_detalle = dp.id_detalle
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido
GROUP BY a.id_adicion, a.nombre, a.tipo
ORDER BY total_solicitado DESC;


-- ============================================================================
-- 5. CANTIDAD TOTAL DE PRODUCTOS VENDIDOS POR CATEGORÍA
-- ============================================================================
SELECT 
    c.nombre AS categoria,
    COUNT(p.id_producto) AS productos_diferentes,
    SUM(dp.cantidad) AS total_unidades_vendidas,
    SUM(dp.subtotal_detalle) AS ingresos_totales
FROM detalle_pedido AS dp
JOIN producto AS p ON dp.id_producto = p.id_producto
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido
GROUP BY c.id_categoria, c.nombre
ORDER BY total_unidades_vendidas DESC;


-- ============================================================================
-- 6. PROMEDIO DE PIZZAS PEDIDAS POR CLIENTE
-- ============================================================================
SELECT 
    cl.id_cliente,
    CONCAT(cl.nombre, ' ', cl.apellido) AS cliente,
    COUNT(ped.id_pedido) AS total_pedidos,
    SUM(dp.cantidad) AS total_pizzas,
    AVG(dp.cantidad) AS promedio_pizzas_por_pedido
FROM cliente AS cl
JOIN pedido AS ped ON cl.id_cliente = ped.id_cliente
JOIN detalle_pedido AS dp ON ped.id_pedido = dp.id_pedido
JOIN producto AS p ON dp.id_producto = p.id_producto
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
GROUP BY cl.id_cliente, cl.nombre, cl.apellido
ORDER BY promedio_pizzas_por_pedido DESC;


-- ============================================================================
-- 7. TOTAL DE VENTAS POR DÍA DE LA SEMANA
-- ============================================================================
SELECT 
    DAYNAME(fecha_hora) AS dia_semana,
    DAYOFWEEK(fecha_hora) AS numero_dia,
    COUNT(*) AS cantidad_pedidos,
    SUM(total_final) AS ingresos_totales,
    AVG(total_final) AS promedio_por_pedido
FROM pedido
GROUP BY DAYNAME(fecha_hora), DAYOFWEEK(fecha_hora)
ORDER BY numero_dia;


-- ============================================================================
-- 8. CANTIDAD DE PANZAROTTIS VENDIDOS CON EXTRA QUESO
-- ============================================================================
SELECT 
    p.nombre AS panzarotti,
    COUNT(dp.id_detalle) AS pedidos_con_extra_queso,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(da.cantidad) AS total_porciones_extra_queso
FROM detalle_pedido AS dp
JOIN producto AS p ON dp.id_producto = p.id_producto
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
JOIN detalle_adicion AS da ON dp.id_detalle = da.id_detalle
JOIN adicion AS a ON da.id_adicion = a.id_adicion
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido
GROUP BY p.id_producto, p.nombre
ORDER BY pedidos_con_extra_queso DESC;


-- ============================================================================
-- 9. PEDIDOS QUE INCLUYEN BEBIDAS COMO PARTE DE UN COMBO
-- ============================================================================
SELECT 
    co.nombre AS combo,
    COUNT(dp.id_pedido) AS pedidos_realizados,
    SUM(dp.cantidad) AS combos_vendidos
FROM detalle_pedido AS dp
JOIN combo AS co ON dp.id_combo = co.id_combo
JOIN combo_producto AS cp ON co.id_combo = cp.id_combo
JOIN producto AS p ON cp.id_producto = p.id_producto
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido
GROUP BY co.id_combo, co.nombre
ORDER BY combos_vendidos DESC;


-- ============================================================================
-- 10. CLIENTES QUE HAN REALIZADO MÁS DE 5 PEDIDOS EN EL ÚLTIMO MES
-- ============================================================================
SELECT 
    cl.id_cliente,
    CONCAT(cl.nombre, ' ', cl.apellido) AS cliente,
    cl.telefono,
    cl.email,
    COUNT(*) AS total_pedidos,
    SUM(ped.total_final) AS total_gastado,
    AVG(ped.total_final) AS promedio_por_pedido
FROM cliente AS cl
JOIN pedido AS ped ON cl.id_cliente = ped.id_cliente
GROUP BY cl.id_cliente, cl.nombre, cl.apellido, cl.telefono, cl.email
ORDER BY total_pedidos DESC;


-- ============================================================================
-- 11. INGRESOS TOTALES GENERADOS POR PRODUCTOS NO ELABORADOS
-- ============================================================================
SELECT 
    c.nombre AS categoria,
    COUNT(p.id_producto) AS productos_diferentes,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(dp.subtotal_detalle) AS ingresos_totales
FROM detalle_pedido AS dp
JOIN producto AS p ON dp.id_producto = p.id_producto
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido
GROUP BY c.id_categoria, c.nombre
ORDER BY ingresos_totales DESC;


-- ============================================================================
-- 12. PROMEDIO DE ADICIONES POR PEDIDO
-- ============================================================================
SELECT 
    COUNT(ped.id_pedido) AS total_pedidos,
    COUNT(da.id_detalle_adicion) AS total_adiciones,
    AVG(da.cantidad) AS promedio_adiciones_por_pedido,
    SUM(da.subtotal_adicion) AS ingresos_totales_adiciones
FROM pedido AS ped
JOIN detalle_pedido AS dp ON ped.id_pedido = dp.id_pedido
JOIN detalle_adicion AS da ON dp.id_detalle = da.id_detalle;


-- ============================================================================
-- 13. TOTAL DE COMBOS VENDIDOS EN EL ÚLTIMO MES
-- ============================================================================
SELECT 
    co.nombre AS combo,
    co.precio_combo,
    COUNT(dp.id_detalle) AS veces_vendido,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(dp.subtotal_detalle) AS ingresos_generados
FROM detalle_pedido AS dp
JOIN combo AS co ON dp.id_combo = co.id_combo
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido
GROUP BY co.id_combo, co.nombre, co.precio_combo
ORDER BY unidades_vendidas DESC;


-- ============================================================================
-- 14. CLIENTES CON PEDIDOS TANTO PARA RECOGER COMO PARA CONSUMIR
-- ============================================================================
SELECT 
    cl.id_cliente,
    CONCAT(cl.nombre, ' ', cl.apellido) AS cliente,
    cl.telefono,
    COUNT(*) AS total_pedidos,
    SUM(ped.total_final) AS total_gastado
FROM cliente AS cl
JOIN pedido AS ped ON cl.id_cliente = ped.id_cliente
GROUP BY cl.id_cliente, cl.nombre, cl.apellido, cl.telefono
ORDER BY total_pedidos DESC;


-- ============================================================================
-- 15. TOTAL DE PRODUCTOS PERSONALIZADOS CON ADICIONES
-- ============================================================================
SELECT 
    p.nombre AS producto,
    c.nombre AS categoria,
    COUNT(dp.id_detalle) AS pedidos_con_adiciones,
    COUNT(da.id_detalle_adicion) AS total_adiciones,
    SUM(da.subtotal_adicion) AS ingresos_adiciones
FROM detalle_pedido AS dp
JOIN producto AS p ON dp.id_producto = p.id_producto
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
JOIN detalle_adicion AS da ON dp.id_detalle = da.id_detalle
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido
GROUP BY p.id_producto, p.nombre, c.nombre
ORDER BY pedidos_con_adiciones DESC;


-- ============================================================================
-- 16. PEDIDOS CON MÁS DE 3 PRODUCTOS DIFERENTES
-- ============================================================================
SELECT 
    ped.id_pedido,
    ped.fecha_hora,
    CONCAT(cl.nombre, ' ', cl.apellido) AS cliente,
    ped.tipo_pedido,
    COUNT(dp.id_detalle) AS productos_diferentes,
    SUM(dp.cantidad) AS total_items,
    ped.total_final
FROM pedido AS ped
JOIN cliente AS cl ON ped.id_cliente = cl.id_cliente
JOIN detalle_pedido AS dp ON ped.id_pedido = dp.id_pedido
GROUP BY ped.id_pedido, ped.fecha_hora, cl.nombre, cl.apellido, ped.tipo_pedido, ped.total_final
ORDER BY productos_diferentes DESC, ped.fecha_hora DESC;


-- ============================================================================
-- 17. PROMEDIO DE INGRESOS GENERADOS POR DÍA
-- ============================================================================
SELECT 
    DATE(fecha_hora) AS fecha,
    DAYNAME(fecha_hora) AS dia_semana,
    COUNT(*) AS pedidos_del_dia,
    SUM(total_final) AS ingresos_del_dia,
    AVG(total_final) AS promedio_por_pedido
FROM pedido
GROUP BY DATE(fecha_hora), DAYNAME(fecha_hora)
ORDER BY fecha DESC;


-- ============================================================================
-- 18. CLIENTES QUE HAN PEDIDO PIZZAS CON ADICIONES EN MÁS DEL 50%
-- ============================================================================
SELECT 
    cl.id_cliente,
    CONCAT(cl.nombre, ' ', cl.apellido) AS cliente,
    COUNT(dp.id_detalle) AS total_pizzas_pedidas,
    COUNT(da.id_detalle_adicion) AS pizzas_con_adiciones
FROM cliente AS cl
JOIN pedido AS ped ON cl.id_cliente = ped.id_cliente
JOIN detalle_pedido AS dp ON ped.id_pedido = dp.id_pedido
JOIN producto AS p ON dp.id_producto = p.id_producto
JOIN categoria_producto AS c ON p.id_categoria = c.id_categoria
JOIN detalle_adicion AS da ON dp.id_detalle = da.id_detalle
GROUP BY cl.id_cliente, cl.nombre, cl.apellido
ORDER BY pizzas_con_adiciones DESC;


-- ============================================================================
-- 19. PORCENTAJE DE VENTAS PROVENIENTES DE PRODUCTOS NO ELABORADOS
-- ============================================================================
SELECT 
    SUM(dp.subtotal_detalle) AS ingresos_productos,
    SUM(ped.total_final) AS ingresos_totales
FROM detalle_pedido AS dp
JOIN producto AS p ON dp.id_producto = p.id_producto
JOIN pedido AS ped ON dp.id_pedido = ped.id_pedido;


-- ============================================================================
-- 20. DÍA DE LA SEMANA CON MAYOR NÚMERO DE PEDIDOS PARA RECOGER
-- ============================================================================
SELECT 
    DAYNAME(fecha_hora) AS dia_semana,
    DAYOFWEEK(fecha_hora) AS numero_dia,
    COUNT(*) AS pedidos_para_recoger,
    SUM(total_final) AS ingresos_totales,
    AVG(total_final) AS promedio_por_pedido
FROM pedido
GROUP BY DAYNAME(fecha_hora), DAYOFWEEK(fecha_hora)
ORDER BY pedidos_para_recoger DESC;
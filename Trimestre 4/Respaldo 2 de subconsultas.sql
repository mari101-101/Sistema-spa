#Subconsultas

#1 Empleados cuya cantidad de citas sea mayor que el promedio de citas por empleado.
SELECT e.Empl_nombre AS Empleado, s.Serv_nombre AS Servicio, COUNT(c.Cita_Id) AS Total_Citas,
COUNT(DISTINCT cl.Clie_Id) AS Clientes_Atendidos
FROM Empleados e
INNER JOIN Cita c
ON e.Empl_Id = c.Empl_acargo_Id
INNER JOIN Servicios s
ON c.Cita_servicio = s.Serv_Id
INNER JOIN Cliente cl
ON c.Clie_Id = cl.Clie_Id
GROUP BY e.Empl_Id, e.Empl_nombre, s.Serv_Id, s.Serv_nombre
HAVING COUNT(c.Cita_Id) > (SELECT AVG(Total_Citas)
    FROM (SELECT COUNT(Cita_Id) AS Total_Citas
	FROM Cita
	GROUP BY Empl_acargo_Id) AS Promedio_Empleados)
ORDER BY Total_Citas DESC;

#2 Clientes cuyo gasto total en servicios sea superior al gasto promedio de los clientes.
SELECT cl.Clie_Nombre AS Cliente, LOWER(cl.Clie_correo) AS Correo, e.Empl_nombre AS Empleado,
tp.Tipo_pago_nombre AS Tipo_Pago, SUM(r.Reci_monto_servicio) AS Total_Gastado
FROM Cliente cl
INNER JOIN Recibos r
ON cl.Clie_Id = r.Clie_Id
INNER JOIN Empleados e
ON r.EmpI_Id = e.Empl_Id
INNER JOIN Tipo_pagos tp
ON r.Reci_tipo_pago = tp.Tipo_pago_Id
GROUP BY cl.Clie_Id, cl.Clie_Nombre, cl.Clie_correo, e.Empl_Id, e.Empl_nombre,
tp.Tipo_pago_Id, tp.Tipo_pago_nombre
HAVING SUM(r.Reci_monto_servicio) > (SELECT AVG(Total_Cliente)
    FROM (
        SELECT SUM(Reci_monto_servicio) AS Total_Cliente
        FROM Recibos
        GROUP BY Clie_Id) AS Promedio_Clientes)
ORDER BY Total_Gastado DESC;

#3 Servicios cuyos insumos tienen un precio mayor que el precio promedio de todos los insumos 
SELECT ci.Insu_nombre_categoria AS Categoria, i.Insu_nombre AS Insumo, i.Insu_precio AS Precio_Insumo,
s.Serv_nombre AS Servicio, s.Serv_precio AS Precio_Servicio
FROM Servicios s
INNER JOIN Insumos i
ON s.Serv_insumo_Id = i.Insu_Id
INNER JOIN Categoria_insumos ci
ON i.Insu_categoria_id = ci.Insu_categoria_id
INNER JOIN Cita c
ON s.Serv_Id = c.Cita_servicio
WHERE i.Insu_precio > (SELECT AVG(i2.Insu_precio)
    FROM Insumos i2)
GROUP BY ci.Insu_nombre_categoria
ORDER BY i.Insu_precio DESC;

#4 Insumos cuyo stock disponible sea menor que el stock promedio de todos los insumos 
SELECT ci.Insu_nombre_categoria AS Categoria, i.Insu_nombre AS Insumo, i.Insu_stock AS Stock_Disponible, i.Insu_precio AS Precio_Insumo,
s.Serv_nombre AS Servicio
FROM Insumos i
INNER JOIN Categoria_insumos ci
ON i.Insu_categoria_id = ci.Insu_categoria_id
INNER JOIN Servicios s
ON s.Serv_insumo_Id = i.Insu_Id
INNER JOIN Cita c
ON s.Serv_Id = c.Cita_servicio
WHERE i.Insu_stock < (SELECT AVG(i2.Insu_stock)
    FROM Insumos i2)
GROUP BY ci.Insu_nombre_categoria
ORDER BY i.Insu_stock ASC;

#5 Servicios que utilizan insumos pertenecientes a categorías que también están asociadas a otros insumos utilizados en servicios con citas registradas.
SELECT CONCAT('Servicio: ', s.Serv_nombre) AS Servicio, ci.Insu_nombre_categoria AS Categoria, i.Insu_nombre AS Insumo,
i.Insu_stock AS Stock, COUNT(c.Cita_Id) AS Citas_Registradas
FROM Servicios s
INNER JOIN Insumos i
ON s.Serv_insumo_Id = i.Insu_Id
INNER JOIN Categoria_insumos ci
ON i.Insu_categoria_id = ci.Insu_categoria_id
INNER JOIN Cita c
ON s.Serv_Id = c.Cita_servicio
WHERE i.Insu_categoria_id IN (SELECT DISTINCT i2.Insu_categoria_id
    FROM Insumos i2
    INNER JOIN Servicios s2
	ON s2.Serv_insumo_Id = i2.Insu_Id
    INNER JOIN Cita c2
	ON s2.Serv_Id = c2.Cita_servicio)
GROUP BY s.Serv_Id, s.Serv_nombre, ci.Insu_categoria_id, ci.Insu_nombre_categoria,
i.Insu_Id, i.Insu_nombre, i.Insu_stock
ORDER BY ci.Insu_nombre_categoria, Citas_Registradas DESC;

#6 Servicios cuyo precio está por encima del precio promedio
SELECT s.Serv_nombre AS Servicio, s.Serv_precio AS Precio_Servicio, i.Insu_nombre AS Insumo,
ci.Insu_nombre_categoria AS Categoria, COUNT(c.Cita_Id) AS Total_Citas
FROM Servicios s
INNER JOIN Insumos i
ON s.Serv_insumo_Id = i.Insu_Id
INNER JOIN Categoria_insumos ci
ON i.Insu_categoria_id = ci.Insu_categoria_id
INNER JOIN Cita c
ON s.Serv_Id = c.Cita_servicio
WHERE s.Serv_precio > (SELECT AVG(s2.Serv_precio)
    FROM Servicios s2)
GROUP BY s.Serv_Id, i.Insu_Id
ORDER BY s.Serv_precio DESC;

#7 Insumos cuyo stock está por debajo del promedio
SELECT ci.Insu_nombre_categoria AS Categoria, i.Insu_nombre AS Insumo, i.Insu_stock AS Stock,
s.Serv_nombre AS Servicio, COUNT(c.Cita_Id) AS Total_Citas
FROM Insumos i
INNER JOIN Categoria_insumos ci
ON i.Insu_categoria_id = ci.Insu_categoria_id
INNER JOIN Servicios s
ON s.Serv_insumo_Id = i.Insu_Id
INNER JOIN Cita c
ON s.Serv_Id = c.Cita_servicio
WHERE i.Insu_stock < (SELECT AVG(i2.Insu_stock)
FROM Insumos i2)
GROUP BY ci.Insu_categoria_id, i.Insu_Id, s.Serv_Id
ORDER BY i.Insu_stock ASC;

#8 Clientes que tienen más citas que el promedio
SELECT cl.Clie_Nombre AS Cliente, GROUP_CONCAT(DISTINCT s.Serv_nombre SEPARATOR ', ') AS Servicios, 
GROUP_CONCAT(DISTINCT e.Empl_nombre SEPARATOR ', ') AS Empleados, COUNT(c.Cita_Id) AS Total_Citas
FROM Cliente cl
INNER JOIN Cita c
ON cl.Clie_Id = c.Clie_Id
INNER JOIN Servicios s
ON c.Cita_servicio = s.Serv_Id
INNER JOIN Empleados e
ON c.Empl_acargo_Id = e.Empl_Id
GROUP BY cl.Clie_Id, cl.Clie_Nombre
HAVING COUNT(c.Cita_Id) > (SELECT AVG(Total_Citas)
    FROM (SELECT COUNT(Cita_Id) AS Total_Citas
        FROM Cita
        GROUP BY Clie_Id) AS Promedio_Clientes)
ORDER BY Total_Citas DESC;

#9 Servicios cuyo precio es superior al promedio de su categoría de servicio.
SELECT s.Serv_nombre AS Servicio, s.Serv_duracion AS Duracion_Minutos, i.Insu_nombre AS Insumo,
ci.Insu_nombre_categoria AS Categoria, COUNT(c.Cita_Id) AS Total_Citas
FROM Servicios s
INNER JOIN Insumos i
ON s.Serv_insumo_Id = i.Insu_Id
INNER JOIN Categoria_insumos ci
ON i.Insu_categoria_id = ci.Insu_categoria_id
INNER JOIN Cita c
ON s.Serv_Id = c.Cita_servicio
WHERE s.Serv_duracion > (SELECT AVG(s2.Serv_duracion)
    FROM Servicios s2)
GROUP BY s.Serv_Id, i.Insu_Id

ORDER BY s.Serv_duracion DESC;

#10 Insumos cuyo precio está por encima del promedio de su categoría
SELECT ci.Insu_nombre_categoria AS Categoria, i.Insu_nombre AS Insumo, i.Insu_precio AS Precio_Insumo,
s.Serv_nombre AS Servicio, COUNT(c.Cita_Id) AS Total_Citas
FROM Insumos i
INNER JOIN Categoria_insumos ci
ON i.Insu_categoria_id = ci.Insu_categoria_id
INNER JOIN Servicios s
ON s.Serv_insumo_Id = i.Insu_Id
INNER JOIN Cita c
ON s.Serv_Id = c.Cita_servicio
WHERE i.Insu_precio > (SELECT AVG(i2.Insu_precio)
    FROM Insumos i2
    WHERE i2.Insu_categoria_id = i.Insu_categoria_id)
GROUP BY ci.Insu_categoria_id, i.Insu_Id, s.Serv_Id
ORDER BY i.Insu_precio DESC;

#11 Insumos cuyo precio está por encima del promedio general
SELECT ci.Insu_nombre_categoria AS Categoria, i.Insu_nombre AS Insumo, i.Insu_precio AS Precio_Insumo,
s.Serv_nombre AS Servicio, COUNT(c.Cita_Id) AS Total_Citas
FROM Insumos i
INNER JOIN Categoria_insumos ci
ON i.Insu_categoria_id = ci.Insu_categoria_id
INNER JOIN Servicios s
ON s.Serv_insumo_Id = i.Insu_Id
INNER JOIN Cita c
ON s.Serv_Id = c.Cita_servicio
WHERE i.Insu_precio > (SELECT AVG(i2.Insu_precio)
    FROM Insumos i2)
GROUP BY ci.Insu_categoria_id, i.Insu_Id, s.Serv_Id
ORDER BY i.Insu_precio DESC;
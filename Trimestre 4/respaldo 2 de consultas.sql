#Consultas 

#1 Mostrar el detalle de cada cita, incluyendo cliente, servicio, empleado, fecha y hora.
SELECT  c.Cita_Id, c.Cita_fecha, c.Cita_hora, c.Cita_estado, cl.Clie_Nombre AS Cliente, s.Serv_nombre AS Servicio, e.Empl_nombre AS Empleado
FROM Cita c
INNER JOIN Cliente cl 
ON c.Clie_Id = cl.Clie_Id
INNER JOIN Servicios s 
ON c.Cita_servicio = s.Serv_Id
INNER JOIN Empleados e 
ON c.Empl_acargo_Id = e.Empl_Id
GROUP BY c.cita_Id;

#2 Mostrar las citas agrupadas por categoría de servicio.
SELECT c.Cita_Id, c.Cita_fecha, c.Cita_hora, cl.Clie_Nombre AS Cliente, s.Serv_nombre AS Servicio, cs.serv_nombre_categoria AS Categoria
FROM Cita c
INNER JOIN Cliente cl
ON c.Clie_Id = cl.Clie_Id
INNER JOIN Servicios s
ON c.Cita_servicio = s.Serv_Id
INNER JOIN Categoria_servicios cs
ON s.Serv_categoria_Id = cs.serv_Categoria_Id
GROUP BY c.cita_Id;

#3 Mostrar la cantidad de citas asignadas a cada empleado.
SELECT e.Empl_nombre AS Empleado, COUNT(c.Cita_Id) AS Total_Citas, COUNT(DISTINCT cl.Clie_Id) AS Clientes_Atendidos, s.Serv_nombre AS Servicio
FROM Empleados e
INNER JOIN Cita c
ON e.Empl_Id = c.Empl_acargo_Id
INNER JOIN Servicios s
ON c.Cita_servicio = s.Serv_Id
INNER JOIN Cliente cl
ON c.Clie_Id = cl.Clie_Id
GROUP BY e.Empl_Id, e.Empl_nombre, s.Serv_Id, s.Serv_nombre
ORDER BY Total_Citas DESC;


#4 Mostrar los ingresos generados por los servicios registrados.
SELECT e.Empl_nombre AS Empleado, tp.Tipo_pago_nombre AS Tipo_Pago, COUNT(r.Reci_numero) AS Cantidad_Recibos, 
SUM(r.Reci_monto_servicio) AS Total_Ingresos, cl.Clie_Nombre AS Cliente
FROM Empleados e
INNER JOIN Recibos r
ON e.Empl_Id = r.EmpI_Id
INNER JOIN Cliente cl
ON r.Clie_Id = cl.Clie_Id
INNER JOIN Tipo_pagos tp
ON r.Reci_tipo_pago = tp.Tipo_pago_Id
GROUP BY e.Empl_Id, e.Empl_nombre, tp.Tipo_pago_Id, tp.Tipo_pago_nombre,
cl.Clie_Id, cl.Clie_Nombre
ORDER BY Total_Ingresos DESC;

#5 Mostrar un resumen de cada cita con la información principal.
SELECT c.Cita_Id, CONCAT('Cliente: ', cl.Clie_Nombre, ' / Servicio: ', s.Serv_nombre) AS Resumen_Cita,
CONCAT('Empleado: ', e.Empl_nombre) AS Empleado, c.Cita_fecha, c.Cita_hora, c.Cita_estado
FROM Cita c
INNER JOIN Cliente cl
ON c.Clie_Id = cl.Clie_Id
INNER JOIN Servicios s
ON c.Cita_servicio = s.Serv_Id
INNER JOIN Empleados e
ON c.Empl_acargo_Id = e.Empl_Id
ORDER BY c.Cita_fecha, c.Cita_hora;

#6 Mostrar la cantidad de citas registradas en cada mes.
SELECT MONTH(c.Cita_fecha) AS Mes, s.Serv_nombre AS Servicio, e.Empl_nombre AS Empleado, 
COUNT(c.Cita_Id) AS Total_Citas,  COUNT(DISTINCT cl.Clie_Id) AS Clientes
FROM Cita c
INNER JOIN Cliente cl
ON c.Clie_Id = cl.Clie_Id
INNER JOIN Servicios s
ON c.Cita_servicio = s.Serv_Id
INNER JOIN Empleados e
ON c.Empl_acargo_Id = e.Empl_Id
GROUP BY MONTH(c.Cita_fecha), s.Serv_Id, s.Serv_nombre, e.Empl_Id, e.Empl_nombre
ORDER BY Mes;

#7 Mostrar los datos principales de las citas en mayúsculas.
SELECT c.Cita_Id, UPPER(cl.Clie_Nombre) AS Cliente, UPPER(s.Serv_nombre) AS Servicio, UPPER(e.Empl_nombre) AS Empleado,
UPPER(c.Cita_estado) AS Estado, c.Cita_fecha, c.Cita_hora
FROM Cita c
INNER JOIN Cliente cl
ON c.Clie_Id = cl.Clie_Id
INNER JOIN Servicios s
ON c.Cita_servicio = s.Serv_Id
INNER JOIN Empleados e
ON c.Empl_acargo_Id = e.Empl_Id
ORDER BY c.Cita_fecha, c.Cita_hora;

#8 Mostrar los ingresos según el año y el tipo de pago.
SELECT YEAR(r.Reci_fecha_hora_emision) AS Año, tp.Tipo_pago_nombre AS Tipo_Pago, COUNT(r.Reci_numero) AS Cantidad_Recibos,
SUM(r.Reci_monto_servicio) AS Total_Ingresos, COUNT(DISTINCT cl.Clie_Id) AS Clientes_Distintos
FROM Recibos r
INNER JOIN Tipo_pagos tp
ON r.Reci_tipo_pago = tp.Tipo_pago_Id
INNER JOIN Cliente cl
ON r.Clie_Id = cl.Clie_Id
INNER JOIN Empleados e
ON r.EmpI_Id = e.Empl_Id
GROUP BY YEAR(r.Reci_fecha_hora_emision), tp.Tipo_pago_Id, tp.Tipo_pago_nombre
ORDER BY Año, Total_Ingresos DESC;

#9 Mostrar los insumos relacionados con cada servicio y sus datos principales.
SELECT ci.Insu_nombre_categoria AS Categoria, i.Insu_nombre AS Insumo, i.Insu_unidad AS Unidad,
i.Insu_stock AS Stock, s.Serv_nombre AS Servicio
FROM Categoria_insumos ci
INNER JOIN Insumos i
ON ci.Insu_categoria_id = i.Insu_categoria_id
INNER JOIN Servicios s
ON s.Serv_insumo_Id = i.Insu_Id
INNER JOIN Cita c
ON s.Serv_Id = c.Cita_servicio
ORDER BY Categoria, Insumo;

#10 Mostrar los insumos agrupados por categoría y servicio.
SELECT ci.Insu_nombre_categoria AS Categoria, i.Insu_nombre AS Insumo, i.Insu_precio AS Precio_Insumo,
i.Insu_stock AS Stock_Disponible, s.Serv_nombre AS Servicio, s.Serv_precio AS Precio_Servicio
FROM Categoria_insumos ci
INNER JOIN Insumos i
ON ci.Insu_categoria_id = i.Insu_categoria_id
INNER JOIN Servicios s
ON s.Serv_insumo_Id = i.Insu_Id
INNER JOIN Cita c
ON s.Serv_Id = c.Cita_servicio
GROUP BY ci.insu_nombre_categoria
ORDER BY i.Insu_precio DESC;






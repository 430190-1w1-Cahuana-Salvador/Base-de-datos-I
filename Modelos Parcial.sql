-- TEMA 1

-- 1. En una misma tabla de resultados, 
-- se quiere ver los responsables que no trabajaron el mes pasado 
-- y por otro lado los responsables de aquellas órdenes de producción, 
-- del mes pasado, cuyas cantidades superan las 100 unidades. 
-- Agregar una columna que los identifique, ordenar convenientemente y
-- listar los responsables sin repeticiones.

SELECT id_responsable,
	nombre,
	apelido
FROM responsables AS R
WHERE id_responsable NOT IN
	(
	SELECT id_responsables
	FROM ordenes AS O
	WHERE DATEDIFF(MONTH, O.fecha, GETDATE()) = 1
	)

UNION

SELECT DISTINCT id_responsable,
	nombre,
	apelido
FROM responsables AS R
	JOIN ordenes AS O
		ON R.id_responsable = O.id_responsable
WHERE DATEDIFF(MONTH, fecha, GETDATE()) = 1
	AND R.id_responsable = id_responsable

-- TEMA 2

-- 1. Listar los productos que hayan tenido más de 10 órdenes de fabricación el
-- mes pasado.

SELECT P.id_producto AS [Código],
	P.descripcion AS [Producto],
	COUNT(O.id_orden) AS [Cantidad de órdenes]

FROM Ordenes AS O
	JOIN Productos AS P
		ON O.id_producto = P.id_producto

WHERE DATEDIFF(MONTH, O.fecha_fab, GETDATE()) = 1

GROUP BY P.id_producto,
	P.descripcion

HAVING COUNT(O.id_orden) > 10

-- 2. En una misma tabla de resultados se quiere mostrar 
-- la cantidad de órdenes de producción que se ejecutaron,
-- la mayor cantidad producida
-- y el costo total de las órdenes correspondiente al mes en curso en primer lugar
-- y las del año en curso en 2do lugar

SELECT 'Mes actual' AS [Período],
	COUNT(id_orden) AS [Cant. Ord.],
	MAX(cantidad) AS [Mayor Cant. Prod.],
	SUM(costo_total) AS [Costo Total]
FROM Ordenes
WHERE MONTH(fecha_fab) = MONTH(GETDATE())

UNION

SELECT 'Año actual' AS 'Período',
	COUNT(id_orden),
	MAX(cantidad),
	SUM(costo_total)
FROM Ordenes
WHERE YEAR(fecha_fab) = YEAR(GETDATE())

-- 3. Emitir un listado que muestre, por mes y por producto,
-- los costos totales,
-- cantidad de órdenes de producción,
-- el promedio de las cantidades producidas,
-- siempre que el tipo de producto comience con letras que van de a “P” a la “S”
-- y que la máxima cantidad producida (por mes y por producto) haya sido menor a 800

SELECT YEAR(O.fecha_fab) AS [Año],
	MONTH(O.fecha_fab) AS [Mes],
	P.descripcion AS [Producto],
	SUM(costo_total) AS [Costos Totales],
	COUNT(id_orden) AS [Cantidad de Órdenes],
	AVG(O.cantidad) AS [Promedio de Cantidades Producidas]
FROM Ordenes AS O
	JOIN Productos AS P
		ON O.id_producto = P.id_producto
	JOIN Tipos AS T
		ON P.id_tipo = T.id_tipo
WHERE T.tipo LIKE '[P-S]%'
GROUP BY YEAR(O.fecha_fab),
	MONTH(O.fecha_fab),
	P.id_producto,
	P.descripcion
HAVING MAX(cantidad) < 800
ORDER BY [Año],
	[Mes]

-- 4. Se quiere saber cuánto es el costo total
-- y la cantidad total
-- de unidades producidas por sección y por turno
-- en el mes en curso
-- siempre que el promedio de esas cantidades (por sección y por turno) sea menor
-- al promedio de las cantidades de esa sección en todas las órdenes de la base de datos.

SELECT S.seccion AS [Sección],
	T.turno AS [Turno],
	SUM(O.costo_total) AS [Costo Total],
	SUM(O.cantidad) AS [Cantidad Total]
FROM Ordenes AS O
	JOIN Secciones AS S
		ON O.id_seccion = S.id_seccion
	JOIN Turnos AS T
		ON O.id_turno = T.id_turno
WHERE MONTH(O.fecha_fab) = MONTH(GETDATE())
	AND YEAR(O.fecha_fab) = YEAR(GETDATE())	
GROUP BY S.id_seccion,
	S.seccion,
	T.id_turno,
	T.turno
HAVING AVG(O.cantidad) < 
	(
	SELECT AVG(O1.cantidad)
	FROM Ordenes AS O1
	WHERE O1.id_seccion = O.id_seccion --es mejor con S.id_seccion
	)
ORDER BY 1, 2

-- 5. Crear una vista que muestre
-- el costo mensual promedio (promedio ponderado)
-- de cada unidad de producto
-- en los últimos 12 meses sin contar el actual.
-- Consulte la vista anterior 
-- y muestre el margen de ganancia de cada producto
-- respecto a los costos unitarios
-- del mes pasado
-- y el precio de venta de cada producto.

CREATE VIEW tema2_punto5 AS
SELECT MONTH(fecha_fab) AS [Mes],
	YEAR(fecha_fab) AS [Año],
	SUM(costo_total) / SUM(cantidad) AS [Costo Promedio]
FROM ordenes AS O
	JOIN productos AS P
		ON O.id_producto = P.id_producto
WHERE DATEDIFF(MONTH, fecha_fab, GETDATE()) BETWEEN 1 AND 12
GROUP BY id_producto,
	descripcion,
	MONTH(fecha_fab),
	YEAR(fecha_fab)

SELECT precio_venta - [Costo Promedio] AS [Ganancia Bruta]
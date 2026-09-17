-- Unidad 02 -- SUBCONSULTAS --

-- Subconsultas en el WHERE

-- X. Listar los artículos con precio mayor al promedio
-- y cuyo stock sea mayor al promedio del stock
-- y su descripción comience con letras de la "A" a la "M"

SELECT *
FROM articulos
WHERE pre_unitario > (SELECT AVG(pre_unitario) FROM articulos)
	AND stock > (SELECT AVG(stock) FROM articulos)
	AND descripcion LIKE '[A-M]%'
ORDER BY pre_unitario ASC

-- X. Listar los vendedores que vendieron artículos a precios mayores al promedio
-- (teniendo en cuenta la cantidad vendida)



-- Problema 2.1: Subconsultas en el Where

-- 2. Emitir un listado de los artículos que no fueron vendidos este año. En ese
-- listado solo incluir aquellos cuyo precio unitario del artículo oscile entre 50 y 100.

SELECT cod_articulo AS 'Código',
	descripcion AS 'Descripción',
	pre_unitario AS 'Precio'
FROM articulos
WHERE cod_articulo NOT IN (SELECT cod_articulo
							FROM facturas AS F
								JOIN detalle_facturas AS DF
									ON F.nro_factura = DF.nro_factura
							WHERE YEAR(F.fecha) = YEAR(GETDATE()) - 2)
	AND pre_unitario BETWEEN 50 AND 2000

-- Resolución con test de existencia:

SELECT A.cod_articulo AS 'Código',
	A.descripcion AS 'Descripción',
	A.pre_unitario AS 'Precio'
FROM articulos AS A
WHERE cod_articulo NOT IN (SELECT cod_articulo
							FROM facturas AS F
								JOIN detalle_facturas AS DF
									ON F.nro_factura = DF.nro_factura
							WHERE YEAR(F.fecha) = YEAR(GETDATE()) - 2
							AND DF.cod_articulo = A.cod_articulo) -- referencia externa
	AND pre_unitario BETWEEN 50 AND 2000

-- 3. Genere un reporte con los clientes que vinieron más de 2 veces el año pasado.

SELECT C.cod_cliente AS 'Código',
	C.ape_cliente + ' ' + C.nom_cliente AS 'Cliente'
FROM clientes AS C
WHERE 2 < (SELECT COUNT(*)
			FROM facturas AS F
			WHERE YEAR(fecha) = YEAR(GETDATE()) - 1 -- del año pasado
				AND F.cod_cliente = C.cod_cliente) -- referencia externa / NO ES JOIN

-- 4. Se quiere saber qué clientes no vinieron entre el 12/12/2015 y el 13/7/2020



-- 6. Mostrar los datos de las facturas para los casos en que por año se hayan hecho
-- menos de 9 facturas.

SELECT F.nro_factura,
	FORMAT(fecha, 'MM - MMMM - yyy', 'es-ES') AS 'Fecha'
FROM facturas AS F
WHERE 9 > (SELECT COUNT(*)
			FROM facturas AS F1
			WHERE year(F.fecha) = YEAR(F1.fecha))
ORDER BY YEAR(fecha)

-- 7. Emitir un reporte con las facturas cuyo importe total haya sido superior a 1.500
-- (incluir en el reporte los datos de los artículos vendidos y los importes).

SELECT F.nro_factura AS 'Factura',
	FORMAT(fecha, 'MM - MMMM - yyy', 'es-ES') AS 'Fecha',
	cantidad * A.pre_unitario AS 'Importe',
	descripcion AS 'Artículo'
FROM facturas AS F
	JOIN detalle_facturas AS DF
		ON F.nro_factura = DF.nro_factura
	JOIN articulos AS A
		ON DF.cod_articulo = A.cod_articulo
WHERE 1500 < (SELECT SUM(cantidad * pre_unitario) 
				FROM detalle_facturas AS DF1
				WHERE F.nro_factura = DF1.nro_factura)

-- Subconsultas en la cláusula HAVING

-- Problema 2.2: Subconsultas en el Having

-- 8. Realice un informe que muestre cuánto fue el total anual facturado por cada vendedor,
-- para los casos en que el nombre de vendedor no comience con ‘B’ ni con ‘M’, que los
-- números de facturas oscilen entre 5 y 25 y que el promedio del monto facturado sea
-- inferior al promedio de ese año.

SELECT YEAR(F.fecha) AS 'Fecha',
	V.cod_vendedor AS 'Código',
	V.ape_vendedor + ' ' + V.nom_vendedor AS 'Vendedor',
	SUM(DF.cantidad * DF.pre_unitario) AS 'Total'
FROM facturas AS F
	JOIN detalle_facturas AS DF
		ON F.nro_factura = DF.nro_factura
	JOIN vendedores AS V
		ON F.cod_vendedor = V.cod_vendedor
WHERE nom_vendedor NOT LIKE '[B, M]%'
	AND F.nro_factura BETWEEN 5 AND 25
GROUP BY YEAR(F.fecha),
	V.cod_vendedor,
	V.ape_vendedor + ' ' + V.nom_vendedor--,
	--SUM(DF.cantidad * DF.pre_unitario)
HAVING AVG(DF.cantidad * DF.pre_unitario) <
	(
	SELECT AVG(DF1.cantidad * DF1.pre_unitario)
	FROM facturas AS F1
	JOIN detalle_facturas AS DF1
		ON F1.nro_factura = DF1.nro_factura
	WHERE YEAR(F1.fecha) = YEAR(F.fecha)
	)


-- Problema 2.3: Otras Subconsultas



--a



-- 



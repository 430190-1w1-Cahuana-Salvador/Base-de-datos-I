USE LIBRERIA_2026_BDI

-- Problema 3.1: Introducción a la Programación en SQL Server --

/*
1. Declarar 3 variables que se llamen codigo, stock y stockMinimo respectivamente.
A la variable codigo setearle un valor. Las variables stock y stockMinimo almacenarán
el resultado de las columnas de la tabla artículos stock y stockMinimo respectivamente
filtradas por el código que se corresponda con la variable codigo.
*/

DECLARE @codigo INT,
    @stock INT,
    @stockMinimo INT;

SET @codigo = 4;

SELECT @stock = stock,
    @stockMinimo = stock_minimo
FROM articulos
WHERE cod_articulo = @codigo

PRINT 'Código = ' + LTRIM(STR(@codigo));
PRINT 'Stock = ' + LTRIM(STR(@stock));
PRINT 'Stock Mínimo' + LTRIM(STR(@stockMinimo));

/*
2. Utilizando el punto anterior, verificar si la variable stock o stockMinimo tienen algún
valor. Mostrar un mensaje indicando si es necesario realizar reposición de artículos o no.
*/

IF @stock = NULL AND @stockMinimo = NULL

    BEGIN
        SELECT 'No hay valores.'
    END

ELSE
	
	BEGIN

	    SELECT 'Sí hay valores.'

		IF @stock < @stockMinimo
			SELECT 'Realizar Reposicion.'
		ELSE
			SELECT 'No Realizar Reposicion'

	END

/*
3. Modificar el ejercicio 1 agregando una variable más donde se almacene el precio del
artículo. En caso que el precio sea menor a $500, aplicarle un incremento del 10%. En caso
de que el precio sea mayor a $500 notificar dicha situación y mostrar el precio del artículo.
*/

DECLARE @precio INT;

SELECT @precio = pre_unitario
FROM articulos
WHERE cod_articulo = @codigo

IF @precio < 500

    BEGIN
        SET @precio = @precio * 1.1
        SELECT 'Precio Actualizado = ' + LTRIM(STR(@precio))
    END

ELSE
	
	IF @precio = 500
		SELECT 'Precio = 500'
    ELSE
		SELECT 'Precio = ' + LTRIM(STR(@precio))

/*
4. Declarar dos variables enteras, y mostrar la suma de todos los números comprendidos entre
ellos. En caso de ser ambos números iguales mostrar un mensaje informando dicha situación.
*/

DECLARE @min INT = 10,
    @max INT = 15;

DECLARE @cont INT = @min,
    @suma INT = @min;

WHILE @cont < @max

    BEGIN
        SET @cont = @cont + 1
        SET @suma = @suma + @cont
        SELECT @suma
    END

PRINT @suma

/*
5. Mostrar nombre y precio de todos los artículos. Mostrar en una tercer columna la leyenda
‘Muy caro’ para precios mayores a $500, ‘Accesible’ para precios entre $300 y $500, ‘Barato’
para precios entre $100 y $300 y ‘Regalado’ para precios menores a $100.
*/



/*
6. Modificar el punto 2 reemplazando el mensaje de que es necesario reponer
artículos por una excepción.
*/



-- Problema 3.2: Procedimientos Almacenados --

/*
1. Cree los siguientes SP:

	a. Detalle_Ventas: liste la fecha, la factura, el vendedor, el cliente, el artículo,
	cantidad e importe. Este SP recibirá como parámetros de E un rango de fechas.

	b. CantidadArt_Cli : este SP me debe devolver la cantidad de artículos o
	clientes (según se pida) que existen en la empresa.
	
	c. INS_Vendedor: Cree un SP que le permita insertar registros en la tabla vendedores.
	
	d. UPD_Vendedor: cree un SP que le permita modificar un vendedor cargado.
	
	e. DEL_Vendedor: cree un SP que le permita eliminar un vendedor ingresado.
*/

-- a



-- b



-- c



-- d



-- e



/*
2. Modifique el SP 1-a, permitiendo que los resultados del SP puedan filtrarse por una
fecha determinada, por un rango de fechas y por un rango de vendedores; según se pida.
*/



/*
3. Ejecute los SP creados en el punto 1 (todos).
*/



/*
4. Elimine los SP creados en el punto 1.
*/



/*
5. Programar procedimientos almacenados que permitan realizar las siguientes
tareas:

	a. Mostrar los artículos cuyo precio sea mayor o igual que un valor que se
	envía por parámetro.
	
	b. Ingresar un artículo nuevo, verificando que la cantidad de stock que se
	pasa por parámetro sea un valor mayor a 30 unidades y menor que 100.
	Informar un error caso contrario.
	
	c. Mostrar un mensaje informativo acerca de si hay que reponer o no stock
	de un artículo cuyo código sea enviado por parámetro
	
	d. Actualizar el precio de los productos que tengan un precio menor a uno
	ingresado por parámetro en un porcentaje que también se envíe por
	parámetro. Si no se modifica ningún elemento informar dicha situación
	
	e. Mostrar el nombre del cliente al que se le realizó la primer venta en un
	parámetro de salida.
	
	f. Realizar un select que busque el artículo cuyo nombre empiece con un
	valor enviado por parámetro y almacenar su nombre en un parámetro de 
	salida. En caso que haya varios artículos ocurrirá una excepción que
	deberá ser manejada con try catch.
*/

-- a



-- b



-- c



-- d



-- e



-- f



-- Problema 3.3: Funciones definidas por el usuario --

/*
6. Cree las siguientes funciones:

	a. Hora: una función que les devuelva la hora del sistema en el formato
	HH:MM:SS (tipo carácter de 8).
	
	b. Fecha: una función que devuelva la fecha en el formato AAAMMDD (en carácter de 8),}
	a partir de una fecha que le ingresa como parámetro (ingresa como tipo fecha).
	
	c. Dia_Habil: función que devuelve si un día es o no hábil (considere como
	días no hábiles los sábados y domingos). Debe devolver 1 (hábil), 0 (no hábil)

*/

-- a



-- b



-- c



/*
7. Modifique la f(x) 1.c, considerando solo como día no hábil el domingo.
*/



/*
8. Ejecute las funciones creadas en el punto 1 (todas).
*/



/*
9. Elimine las funciones creadas en el punto 1.
*/



/*
10. Programar funciones que permitan realizar las siguientes tareas:

	a. Devolver una cadena de caracteres compuesto por los siguientes datos:
	Apellido, Nombre, Telefono, Calle, Altura y Nombre del Barrio, de un
	determinado cliente, que se puede informar por codigo de cliente o email.
	
	b. Devolver todos los artículos, se envía un parámetro que permite ordenar
	el resultado por el campo precio de manera ascendente (‘A’), o descendente (‘D’).
	
	c. Crear una función que devuelva el precio al que quedaría un artículo en
	caso de aplicar un porcentaje de aumento pasado por parámetro.
*/

-- a



-- b



-- c



-- Problema 3.4: Triggers --

/*
1. Crear un desencadenador para las siguientes acciones:

	a. Restar stock DESPUES de INSERTAR una VENTA
	
	b. Para no poder modificar el nombre de algún artículo
	
	c. Insertar en la tabla HistorialPrecio el precio anterior de un artículo si el
	mismo ha cambiado
	
	d. Bloquear al vendedor con código 4 para que no pueda registrar ventas
	en el sistema.
*/

-- a



-- b



-- c



-- d



-- Problema 3.5: Manejo de errores --

/*
1. Modificar el ejercicio 2 del problema 3.1 reemplazando los mensajes mostrados en consola
con print, por excepciones. Verificar el comportamiento en el SQL Server Management.
*/



/*
2. Modificar el ejercicio anterior agregando las cláusulas de try catch para manejo
de errores, y mostrar el mensaje capturado en la excepción con print.
*/


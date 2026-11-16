/* =====================================================================
   03_insert.sql  -  CineDB  (Fase 3: datos de prueba)
   - 50 registros en cada una de las 10 tablas.
   - Orden: Pelicula, Sala, Asiento, Empleado, Cliente, Funcion,
            Boleto, Producto, Venta, DetalleVenta  (respeta las FK).
   - Todo corre en UNA transaccion: si algo falla, no queda nada a medias.
   - Se niega a ejecutarse si las tablas ya tienen datos (evita duplicados).
   - Datos ficticios; sin acentos ni enie a proposito (evita problemas de
     codificacion en columnas VARCHAR).
   ===================================================================== */
USE CineDB;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRY

    /* ---- Guarda no destructiva -----------------------------------------
       Si alguna tabla ya tiene datos, se omiten TODOS los INSERT para evitar
       duplicados y conservar la informacion existente. No se borra nada.
       ------------------------------------------------------------------- */
    IF EXISTS (SELECT 1 FROM Pelicula)  OR EXISTS (SELECT 1 FROM Sala)
    OR EXISTS (SELECT 1 FROM Asiento)   OR EXISTS (SELECT 1 FROM Empleado)
    OR EXISTS (SELECT 1 FROM Cliente)   OR EXISTS (SELECT 1 FROM Funcion)
    OR EXISTS (SELECT 1 FROM Boleto)    OR EXISTS (SELECT 1 FROM Producto)
    OR EXISTS (SELECT 1 FROM Venta)     OR EXISTS (SELECT 1 FROM DetalleVenta)
    BEGIN
        PRINT 'AVISO: Se omitieron los INSERT porque al menos una tabla ya contiene datos. No se elimino ni modifico ningun registro por esta seccion.';
    END
    ELSE
    BEGIN

    /* ---- Listas auxiliares para generar nombres ---------------------- */
    DECLARE @N TABLE (n INT PRIMARY KEY, nombre VARCHAR(30));
    INSERT INTO @N (n, nombre) VALUES
    (1,'Alejandro'),(2,'Maria'),(3,'Carlos'),(4,'Ana'),(5,'Luis'),
    (6,'Fernanda'),(7,'Jorge'),(8,'Gabriela'),(9,'Miguel'),(10,'Sofia'),
    (11,'Ricardo'),(12,'Daniela'),(13,'Javier'),(14,'Valeria'),(15,'Eduardo'),
    (16,'Paola'),(17,'Roberto'),(18,'Karla'),(19,'Daniel'),(20,'Andrea'),
    (21,'Diego'),(22,'Mariana'),(23,'Hector'),(24,'Laura'),(25,'Oscar'),
    (26,'Monica'),(27,'Raul'),(28,'Claudia'),(29,'Sergio'),(30,'Patricia'),
    (31,'Armando'),(32,'Lucia'),(33,'Manuel'),(34,'Rosa'),(35,'Pablo'),
    (36,'Elena'),(37,'Fernando'),(38,'Isabel'),(39,'Adrian'),(40,'Carmen'),
    (41,'Ivan'),(42,'Teresa'),(43,'Gerardo'),(44,'Veronica'),(45,'Emilio'),
    (46,'Julia'),(47,'Rafael'),(48,'Alicia'),(49,'Esteban'),(50,'Beatriz');

    DECLARE @A TABLE (n INT PRIMARY KEY, apellido VARCHAR(30));
    INSERT INTO @A (n, apellido) VALUES
    (1,'Hernandez'),(2,'Garcia'),(3,'Martinez'),(4,'Lopez'),(5,'Gonzalez'),
    (6,'Rodriguez'),(7,'Perez'),(8,'Sanchez'),(9,'Ramirez'),(10,'Flores'),
    (11,'Gomez'),(12,'Diaz'),(13,'Cruz'),(14,'Morales'),(15,'Reyes'),
    (16,'Torres'),(17,'Gutierrez'),(18,'Ortiz'),(19,'Ramos'),(20,'Mendoza'),
    (21,'Castillo'),(22,'Vazquez'),(23,'Jimenez'),(24,'Ruiz'),(25,'Aguilar'),
    (26,'Medina'),(27,'Rojas'),(28,'Herrera'),(29,'Silva'),(30,'Castro'),
    (31,'Vargas'),(32,'Romero'),(33,'Salazar'),(34,'Guerrero'),(35,'Navarro'),
    (36,'Dominguez'),(37,'Ortega'),(38,'Delgado'),(39,'Soto'),(40,'Cortes'),
    (41,'Fuentes'),(42,'Rios'),(43,'Campos'),(44,'Pena'),(45,'Cabrera'),
    (46,'Luna'),(47,'Santiago'),(48,'Valdez'),(49,'Estrada'),(50,'Maldonado');

    BEGIN TRANSACTION;

    /* ================= 1) PELICULA (50) ================================ */
    INSERT INTO Pelicula (titulo, duracionMinutos, clasificacion) VALUES
    ('Intensamente 2',96,'AA'),
    ('Coco',105,'AA'),
    ('Toy Story 4',100,'AA'),
    ('Moana 2',100,'AA'),
    ('Encanto',102,'AA'),
    ('Elemental',101,'AA'),
    ('Zootopia',108,'A'),
    ('Super Mario Bros: La Pelicula',92,'AA'),
    ('Wonka',116,'A'),
    ('Barbie',114,'A'),
    ('El Gato con Botas: El Ultimo Deseo',102,'A'),
    ('Spider-Man: Across the Spider-Verse',140,'A'),
    ('Avatar: El Camino del Agua',192,'B'),
    ('Top Gun: Maverick',130,'B'),
    ('Dune: Parte Dos',166,'B'),
    ('Guardianes de la Galaxia Vol. 3',150,'B'),
    ('Mision Imposible: Sentencia Mortal',163,'B'),
    ('Aquaman y el Reino Perdido',124,'B'),
    ('Thor: Amor y Trueno',119,'B'),
    ('Doctor Strange en el Multiverso de la Locura',126,'B'),
    ('Black Panther: Wakanda por Siempre',161,'B'),
    ('Los Vengadores: Endgame',181,'B'),
    ('Jurassic World: Dominio',147,'B'),
    ('Fast X',141,'B'),
    ('Mufasa: El Rey Leon',118,'A'),
    ('Kung Fu Panda 4',94,'A'),
    ('Mi Villano Favorito 4',95,'AA'),
    ('Minions: El Origen de Gru',87,'AA'),
    ('Shrek 2',93,'A'),
    ('Frozen: El Reino del Hielo 2',103,'AA'),
    ('Deadpool y Wolverine',128,'C'),
    ('Joker',122,'C'),
    ('Oppenheimer',180,'B15'),
    ('Napoleon',158,'B15'),
    ('Gladiador II',148,'B15'),
    ('Interestelar',169,'B'),
    ('El Caballero de la Noche',152,'B'),
    ('Inception: El Origen',148,'B'),
    ('Parasitos',132,'B15'),
    ('Whiplash: Musica y Obsesion',106,'B15'),
    ('El Origen de los Guardianes',97,'A'),
    ('Coraline y la Puerta Secreta',100,'A'),
    ('Hereditario',127,'C'),
    ('Nosotros',116,'C'),
    ('Huye',104,'B15'),
    ('Smile: La Sonrisa del Diablo',115,'C'),
    ('El Conjuro 3',112,'C'),
    ('La Monja',96,'C'),
    ('Roma',135,'B15'),
    ('Y Tu Mama Tambien',106,'C');

    /* ================= 2) SALA (50) ==================================== */
    /* Salas 1 a 5: capacidad 10 (son las que tendran asientos en Asiento) */
    INSERT INTO Sala (nombreSala, capacidadTotal)
    SELECT 'Sala ' + RIGHT('0' + CAST(n AS VARCHAR(2)), 2),
           CASE WHEN n <= 5 THEN 10 ELSE 60 + (n % 6) * 20 END
    FROM @N
;

    /* ================= 3) ASIENTO (50) ================================= */
    /* 5 salas x 2 filas (A,B) x 5 asientos = 50 */
    ;WITH S  AS (SELECT TOP 5 idSala FROM Sala ORDER BY idSala),
          F  AS (SELECT 'A' AS fila UNION ALL SELECT 'B'),
          NU AS (SELECT 1 AS num UNION ALL SELECT 2 UNION ALL SELECT 3
                 UNION ALL SELECT 4 UNION ALL SELECT 5)
    INSERT INTO Asiento (idSala, fila, numeroAsiento)
    SELECT S.idSala, F.fila, NU.num
    FROM S CROSS JOIN F CROSS JOIN NU
;

    /* ================= 4) EMPLEADO (50) ================================ */
    INSERT INTO Empleado (nombre, correo, puesto, estatus)
    SELECT  X.nombre + ' ' + A1.apellido + ' ' + A2.apellido,
            LOWER(X.nombre + '.' + A1.apellido) + '@cinecentral.mx',
            CASE WHEN X.n <= 2  THEN 'Gerente'
                 WHEN X.n <= 22 THEN 'Taquillero'
                 WHEN X.n <= 42 THEN 'Dulceria'
                 WHEN X.n <= 46 THEN 'Proyeccionista'
                 ELSE 'Supervisor' END,
            CASE WHEN X.n IN (20, 40, 46, 50) THEN 'Inactivo' ELSE 'Activo' END
    FROM @N X
    JOIN @A A1 ON A1.n = X.n
    JOIN @A A2 ON A2.n = ((X.n + 24) % 50) + 1
;

    /* ================= 5) CLIENTE (50) ================================= */
    INSERT INTO Cliente (nombre, telefono, correo, tipoCliente)
    SELECT  Nm.nombre + ' ' + A1.apellido + ' ' + A2.apellido,
            '55' + CAST(10000000 + (X.n * 1234567) % 90000000 AS VARCHAR(8)),
            LOWER(Nm.nombre + '.' + A1.apellido) + CAST(X.n AS VARCHAR(2)) + '@correo.com',
            CASE WHEN X.n % 10 = 0 THEN 'VIP'
                 WHEN X.n % 5  = 0 THEN 'Frecuente'
                 ELSE 'Regular' END
    FROM @N X
    JOIN @N Nm ON Nm.n = ((X.n + 19) % 50) + 1
    JOIN @A A1 ON A1.n = ((X.n + 9)  % 50) + 1
    JOIN @A A2 ON A2.n = ((X.n + 33) % 50) + 1
;

    /* ================= 6) FUNCION (50) ================================= */
    /* Pelicula i -> sala ((i-1)%5)+1; una funcion por sala por dia, a partir
       del 20/nov/2026, horarios 14, 16, 18 o 20 h (sin traslapes). */
    ;WITH P AS (SELECT idPelicula, ROW_NUMBER() OVER (ORDER BY idPelicula) AS rn FROM Pelicula),
          S AS (SELECT idSala,     ROW_NUMBER() OVER (ORDER BY idSala)     AS rn FROM Sala)
    INSERT INTO Funcion (idPelicula, idSala, fechaHoraInicio, precioBoleto, observaciones)
    SELECT  P.idPelicula,
            S.idSala,
            DATEADD(HOUR, 14 + 2 * (P.rn % 4),
                    DATEADD(DAY, (P.rn - 1) / 5, CAST('20261120' AS DATETIME))),
            85 + (P.rn % 4) * 10,
            CASE WHEN P.rn % 10 = 0 THEN 'Funcion con subtitulos'
                 WHEN P.rn % 7  = 0 THEN 'Funcion especial de estreno'
                 ELSE NULL END
    FROM P
    JOIN S ON S.rn = ((P.rn - 1) % 5) + 1
;

    /* ================= 7) BOLETO (50) ================================== */
    /* Un boleto por funcion; el asiento SIEMPRE pertenece a la sala de la
       funcion y la compra es de 1 a 5 dias antes de que inicie. */
    ;WITH FN AS (SELECT idFuncion, idSala, fechaHoraInicio,
                        ROW_NUMBER() OVER (ORDER BY idFuncion) AS rn
                 FROM Funcion),
          SE AS (SELECT idAsiento, idSala,
                        ROW_NUMBER() OVER (PARTITION BY idSala ORDER BY idAsiento) AS k
                 FROM Asiento),
          CL AS (SELECT idCliente, ROW_NUMBER() OVER (ORDER BY idCliente) AS rn
                 FROM Cliente)
    INSERT INTO Boleto (idFuncion, idAsiento, idCliente, fechaCompra)
    SELECT  FN.idFuncion, SE.idAsiento, CL.idCliente,
            DATEADD(DAY, -((FN.rn % 5) + 1), FN.fechaHoraInicio)
    FROM FN
    JOIN SE ON SE.idSala = FN.idSala AND SE.k = ((FN.rn - 1) / 5) + 1
    JOIN CL ON CL.rn = FN.rn
;

    /* ================= 8) PRODUCTO (50) ================================ */
    INSERT INTO Producto (nombreProducto, precio, stock)
    SELECT v.nombre, v.precio, 40 + (LEN(v.nombre) * 7) % 90
    FROM (VALUES
    ('Palomitas Chicas',55),('Palomitas Medianas',75),('Palomitas Grandes',95),
    ('Palomitas Jumbo',115),('Palomitas Caramelo Medianas',85),('Palomitas Mantequilla Extra',90),
    ('Refresco Chico',40),('Refresco Mediano',50),('Refresco Grande',60),
    ('Refresco Jumbo',70),('Agua Natural 500ml',30),('Agua Mineral',45),
    ('Jugo de Naranja',45),('Te Helado',50),('Cafe Americano',40),
    ('Capuchino',55),('Chocolate Caliente',55),('Nachos con Queso',75),
    ('Nachos con Jalapenos',80),('Hot Dog Clasico',65),('Hot Dog Jumbo',85),
    ('Hamburguesa Sencilla',95),('Papas Fritas',60),('Churros 3 piezas',50),
    ('Pulparindo',15),('Chocolate Snickers',35),('Chocolate M&M',38),
    ('Gomitas Ositos',30),('Paleta de Hielo',25),('Helado de Vainilla',45),
    ('Helado de Chocolate',45),('Frappe Moka',75),('Malteada de Vainilla',70),
    ('Malteada de Fresa',70),('Combo Individual',120),('Combo Pareja',210),
    ('Combo Familiar',320),('Combo Infantil',130),('Combo Nachos Pareja',190),
    ('Pizza Personal',85),('Sandwich de Jamon',70),('Ensalada de Fruta',55),
    ('Yogurt con Granola',50),('Galletas Oreo',28),('Chicles',18),
    ('Cacahuates',22),('Papas Sabritas',30),('Doritos',30),
    ('Cheetos',28),('Barra de Granola',25)
    ) AS v(nombre, precio);

    /* ================= 9) VENTA (50) =================================== */
    /* Atendidas solo por empleados Activos del puesto Dulceria; fechas
       repartidas entre ago y nov 2026 (sirve para reportes por mes). */
    ;WITH EM AS (SELECT idEmpleado, ROW_NUMBER() OVER (ORDER BY idEmpleado) AS rn
                 FROM Empleado WHERE puesto = 'Dulceria' AND estatus = 'Activo'),
          CL AS (SELECT idCliente, ROW_NUMBER() OVER (ORDER BY idCliente) AS rn
                 FROM Cliente),
          T  AS (SELECT COUNT(*) AS c FROM EM)
    INSERT INTO Venta (idEmpleado, idCliente, fechaVenta)
    SELECT  EM.idEmpleado, CL.idCliente,
            DATEADD(MINUTE, (X.n * 37) % 600,
                    DATEADD(DAY, -(X.n * 2), CAST('20261114 12:00:00' AS DATETIME)))
    FROM @N X
    CROSS JOIN T
    JOIN EM ON EM.rn = ((X.n - 1) % T.c) + 1
    JOIN CL ON CL.rn = ((X.n * 3) % 50) + 1
;

    /* ================= 10) DETALLEVENTA (50) =========================== */
    /* Una linea por venta; subtotal = cantidad x precio del producto. */
    ;WITH VT AS (SELECT idVenta, ROW_NUMBER() OVER (ORDER BY idVenta) AS rn FROM Venta),
          PR AS (SELECT idProducto, precio, ROW_NUMBER() OVER (ORDER BY idProducto) AS rn FROM Producto)
    INSERT INTO DetalleVenta (idVenta, idProducto, cantidad, subtotal)
    SELECT  VT.idVenta, PR.idProducto, q.cant, q.cant * PR.precio
    FROM VT
    JOIN PR ON PR.rn = ((VT.rn * 7) % 50) + 1
    CROSS APPLY (SELECT (VT.rn % 4) + 1 AS cant) AS q
;

    COMMIT TRANSACTION;
    PRINT 'OK: se insertaron 50 registros en cada tabla.';
    END /* Fin del ELSE: las tablas estaban vacias */

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'ERROR (se hizo ROLLBACK, no se inserto nada): ' + ERROR_MESSAGE();
    THROW;
END CATCH
GO

/* ===================== VERIFICACION (ejecutar aparte) ================== */
SELECT 'Pelicula' AS tabla, COUNT(*) AS filas FROM Pelicula UNION ALL
SELECT 'Sala',         COUNT(*) FROM Sala         UNION ALL
SELECT 'Asiento',      COUNT(*) FROM Asiento      UNION ALL
SELECT 'Empleado',     COUNT(*) FROM Empleado     UNION ALL
SELECT 'Cliente',      COUNT(*) FROM Cliente      UNION ALL
SELECT 'Funcion',      COUNT(*) FROM Funcion      UNION ALL
SELECT 'Boleto',       COUNT(*) FROM Boleto       UNION ALL
SELECT 'Producto',     COUNT(*) FROM Producto     UNION ALL
SELECT 'Venta',        COUNT(*) FROM Venta        UNION ALL
SELECT 'DetalleVenta', COUNT(*) FROM DetalleVenta;

/* Integridad: ambos deben dar 0 */
SELECT COUNT(*) AS boletos_con_asiento_de_otra_sala
FROM Boleto b
JOIN Funcion f ON f.idFuncion = b.idFuncion
JOIN Asiento a ON a.idAsiento = b.idAsiento
WHERE a.idSala <> f.idSala;

SELECT COUNT(*) AS detalles_con_subtotal_incorrecto
FROM DetalleVenta d
JOIN Producto p ON p.idProducto = d.idProducto
WHERE d.subtotal <> d.cantidad * p.precio;
GO


/* =====================================================================
   FASE 3 - PARTE 2: ACTUALIZACIONES Y ELIMINACIONES (UPDATE / DELETE)
   Se usan condiciones para no modificar/eliminar todos los registros.
   La prueba de DELETE sobre una pelicula relacionada debe ser rechazada
   por la FK; despues se elimina un empleado inactivo sin ventas, si existe.
   ===================================================================== */

USE CineDB;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

/* UPDATE 1: clasificar hasta cinco clientes regulares como frecuentes. */
UPDATE Cliente
SET tipoCliente = 'Frecuente'
WHERE idCliente IN
(
    SELECT TOP (5) idCliente
    FROM Cliente
    WHERE tipoCliente = 'Regular'
    ORDER BY idCliente
);
PRINT 'UPDATE 1: clientes regulares seleccionados actualizados a Frecuente.';

/* UPDATE 2: aumentar el inventario del producto con menor existencia.
   No se modifica el precio para no alterar los subtotales historicos. */
UPDATE Producto
SET stock = stock + 10
WHERE idProducto =
(
    SELECT TOP (1) idProducto
    FROM Producto
    ORDER BY stock ASC, idProducto ASC
);
PRINT 'UPDATE 2: se agregaron 10 unidades al producto con menor stock.';
GO

/* DELETE 1: demostrar integridad referencial.
   La eliminacion debe fallar porque la pelicula tiene funciones asociadas.
   El error se captura para que el resto del archivo pueda continuar. */
DECLARE @PeliculaRelacionada INT;

SELECT TOP (1) @PeliculaRelacionada = p.idPelicula
FROM Pelicula AS p
INNER JOIN Funcion AS f ON f.idPelicula = p.idPelicula
ORDER BY p.idPelicula;

IF @PeliculaRelacionada IS NOT NULL
BEGIN
    BEGIN TRY
        DELETE FROM Pelicula
        WHERE idPelicula = @PeliculaRelacionada;

        PRINT 'ADVERTENCIA: se elimino una pelicula relacionada; revisa las FK.';
    END TRY
    BEGIN CATCH
        PRINT 'DELETE rechazado correctamente por integridad referencial: '
              + ERROR_MESSAGE();
    END CATCH;
END
ELSE
    PRINT 'No hay peliculas relacionadas con funciones para probar la FK.';
GO

/* DELETE 2: eliminar como maximo un empleado inactivo que no tenga ventas.
   Si el empleado esta referenciado en Venta, no se selecciona. */
DELETE TOP (1) FROM Empleado
WHERE estatus = 'Inactivo'
  AND NOT EXISTS
      (SELECT 1
       FROM Venta AS v
       WHERE v.idEmpleado = Empleado.idEmpleado);

PRINT 'DELETE 2: se elimino como maximo un empleado inactivo sin ventas.';
GO


/* =====================================================================
   FASE 3 - PARTE 3: PROBLEMARIO DE 30 CONSULTAS
   Ejecutar cada consulta y guardar una captura de sus resultados.
   ===================================================================== */

USE CineDB;
GO

/* 01. Mostrar todas las peliculas ordenadas alfabeticamente. */
SELECT idPelicula, titulo, duracionMinutos, clasificacion
FROM Pelicula
ORDER BY titulo;

/* 02. Buscar peliculas cuyo titulo contenga la palabra "Spider". */
SELECT idPelicula, titulo, duracionMinutos
FROM Pelicula
WHERE titulo LIKE '%Spider%'
ORDER BY titulo;

/* 03. Mostrar titulos en mayusculas y sus primeras 10 letras. */
SELECT titulo,
       UPPER(titulo) AS tituloMayusculas,
       LEFT(titulo, 10) AS inicioTitulo
FROM Pelicula
ORDER BY titulo;

/* 04. Mostrar la longitud del nombre de cada producto. */
SELECT nombreProducto, LEN(nombreProducto) AS longitudNombre
FROM Producto
ORDER BY longitudNombre DESC;

/* 05. Convertir la duracion de las peliculas a texto usando CAST. */
SELECT titulo,
       duracionMinutos,
       CAST(duracionMinutos AS VARCHAR(10)) + ' minutos' AS duracionTexto
FROM Pelicula
ORDER BY duracionMinutos DESC;

/* 06. Mostrar las funciones programadas para noviembre de 2026. */
SELECT idFuncion, fechaHoraInicio, idPelicula, idSala
FROM Funcion
WHERE YEAR(fechaHoraInicio) = 2026
  AND MONTH(fechaHoraInicio) = 11
ORDER BY fechaHoraInicio;

/* 07. Mostrar la fecha de compra de cada boleto con formato dd/mm/yyyy. */
SELECT idBoleto,
       CONVERT(VARCHAR(10), fechaCompra, 103) AS fechaCompraFormateada
FROM Boleto
ORDER BY fechaCompra;

/* 08. Calcular cuantos dias antes de la funcion se compro cada boleto. */
SELECT b.idBoleto, b.fechaCompra, f.fechaHoraInicio,
       DATEDIFF(DAY, b.fechaCompra, f.fechaHoraInicio) AS diasAnticipacion
FROM Boleto AS b
INNER JOIN Funcion AS f ON f.idFuncion = b.idFuncion
ORDER BY diasAnticipacion DESC;

/* 09. Consultar boletos con pelicula, funcion, sala, asiento y cliente. */
SELECT b.idBoleto, p.titulo, f.fechaHoraInicio, s.nombreSala,
       a.fila, a.numeroAsiento, c.nombre AS cliente, b.fechaCompra
FROM Boleto AS b
INNER JOIN Funcion AS f ON f.idFuncion = b.idFuncion
INNER JOIN Pelicula AS p ON p.idPelicula = f.idPelicula
INNER JOIN Sala AS s ON s.idSala = f.idSala
INNER JOIN Asiento AS a ON a.idAsiento = b.idAsiento
INNER JOIN Cliente AS c ON c.idCliente = b.idCliente
ORDER BY f.fechaHoraInicio;

/* 10. Mostrar todas las peliculas, incluso si no tienen funciones (LEFT JOIN). */
SELECT p.idPelicula, p.titulo, f.idFuncion, f.fechaHoraInicio
FROM Pelicula AS p
LEFT JOIN Funcion AS f ON f.idPelicula = p.idPelicula
ORDER BY p.titulo, f.fechaHoraInicio;

/* 11. Mostrar todos los productos y sus detalles de venta (RIGHT JOIN). */
SELECT p.idProducto, p.nombreProducto, p.precio,
       d.idVenta, d.cantidad, d.subtotal
FROM DetalleVenta AS d
RIGHT JOIN Producto AS p ON p.idProducto = d.idProducto
ORDER BY p.nombreProducto;

/* 12. Mostrar todas las salas y todas las funciones, incluso sin coincidencia
       (FULL OUTER JOIN). */
SELECT s.idSala, s.nombreSala, f.idFuncion, f.fechaHoraInicio
FROM Sala AS s
FULL OUTER JOIN Funcion AS f ON f.idSala = s.idSala
ORDER BY s.idSala, f.fechaHoraInicio;

/* 13. Contar cuantos boletos se vendieron por pelicula. */
SELECT p.titulo, COUNT(b.idBoleto) AS boletosVendidos
FROM Pelicula AS p
LEFT JOIN Funcion AS f ON f.idPelicula = p.idPelicula
LEFT JOIN Boleto AS b ON b.idFuncion = f.idFuncion
GROUP BY p.titulo
ORDER BY boletosVendidos DESC;

/* 14. Mostrar las peliculas con al menos un boleto vendido. */
SELECT p.titulo, COUNT(b.idBoleto) AS boletosVendidos
FROM Pelicula AS p
INNER JOIN Funcion AS f ON f.idPelicula = p.idPelicula
INNER JOIN Boleto AS b ON b.idFuncion = f.idFuncion
GROUP BY p.titulo
HAVING COUNT(b.idBoleto) >= 1
ORDER BY boletosVendidos DESC;

/* 15. Calcular el total vendido por empleado en dulceria. */
SELECT e.idEmpleado, e.nombre, COUNT(v.idVenta) AS numeroVentas
FROM Empleado AS e
LEFT JOIN Venta AS v ON v.idEmpleado = e.idEmpleado
GROUP BY e.idEmpleado, e.nombre
ORDER BY numeroVentas DESC;

/* 16. Obtener el importe total de cada venta sumando sus detalles. */
SELECT v.idVenta, v.fechaVenta,
       COALESCE(SUM(d.subtotal), 0) AS totalVenta
FROM Venta AS v
LEFT JOIN DetalleVenta AS d ON d.idVenta = v.idVenta
GROUP BY v.idVenta, v.fechaVenta
ORDER BY totalVenta DESC;

/* 17. Mostrar el importe vendido por mes y anio. */
SELECT YEAR(v.fechaVenta) AS anio,
       MONTH(v.fechaVenta) AS mes,
       SUM(d.subtotal) AS totalMensual
FROM Venta AS v
INNER JOIN DetalleVenta AS d ON d.idVenta = v.idVenta
GROUP BY YEAR(v.fechaVenta), MONTH(v.fechaVenta)
ORDER BY anio, mes;

/* 18. Mostrar productos cuyo precio es mayor al precio promedio
       (subconsulta no correlacionada). */
SELECT idProducto, nombreProducto, precio
FROM Producto
WHERE precio > (SELECT AVG(precio) FROM Producto)
ORDER BY precio DESC;

/* 19. Mostrar peliculas que tienen al menos una funcion (subconsulta correlacionada). */
SELECT p.idPelicula, p.titulo
FROM Pelicula AS p
WHERE EXISTS
(
    SELECT 1
    FROM Funcion AS f
    WHERE f.idPelicula = p.idPelicula
)
ORDER BY p.titulo;

/* 20. Mostrar empleados que han registrado al menos una venta
       (subconsulta correlacionada). */
SELECT e.idEmpleado, e.nombre, e.puesto
FROM Empleado AS e
WHERE EXISTS
(
    SELECT 1
    FROM Venta AS v
    WHERE v.idEmpleado = e.idEmpleado
)
ORDER BY e.nombre;

/* 21. Mostrar clientes que compraron boletos para alguna funcion. */
SELECT c.idCliente, c.nombre, c.tipoCliente
FROM Cliente AS c
WHERE EXISTS
(
    SELECT 1
    FROM Boleto AS b
    WHERE b.idCliente = c.idCliente
)
ORDER BY c.nombre;

/* 22. Unir nombres de clientes y empleados sin repetir filas (UNION). */
SELECT nombre, 'Cliente' AS tipoRegistro
FROM Cliente
UNION
SELECT nombre, 'Empleado' AS tipoRegistro
FROM Empleado
ORDER BY nombre;

/* 23. Productos que aparecen en detalles de venta y cuyo precio supera
       el promedio general (INTERSECT). */
SELECT idProducto
FROM DetalleVenta
INTERSECT
SELECT idProducto
FROM Producto
WHERE precio > (SELECT AVG(precio) FROM Producto);

/* 24. Obtener peliculas que no tienen clasificacion AA (EXCEPT). */
SELECT idPelicula
FROM Pelicula
EXCEPT
SELECT idPelicula
FROM Pelicula
WHERE clasificacion = 'AA';

/* 25. Mostrar funciones con el dia de la semana y la hora de inicio. */
SELECT idFuncion, fechaHoraInicio,
       DATENAME(WEEKDAY, fechaHoraInicio) AS diaSemana,
       CONVERT(VARCHAR(8), fechaHoraInicio, 108) AS horaInicio
FROM Funcion
ORDER BY fechaHoraInicio;

/* 26. Comparar la capacidad declarada de cada sala con los asientos registrados. */
SELECT s.idSala, s.nombreSala, s.capacidadTotal,
       COUNT(a.idAsiento) AS asientosRegistrados,
       s.capacidadTotal - COUNT(a.idAsiento) AS diferenciaCapacidad
FROM Sala AS s
LEFT JOIN Asiento AS a ON a.idSala = s.idSala
GROUP BY s.idSala, s.nombreSala, s.capacidadTotal
ORDER BY s.idSala;

/* 27. Mostrar el numero de boletos vendidos por funcion y su ingreso estimado. */
SELECT f.idFuncion, p.titulo, f.fechaHoraInicio, f.precioBoleto,
       COUNT(b.idBoleto) AS boletosVendidos,
       COUNT(b.idBoleto) * f.precioBoleto AS ingresoEstimado
FROM Funcion AS f
INNER JOIN Pelicula AS p ON p.idPelicula = f.idPelicula
LEFT JOIN Boleto AS b ON b.idFuncion = f.idFuncion
GROUP BY f.idFuncion, p.titulo, f.fechaHoraInicio, f.precioBoleto
ORDER BY ingresoEstimado DESC;

/* 28. Mostrar los cinco productos con mayor cantidad vendida. */
SELECT TOP (5) p.idProducto, p.nombreProducto,
       SUM(d.cantidad) AS unidadesVendidas
FROM Producto AS p
INNER JOIN DetalleVenta AS d ON d.idProducto = p.idProducto
GROUP BY p.idProducto, p.nombreProducto
ORDER BY unidadesVendidas DESC;

/* 29. Mostrar clientes y el numero de compras de dulceria que realizaron. */
SELECT c.idCliente, c.nombre, COUNT(v.idVenta) AS comprasDulceria
FROM Cliente AS c
LEFT JOIN Venta AS v ON v.idCliente = c.idCliente
GROUP BY c.idCliente, c.nombre
ORDER BY comprasDulceria DESC, c.nombre;

/* 30. Mostrar el total de ingresos por tipo de cliente. */
SELECT c.tipoCliente,
       COUNT(DISTINCT c.idCliente) AS cantidadClientes,
       COUNT(DISTINCT b.idBoleto) AS boletosComprados,
       COALESCE(SUM(f.precioBoleto), 0) AS ingresoPorBoletos
FROM Cliente AS c
LEFT JOIN Boleto AS b ON b.idCliente = c.idCliente
LEFT JOIN Funcion AS f ON f.idFuncion = b.idFuncion
GROUP BY c.tipoCliente
ORDER BY c.tipoCliente;
GO


/* =====================================================================
   FASE 3 - PARTE 4: TRES VISTAS PARA APOYAR LA TOMA DE DECISIONES
   ===================================================================== */

/* VISTA 1: programacion de funciones.
   Utilidad: consultar rapidamente cartelera, sala, horario y precio. */
CREATE OR ALTER VIEW dbo.vw_ProgramacionFunciones
AS
SELECT f.idFuncion, p.titulo, p.duracionMinutos, p.clasificacion,
       s.nombreSala, f.fechaHoraInicio, f.precioBoleto, f.observaciones
FROM dbo.Funcion AS f
INNER JOIN dbo.Pelicula AS p ON p.idPelicula = f.idPelicula
INNER JOIN dbo.Sala AS s ON s.idSala = f.idSala;
GO

/* VISTA 2: resumen de ventas de dulceria.
   Utilidad: identificar ventas, empleados, clientes e importe por venta. */
CREATE OR ALTER VIEW dbo.vw_ResumenVentasDulceria
AS
SELECT v.idVenta, v.fechaVenta,
       e.nombre AS empleado,
       c.nombre AS cliente,
       COUNT(d.idVenta) AS lineasVenta,
       COALESCE(SUM(d.cantidad), 0) AS unidades,
       COALESCE(SUM(d.subtotal), 0) AS totalVenta
FROM dbo.Venta AS v
INNER JOIN dbo.Empleado AS e ON e.idEmpleado = v.idEmpleado
INNER JOIN dbo.Cliente AS c ON c.idCliente = v.idCliente
LEFT JOIN dbo.DetalleVenta AS d ON d.idVenta = v.idVenta
GROUP BY v.idVenta, v.fechaVenta, e.nombre, c.nombre;
GO

/* VISTA 3: ocupacion de funciones.
   Utilidad: comparar boletos vendidos contra la capacidad de cada sala. */
CREATE OR ALTER VIEW dbo.vw_OcupacionFunciones
AS
SELECT f.idFuncion, p.titulo, s.nombreSala,
       f.fechaHoraInicio, s.capacidadTotal,
       COUNT(b.idBoleto) AS boletosVendidos,
       s.capacidadTotal - COUNT(b.idBoleto) AS lugaresDisponibles,
       CAST(
           100.0 * COUNT(b.idBoleto) / NULLIF(s.capacidadTotal, 0)
           AS DECIMAL(6,2)
       ) AS porcentajeOcupacion
FROM dbo.Funcion AS f
INNER JOIN dbo.Pelicula AS p ON p.idPelicula = f.idPelicula
INNER JOIN dbo.Sala AS s ON s.idSala = f.idSala
LEFT JOIN dbo.Boleto AS b ON b.idFuncion = f.idFuncion
GROUP BY f.idFuncion, p.titulo, s.nombreSala,
         f.fechaHoraInicio, s.capacidadTotal;
GO

/* Comprobar las tres vistas y obtener resultados para las evidencias. */
SELECT * FROM dbo.vw_ProgramacionFunciones
ORDER BY fechaHoraInicio;

SELECT * FROM dbo.vw_ResumenVentasDulceria
ORDER BY fechaVenta DESC;

SELECT * FROM dbo.vw_OcupacionFunciones
ORDER BY porcentajeOcupacion DESC;
GO


/* =====================================================================
   VERIFICACION FINAL DE FASE 3
   - Las tablas deben mostrar 50 filas cada una si se ejecuto la carga.
   - Las dos comprobaciones de integridad deben devolver 0.
   ===================================================================== */

SELECT 'Pelicula' AS tabla, COUNT(*) AS filas FROM Pelicula UNION ALL
SELECT 'Sala', COUNT(*) FROM Sala UNION ALL
SELECT 'Asiento', COUNT(*) FROM Asiento UNION ALL
SELECT 'Empleado', COUNT(*) FROM Empleado UNION ALL
SELECT 'Cliente', COUNT(*) FROM Cliente UNION ALL
SELECT 'Funcion', COUNT(*) FROM Funcion UNION ALL
SELECT 'Boleto', COUNT(*) FROM Boleto UNION ALL
SELECT 'Producto', COUNT(*) FROM Producto UNION ALL
SELECT 'Venta', COUNT(*) FROM Venta UNION ALL
SELECT 'DetalleVenta', COUNT(*) FROM DetalleVenta;

SELECT COUNT(*) AS boletos_con_asiento_de_otra_sala
FROM Boleto AS b
INNER JOIN Funcion AS f ON f.idFuncion = b.idFuncion
INNER JOIN Asiento AS a ON a.idAsiento = b.idAsiento
WHERE a.idSala <> f.idSala;

SELECT COUNT(*) AS detalles_con_subtotal_incorrecto
FROM DetalleVenta AS d
INNER JOIN Producto AS p ON p.idProducto = d.idProducto
WHERE d.subtotal <> d.cantidad * p.precio;
GO

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------EJERCICIO  1 ----------------------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
use BD_Ejercicio1;
SELECT @@VERSION; --en mi caso:Microsoft SQL Server 2019 

-- 1) Seleccionar el nombre de los clientes con domicilio en Montevideo.
select nombre, ciudad from cliente where ciudad= 'Montevideo';

-- 2) Seleccionar todos los datos de los clientes con domicilio en Montevideo, ordenando alfabéticamente por nombre.
select * 
from cliente
where ciudad= 'Montevideo'
order by nombre desc;

-- 3) Seleccionar el número de las órdenes con fecha anterior al 21 de abril de este año (2018).

select* from orden;

select num_orden 
from orden 
where FECHA_ORDEN < '2018-04-21';

-- 3.2) Seleccionar el número de las órdenes con fecha anterior al 21 de abril de este año (2018)
-- (Si tengo que pasarla todos los años, puedo decirle que tome el año al momento de ejecuciòn ).
--entonces DEBO CASTEAR quedate con año de getdate, que me trae fecha de hoy rel año, lo convierta a texto de 4 cifras
--y despues que lo una al espacio en blanco que lo convierta a datetime para tener el mismo formato. 

--select num_orden 
--from orden 
--where FECHA_ORDEN < cast('-04-21'+ cast (year(getdate()) as varchar (4)) as date);


 -- 4) Seleccionar el número de las órdenes pedidas o entregadas el 20 de abril del 2018.
 
 
select* from orden;

 select num_orden
 from orden 
 where FECHA_ORDEN='2018-04-20' or FECHA_ENTREGA='2018-04-20';

  -- 5) Seleccionar el código y nombre de los clientes con domicilio en Montevideo, Pando o Rocha.

  select COD_CLI, NOMBRE 
from cliente
where CIUDAD='montevideo' or CIUDAD= 'pando' or CIUDAD='rocha';

--OTRA FORMA ES UTILIZANDO UNA LISTA "IN" SIGNIFICA QUE ES ALGUNO DE LA LISTA
-- SI FUERA CONDICIONAL Y FUNCIONA COMO UN OR Y TENDRIA QUE PONER AND where CIUDAD='montevideo' AND CIUDAD= 'pando' AND CIUDAD='rocha', 

select COD_CLI, NOMBRE 
from cliente
where CIUDAD IN('montevideo','pando','rocha');

 -- 6) Seleccionar el código de los productos con precio entre 100 y 500.

 select cod_prod 
 from producto
 where precio >=100 and precio <=500;

 --otra forma es con between sirve para numeros y fechas

 select cod_prod
 from producto
 where precio between 100 and 500;

 --Buscar TExtos
 --quiero buscar clienteds quer nombre termna en z, uso "comodin"  LIKE

 select* 
 from cliente where nombre like '%z';

 --quiero buscar clienteds quer nombre empiezan con A,
 
 select* 
 from cliente where nombre like 'a%';

 --quiero buscar clienteds quer tengan doble LL,
  select* 
 from cliente where nombre like '%ll%';

  --quiero buscar clienteds con combinaciones empiecen con e tengan l y terminen en a,
  select* 
 from cliente
 where nombre like 'e%l%a';

   -- ejemplo quiero buscar los que viven en 18 de julio 18% ,

    -- 7) Seleccionar el código de los clientes cuyos nombres empiecen con "A" o "M".
	 SELECT COD_CLI
 FROM CLIENTE
 WHERE NOMBRE LIKE 'A%' OR NOMBRE LIKE 'M%';

  --otra forma
select COD_CLI from cliente where SUBSTRING(nombre,1,1) IN ('A','M');


--otra forma del nombre me quedo con la primer letra pos 1 hasta  1 y luego lehago el in "list"
select cod_cli from cliente where substring (nombre,1,1)in ('a','m');

--fecha de hoy con formato fecha hora

select getdate();

--quiero solo fehca convertir varchar  dd//mm//yyyy
select getdate();
select convert (varchar(10), getdate(),103); --03/05/2022 dd//mm//yyyy
select convert (varchar(10), getdate(),107); --May/03/20 mm/dd/yyyy
select convert (varchar(10), getdate(),101); --May/03/20 mm/dd/yyyy
select convert (varchar(10), getdate(),101); --May/03/20 mm/dd/yyyy

--solo el año en curso 2022
select year (getdate());
select month (getdate());
select day (getdate());
--solo el año y mes

--al dia de hoy sumar 1 dia
select getdate() as hoy, getdate() + 1 as mañana;

select year (getdate()) as año_actual, year (getdate()) -1 as año_anterior;


/* FECHAS */
SELECT GETDATE(); -- 2022-05-03 19:43:22.377
SELECT CONVERT(VARCHAR(10), GETDATE(), 103); -- 03/05/2022 -- DD/MM/AAAA
SELECT CONVERT(VARCHAR(10), GETDATE(), 107); -- May 03, 20
SELECT CONVERT(VARCHAR(10), GETDATE(), 101); -- 05/03/2022 -- MM/DD/AAA
SELECT CONVERT(VARCHAR(10), GETDATE(), 121); -- 2022-05-03 -- AAAA-MM-DD
SELECT YEAR(GETDATE()); -- 2022
SELECT MONTH(GETDATE()); -- 5
SELECT DAY(GETDATE());-- 3
SELECT GETDATE() AS HOY, GETDATE() +1 AS MAÑANA;
SELECT YEAR(GETDATE()) AS AÑO_ACTUAL, YEAR(GETDATE()) -1 AS AÑO_ANTERIOR;


-- 8 selec num de ordenes no entregadas (null)

select* from orden;

select num_orden 
from orden 
where fecha_entrega is null;

--8 a selec num de ordenes si fueron entregadas (null)

select num_orden 
from orden 
where fecha_entrega is not null;


--9seleccionar todos los datos de ordenes pedidas el 20 abril 2018 y entregadas al dia siguiente

select*
from orden 
where fecha_orden='2018-04-20' 
and FECHA_ENTREGA= '2018-04-21';

--seleccionar todos los datos de ordenes pedidas igual  A hoy  Y con entrega mañana 
select FECHA_ORDEN, FECHA_ENTREGA
from orden 
where fecha_orden=convert (varchar(10), getdate(),103) 
and FECHA_ENTREGA= convert (varchar(10), getdate(),103)+1; 

--10 ciudades donde hay clientess

select distinct ciudad from cliente;

select distinct ciudad from cliente order by ciudad;
select distinct ciudad from cliente order by ciudad;
select distinct ciudad from cliente order by ciudad desc;

--11  Seleccionar el nombre de los clientes que hayan realizado alguna orden.


select distinct cod_cli
from orden;

select distinct nombre 
from cliente where 
COD_CLI in (1000, 10001, 1002, 1003,1004, 1005, 1006);

--si no quiero nombres repetidos uso distinct

select distinct  nombre
from cliente
where COD_CLI in (select distinct cod_cli from orden);

--otra forma

select distinct c.nombre 
from cliente c, orden o 
where o.cod_cli = c .COD_CLI;

--este es más optimo!!
select distinct c.nombre 
from cliente c 
inner join orden o on o.cod_cli = c .COD_CLI;

-- OTRA FORMA

SELECT DISTINCT C.NOMBRE
FROM CLIENTE C
JOIN ORDEN O ON O.COD_CLI = C.COD_CLI;

SELECT DISTINCT CLIENTE.NOMBRE
FROM CLIENTE 
JOIN ORDEN ON ORDEN.COD_CLI = CLIENTE.COD_CLI;

--12 selecciona todos datos de clien que haysn realiz alguna orden antes del 18-abr 2018


-- SELECT DISTINCT COD_CLI FROM ORDEN WHERE FECHA_ORDEN < '2018-04-01'; -- 1000
-- SELECT * FROM CLIENTE WHERE COD_CLI IN (1000); 

SELECT * 
FROM CLIENTE 
WHERE COD_CLI IN (SELECT DISTINCT COD_CLI FROM ORDEN WHERE FECHA_ORDEN < '2018-04-01');

-- OTRA FORMA
SELECT C.*
FROM CLIENTE C, ORDEN O 
WHERE O.COD_CLI = C.COD_CLI
AND O.FECHA_ORDEN < '2018-04-01';

-- OTRA FORMA
SELECT C.*
FROM CLIENTE C
INNER JOIN ORDEN O ON O.COD_CLI = C.COD_CLI AND O.FECHA_ORDEN < '2018-04-01';

SELECT C.*
FROM CLIENTE C
INNER JOIN ORDEN O ON O.COD_CLI = C.COD_CLI 
WHERE O.FECHA_ORDEN < '2018-04-01';


SELECT C.*
FROM CLIENTE C
JOIN ORDEN O ON O.COD_CLI = C.COD_CLI
WHERE O.FECHA_ORDEN < '2018-04-01';

SELECT CLIENTE.*
FROM CLIENTE 
JOIN ORDEN ON ORDEN.COD_CLI = CLIENTE.COD_CLI
WHERE ORDEN.FECHA_ORDEN < '2018-04-01';

--13 Seleccionar el nombre y el precio de los productos de la orden 5001.

SELECT COD_PROD FROM DETALLE WHERE NUM_ORDEN = 5001;
SELECT NOMBRE, PRECIO FROM PRODUCTO WHERE COD_PROD IN (110, 120, 130);

SELECT NOMBRE, PRECIO 
FROM PRODUCTO
WHERE COD_PROD IN (SELECT COD_PROD FROM DETALLE WHERE NUM_ORDEN = 5001);

-- OTRA FORMA
SELECT P.NOMBRE, P.PRECIO
FROM producto P, detalle D
WHERE P.COD_PROD = D.COD_PROD
AND D.NUM_ORDEN = 5001;

-- OTRA FORMA
SELECT P.NOMBRE, P.PRECIO
FROM producto P
INNER JOIN detalle D ON D.COD_PROD = P.COD_PROD
AND D.NUM_ORDEN = 5001;

--14 -- 14) Seleccionar el nombre y el precio de los productos que hayan sido ordenados 
-- por el cliente Pérez domiciliado en Montevideo.

SELECT C.COD_CLI FROM CLIENTE C WHERE C.NOMBRE = 'PEREZ' AND CIUDAD  = 'MONTEVIDEO'; -- 1000
SELECT O.NUM_ORDEN FROM ORDEN O WHERE O.COD_CLI = 1000; -- 5000 - 50001
SELECT DISTINCT D.COD_PROD FROM DETALLE D WHERE D.NUM_ORDEN IN (5000,5001); -- 110	120	130
SELECT P.NOMBRE, P.PRECIO FROM producto P WHERE P.COD_PROD IN (110,120,130);

SELECT P.NOMBRE, P.PRECIO 
FROM producto P 
WHERE P.COD_PROD IN (SELECT DISTINCT D.COD_PROD 
						FROM DETALLE D 
						WHERE D.NUM_ORDEN IN (SELECT O.NUM_ORDEN 
												FROM ORDEN O 
												WHERE O.COD_CLI = (SELECT C.COD_CLI 
																	FROM CLIENTE C 
																	WHERE C.NOMBRE = 'PEREZ' 
																	AND CIUDAD  = 'MONTEVIDEO')));

SELECT DISTINCT P.NOMBRE, P.PRECIO
FROM producto P, detalle D, orden O, cliente C
WHERE P.COD_PROD = D.COD_PROD
AND D.NUM_ORDEN = O.NUM_ORDEN
AND O.COD_CLI = C.COD_CLI
AND C.NOMBRE = 'PEREZ' 
AND C. CIUDAD  = 'MONTEVIDEO';




-- OTRA FORMA
SELECT DISTINCT P.NOMBRE, P.PRECIO
FROM producto P
INNER JOIN DETALLE D ON P.COD_PROD = D.COD_PROD
INNER JOIN ORDEN O ON D.NUM_ORDEN = O.NUM_ORDEN
INNER JOIN CLIENTE C ON O.COD_CLI = C.COD_CLI
AND C.NOMBRE = 'PEREZ' 
AND C. CIUDAD  = 'MONTEVIDEO'; 


--15 seleccionar 
-- 15) Seleccionar el número de las órdenes que han pedido alguno de los mismos productos
-- pedidos en la orden 5001.

-- SELECT COD_PROD FROM DETALLE WHERE NUM_ORDEN = 5001

SELECT DISTINCT D.NUM_ORDEN
FROM DETALLE D
WHERE D.COD_PROD IN (SELECT D2.COD_PROD 
					FROM DETALLE D2
					WHERE D2.NUM_ORDEN = 5001
					AND D2.NUM_ORDEN <> D.NUM_ORDEN);

-- OTRA FORMA
SELECT DISTINCT D.NUM_ORDEN
FROM DETALLE D, DETALLE D2
WHERE D.COD_PROD = D2.COD_PROD
AND D2.NUM_ORDEN = 5001
AND D2.NUM_ORDEN <> D.NUM_ORDEN;

--- OTRA FORMA
SELECT DISTINCT D.NUM_ORDEN
FROM DETALLE D
INNER JOIN DETALLE D2 ON D.COD_PROD = D2.COD_PROD
AND D2.NUM_ORDEN = 5001
AND D2.NUM_ORDEN <> D.NUM_ORDEN;

-- 16) Seleccionar el código de los clientes que han ordenado alguno de los mismos productos
-- ordenados por el cliente García.

SELECT DISTINCT C1.COD_CLI
FROM DETALLE D1, ORDEN O1, CLIENTE C1
WHERE D1.NUM_ORDEN = O1.NUM_ORDEN
AND C1.COD_CLI = O1.COD_CLI
AND D1.COD_PROD IN (
				-- 130	140	150	160
				SELECT DISTINCT D.COD_PROD
				FROM CLIENTE C, ORDEN O, DETALLE D
				WHERE C.NOMBRE = 'GARCIA'
				AND O.COD_CLI = C.COD_CLI
				AND D.NUM_ORDEN = O.NUM_ORDEN
				AND C.COD_CLI <> C1.COD_CLI);

-- OTRA FORMA
SELECT DISTINCT C1.COD_CLI
FROM CLIENTE C1
INNER JOIN ORDEN O1 ON C1.COD_CLI = O1.COD_CLI
INNER JOIN DETALLE D1 ON D1.NUM_ORDEN = O1.NUM_ORDEN
WHERE D1.COD_PROD IN (
				-- 130	140	150	160
				SELECT DISTINCT D.COD_PROD
				FROM  DETALLE D
				INNER JOIN ORDEN O ON O.NUM_ORDEN = D.NUM_ORDEN
				INNER JOIN CLIENTE C ON C.COD_CLI = O.COD_CLI
				WHERE C.NOMBRE = 'GARCIA'	
				AND C.COD_CLI <> C1.COD_CLI);

-- 17) Seleccionar el nombre de los clientes y en el caso que hayan realizado alguna orden, el número de orden.

select c.NOMBRE, o.NUM_ORDEN
from cliente c
left join orden o on  o.COD_CLI = c.COD_CLI
order by o.NUM_ORDEN;

-- otra forma (A-B) U (AnB)

(SELECT C.COD_CLI, O2.NUM_ORDEN
FROM CLIENTE C
LEFT JOIN ORDEN O2 ON O2.COD_CLI = C.COD_CLI
EXCEPT
SELECT DISTINCT O.COD_CLI , O.NUM_ORDEN
FROM ORDEN O)
UNION
(SELECT C.COD_CLI, O2.NUM_ORDEN
FROM CLIENTE C
INNER JOIN ORDEN O2 ON O2.COD_CLI = C.COD_CLI);



-- 18) Seleccionar el mayor y el menor número de orden. 
SELECT MAX(NUM_ORDEN) AS Maximo, MIN(NUM_ORDEN) AS Minimo 
FROM ORDEN;



-- 19) Seleccionar las ciudades donde hay clientes y/o proveedores.
select ciudad from proveedor
union
select ciudad from cliente;


-- union con repetidos
select ciudad from proveedor
union all
select ciudad from cliente;

-- otra forma
SELECT DISTINCT C.CIUDAD
FROM CLIENTE C
FULL OUTER JOIN PROVEEDOR P ON P.CIUDAD = C.CIUDAD;


-- 20) Seleccionar las ciudades donde hay clientes y no hay proveedores.
SELECT DISTINCT C.CIUDAD
FROM CLIENTE C
LEFT JOIN PROVEEDOR P ON P.CIUDAD = C.CIUDAD 
WHERE P.CIUDAD IS NULL;

-- OTRA FORMA
SELECT DISTINCT C.CIUDAD FROM CLIENTE C
EXCEPT
SELECT DISTINCT P.CIUDAD FROM PROVEEDOR P;




-- OTRA FORMA
SELECT DISTINCT C.CIUDAD 
FROM CLIENTE C
WHERE NOT EXISTS (SELECT DISTINCT P.CIUDAD 
					FROM PROVEEDOR P
					WHERE P.CIUDAD = C.CIUDAD);

-- IGUAL A LA ANTERIOR SOLO QUE EN EL NOT EXISTS PONEMOS 1 
SELECT DISTINCT C.CIUDAD 
FROM CLIENTE C
WHERE NOT EXISTS (SELECT 1 
					FROM PROVEEDOR P
					WHERE P.CIUDAD = C.CIUDAD);


-- 21) Seleccionar el número de las órdenes en donde se haya pedido solamente el producto 130.

SELECT DISTINCT D.NUM_ORDEN
FROM DETALLE D
WHERE D.COD_PROD = 130
EXCEPT
SELECT DISTINCT D.NUM_ORDEN
FROM DETALLE D
WHERE D.COD_PROD <> 130;


-- OTRA FORMA
select distinct d1.NUM_ORDEN
from detalle d1
where d1.COD_PROD = 130
and not exists ( select 1
					from detalle d2
					where d2.COD_PROD <> 130
					and d1.NUM_ORDEN = d2.NUM_ORDEN);


-- 22) Seleccionar todos los datos de las órdenes en donde se haya pedido ESMALTE 10L o ESMALTE 25L pero no ambos productos. 


select  *
from orden o
where o.NUM_ORDEN in (5000, 5003, 5007);


select  *
from orden o
where o.NUM_ORDEN in ((select d1.NUM_ORDEN
						from detalle d1, producto p1
						where p1.COD_PROD = d1.COD_PROD
						and p1.NOMBRE = 'ESMALTE 10L'
						union
						select d2.NUM_ORDEN
						from detalle d2, producto p2
						where p2.COD_PROD = d2.COD_PROD
						and p2.NOMBRE = 'ESMALTE 25L')
						except
						(select d3.NUM_ORDEN
						from detalle d3, producto p3
						where p3.COD_PROD = d3.COD_PROD
						and p3.NOMBRE = 'ESMALTE 10L'
						intersect
						select d4.NUM_ORDEN
						from detalle d4, producto p4
						where p4.COD_PROD = d4.COD_PROD
						and p4.NOMBRE = 'ESMALTE 25L'));


--- oTRAS FORMAS


--SOLUCIÓN 1
select DISTINCT * 
from orden o, detalle d, producto p
where o.num_orden = d.num_orden
AND D.COD_PROD = P.COD_PROD
and p.nombre = 'ESMALTE 10L'
AND NOT EXISTS (SELECT *
                from detalle d2, producto p2
                where O.NUM_ORDEN = D2.num_orden
                AND D2.COD_PROD = P2.COD_PROD
                and p2.nombre = 'ESMALTE 25L') 

UNION

select DISTINCT * 
from orden o, detalle d, producto p
where o.num_orden = d.num_orden
AND D.COD_PROD = P.COD_PROD
and p.nombre = 'ESMALTE 25L'
AND NOT EXISTS (SELECT *
                from detalle d2, producto p2
                where O.NUM_ORDEN = D2.num_orden
                AND D2.COD_PROD = P2.COD_PROD
                and p2.nombre = 'ESMALTE 10L') ;

--SOLUCION 2
select DISTINCT * 
from orden o, detalle d, producto p
where o.num_orden = d.num_orden
AND D.COD_PROD = P.COD_PROD
and p.nombre = 'ESMALTE 10L'
AND O.NUM_ORDEN NOT IN (SELECT D2.NUM_ORDEN
                from detalle d2, producto p2
                where O.NUM_ORDEN = D2.num_orden
                AND D2.COD_PROD = P2.COD_PROD
                and p2.nombre = 'ESMALTE 25L') 

UNION

select DISTINCT * 
from orden o, detalle d, producto p
where o.num_orden = d.num_orden
AND D.COD_PROD = P.COD_PROD
and p.nombre = 'ESMALTE 25L'
AND O.NUM_ORDEN NOT IN (SELECT D2.NUM_ORDEN
                from detalle d2, producto p2
                where O.NUM_ORDEN = D2.num_orden
                AND D2.COD_PROD = P2.COD_PROD
                and p2.nombre = 'ESMALTE 10L') ;




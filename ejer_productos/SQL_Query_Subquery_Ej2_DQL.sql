------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------EJERCICIO  2 PRODCUTOS Y ORDENES----------------------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
use BD_Ejercicio1;
SELECT @@VERSION; --en mi caso:Microsoft SQL Server 2019 

-- 1) Seleccionar la cantidad de clientes.
SELECT COUNT(*) AS Cant_Cliente
from cliente;


-- 2) Seleccionar el mayor y el menor precio de los productos.
select min(precio) as Minimo, max(precio) as Maximo 
from producto;
-- 3) Seleccionar el promedio de precios de los productos.

-- 4) Seleccionar el número de las órdenes cuando el precio del producto ordenado sea el precio mayor de todos los productos.

select o.NUM_ORDEN 
from orden o, detalle d, producto p
where o.NUM_ORDEN = d.NUM_ORDEN
and p.COD_PROD = d.COD_PROD
and p.PRECIO= (select max (precio) as Maximo from producto);



-- 5) Seleccionar la cantidad de clientes por ciudad.

 select ciudad, count(*) as Cantidad 
 from cliente 
 group by CIUDAD;


-- 6) Seleccionar la cantidad de órdenes por día en el período comprendido entre el 1 y 20 de abril deal año 2018 (este año).

select *from orden;

select FECHA_ORDEN, count(*) as Cant
from orden
where FECHA_ORDEN between '2018-04-01' and '2018-04-20'
group by FECHA_ORDEN;


-- 7) Seleccionar la cantidad de órdenes que hay por día, con su respectivo importe.

select o.FECHA_ORDEN, count(distinct o.NUM_ORDEN) as Cant_Orden, sum(d.CANTIDAD * p.PRECIO) as Importe
from orden o, detalle d, producto p
where o.NUM_ORDEN = d.NUM_ORDEN
and d.COD_PROD = p.COD_PROD
group by o.FECHA_ORDEN, o.NUM_ORDEN
order by o.FECHA_ORDEN;


-- 8) Seleccionar las ciudades en donde hay más de 3 clientes.

select CIUDAD, count (*)  Cantidad
from cliente  
group by CIUDAD
having count(*)>3;

-- resolver pero no realizar subconsultas dentro del from (USAR EL HAVING)

-- con subconsultas en el from
Select a.CIUDAD, a.Cantidad
from (select ciudad, count(*) Cantidad 
		From cliente
		group by ciudad) a
where a.Cantidad > 3;


-- 9) Seleccionar el número de las órdenes en donde se haya pedido más de un producto.


select NUM_ORDEN, sum(cantidad) Cant_Unid
from detalle
group by NUM_ORDEN
having sum(cantidad) > 1;


select NUM_ORDEN, count(COD_PROD) Cant_Prod
from detalle
group by NUM_ORDEN
having count(COD_PROD) > 1;

-- 10) Seleccionar el número de las órdenes cuando la cantidad total pedida es superior a 100 y no se pida menos de 30 unidades por producto. – TOMAMOS LETRA DE ABAJO

-- 10) Seleccionar el número de las órdenes cuando la cantidad total pedida es superior a 2 (100) y  no se pida menos de 10 unidades por producto.


select d.NUM_ORDEN
from detalle d, producto p
where d.COD_PROD=p.COD_PROD
group by d.NUM_ORDEN
having count (distinct p.cod_prov)>1;



select NUM_ORDEN, count(COD_PROD) Cant_Total, sum(cantidad) Unidades
from detalle
group by NUM_ORDEN
having count(COD_PROD) > 2 and sum(cantidad) >= 10;


-- 11) Seleccionar el número de las órdenes en donde se hayan pedido productos de más de un proveedor.

select *from cliente;
select *from orden;
select *from detalle;
select *from producto;
select*from proveedor;

Select d.NUM_ORDEN -- , count(distinct p.cod_prov) as Cant_Prov
from detalle d, producto p
where d.COD_PROD = p.COD_PROD
group by d.NUM_ORDEN
having count(distinct p.cod_prov) > 1;



-- 12) Seleccionar el código de los clientes que han realizado la mayor o la menor cantidad de órdenes.

select o1.COD_CLI, count(o1.num_orden) Cant
from orden o1
group by o1.COD_CLI
having count(o1.num_orden) = (select max(a.Cant) Maximo
								from (select o.COD_CLI, count(o.num_orden) Cant
										from orden o
										group by o.COD_CLI) a
							 )
UNION

select o1.COD_CLI, count(o1.num_orden) Cant
from orden o1
group by o1.COD_CLI
having count(o1.num_orden) = (select min(a.Cant) Minimo
								from (select o.COD_CLI, count(o.num_orden) Cant
										from orden o
										group by o.COD_CLI) a
 );


-- 13) Seleccionar el nombre de los clientes que han realizado la mayor cantidad de órdenes.
select c.NOMBRE
from cliente c
where c.COD_CLI in (select o1.COD_CLI
					from orden o1
					group by o1.COD_CLI
					having count(o1.num_orden) = (select max(a.Cant) Maximo
													from (select o.COD_CLI, count(o.num_orden) Cant
															from orden o
															group by o.COD_CLI) a
												 )
					);

-- Otra forma
select c.NOMBRE
from orden o1, cliente c
where c.COD_CLI = o1.COD_CLI
group by o1.COD_CLI, c.NOMBRE
having count(o1.num_orden) = (select max(a.Cant) Maximo
							 from (select o.COD_CLI, count(o.num_orden) Cant
									from orden o
									group by o.COD_CLI) a
     						 );


-- 14) Seleccionar el nombre de los clientes que han ordenado la mayor cantidad de productos.

select c.COD_CLI, c.NOMBRE, sum(d.cantidad) Cant
from cliente c, orden o, detalle d
where c.COD_CLI=o.COD_CLI
and o.NUM_ORDEN=d.NUM_ORDEN
group by c.COD_CLI, c.NOMBRE
having sum (d.cantidad)= (select max(a.Cant)
							from (select sum(d.cantidad) Cant
									from cliente c, orden o, detalle d
									where c.COD_CLI=o.COD_CLI
									and o.NUM_ORDEN=d.NUM_ORDEN
									group by c.COD_CLI, c.NOMBRE)a);


select c.NOMBRE
from cliente c, orden o, detalle d
where c.COD_CLI=o.COD_CLI
and o.NUM_ORDEN=d.NUM_ORDEN
group by c.COD_CLI, c.NOMBRE
having sum (d.cantidad)= (select max(a.Cant)
							from (select sum(d.cantidad) Cant
									from cliente c, orden o, detalle d
									where c.COD_CLI=o.COD_CLI
									and o.NUM_ORDEN=d.NUM_ORDEN
									group by c.COD_CLI, c.NOMBRE)a);

-- 15) Seleccionar el número de las órdenes en donde se hayan pedido más productos fabricados por distintos proveedores.

select d.NUM_ORDEN ---d.NUM_ORDEN, count(d.cod_prod) Cant_Prod, count(distinct p.cod_prov) Cant_Prov 
from detalle d, producto p
where p.COD_PROD = d.COD_PROD
group by d.NUM_ORDEN
having count(distinct p.cod_prov) = (select max(a.Cant_Prov ) Maximo
										from (select count(distinct p.cod_prov) Cant_Prov 
												from detalle d, producto p
												where p.COD_PROD = d.COD_PROD
												group by d.NUM_ORDEN) a
										)
	   AND count(d.cod_prod)  = (select MAX(b.Cant_Prod) Mayor
									from (select count(d.cod_prod) Cant_Prod
											from detalle d, producto p
											where p.COD_PROD = d.COD_PROD
											group by d.NUM_ORDEN) b
								);





-- 16) Seleccionar el nombre de los clientes que han ordenado absolutamente todos los productos.
SELECT c.NOMBRE
FROM  cliente c
where not exists (select 1
					from producto p
					where not exists (select 1
										from detalle d, orden o
										where d.COD_PROD = p.COD_PROD
										and o.NUM_ORDEN = d.NUM_ORDEN
										and o.COD_CLI = c.COD_CLI));

--- PARA VALIDAR 
INSERT INTO orden VALUES (5009,1000,'2022-05-17',NULL);
INSERT INTO detalle select 5009, COD_PROD, 1 from producto;

-- 17) Seleccionar el nombre de los clientes que han ordenado absolutamente todos los productos de los proveedores de la ciudad de Montevideo.
select c.NOMBRE
from cliente c
where not exists (select 1
					from proveedor pr
					where pr.CIUDAD = 'Montevideo'
					and not exists (select 1-- PRDUCTOS QUE SE COMPRARON
									from detalle d
									inner join producto p ON p.COD_PROD = d.COD_PROD
									inner join orden o ON o.NUM_ORDEN = d.NUM_ORDEN
									where p.COD_PROV = pr.COD_PROV
									and o.COD_CLI = c.COD_CLI));
SELECT 
FROM 

-- 18) Seleccionar el nombre de los productos que han sido ordenados por absolutamente todos los clientes. 


-- OBTENER LAS ORDENES POR ESTACION DE LOS MESES - OTOÑO Y PRIMAVERA
Select 'Otoño' as Estacion, *
from orden 
where month(FECHA_ORDEN) in (4,5) 
or (month(FECHA_ORDEN) = 3 and day(FECHA_ORDEN)>=21)
or (month(FECHA_ORDEN) = 6 and day(FECHA_ORDEN) < 21)
-- 21 /3 al 20/6 -- meses 3, 4 5 y 6
UNION
Select 'Primavera' as Estacion, *
from orden 
where month(FECHA_ORDEN) in (10,12) 
or (month(FECHA_ORDEN) = 9 and day(FECHA_ORDEN)>=21)
or (month(FECHA_ORDEN) = 12 and day(FECHA_ORDEN) < 21)
-- 21 /9 al 20/12 -- meses 9, 10, 11 y 12

-- Consultas

-- 1) Seleccionar los empleados que trabajan en el departamento 4.
select * 
from Empleados 
where Depto=4;

-- 2) Seleccionar los empleados cuyo salario es mayor que 7000.
select* 
from Empleados

select * 
from Empleados 
where Salario> 7000;

-- 3) Seleccionar los empleados que trabajan en el departamento 5 cuyo salario es mayor que 8000.
select *
from Empleados 
where Depto=4 and Salario> 8000 ;

-- 4) Listar el nombre y el salario de todos los empleados.
select nombre, Salario 
from Empleados;

-- 5) Listar el sexo y el salario de todos los empleados.

select sexo, Salario
from Empleados;

--Listar por sexo total salario (Lo que quiero es que los sume)

select sexo, sum (Salario) as Salario_Total
from Empleados 
group by sexo
order by Sexo;

--Listar por sexo Promedio salario (Lo que quiero es que los sume)
select sexo, avg (Salario) as Salario_Promedio
from Empleados 
group by sexo
order by Sexo;

--Listar por sexo Maximo y Minimo salario 

select sexo, max (Salario) as Salario_Maximo, min (Salario) as Salario_Minimo
from Empleados 
group by sexo
order by Sexo;

--Listar por sexo Cantidad empleados

select sexo, count(*) as Cant_Empleados
from Empleados
group by sexo
order by Sexo;

--Total Empleados
select count (*)
as Cant_Total_Empleados 
from empleados;


-- Listar para cada sexo la cantidad de empleados por departamento
select sexo, Depto, count(*) as Cant_Empleados
from Empleados
group by sexo, Depto
order by Sexo;


select sexo, Depto, count (Salario) as Cant_Empleados 
from Empleados 
group by sexo, Depto
order by Sexo;

-- Listar dptos en los que trabajan + de 2 personas

select Depto, 
count (*) as Cant_Empleados 
from Empleados 
group by Depto
having count (*)>2;

--OTRA FORMA:
select a.* 
from (
		select Depto, count(*) as Cant_Empleados
		from Empleados
		group by Depto
		) a
where a.Cant_Empleados > 2;


--Listar por empleado el salario, el calculo del incremento de  3% y salario total con incremento  .. cuanto queda salario con aumento de 3%

select Nombre, Salario, (Salario*0.03) as Incremento,
(salario+(Salario*0.03)) as Salario_Total, 
(Salario *1.03) as Salario_Total2 
from Empleados;

--Cant Empleados por total salario
-- Mostrar para cada departamento la cantidad de empleados y el total de salarios a pagar

select Depto, count(*) as Cant_Emp,
sum (Salario) as Tot_Sal
from Empleados
group by Depto;

select Depto, count(*) as Cant_Emp,
sum(Salario) as Tot_Sal, 
(count(*)*sum(Salario)) as Salario_X_Count
from Empleados
group by Depto;


-- 6) Listar el nombre y el salario de los empleados que trabajan en el departamento 5.
select Nombre, 
Salario from Empleados 
where Depto=5;

-- 7) Listar todos los datos de los mecanicos y choferes
select * from mecanicos
union
select * from Choferes;

select * from Mecanicos m
full outer join choferes c on
c.Nombre=m.Nombre;

-- 8) Listar todos los datos de los mecanicos pero que no son choferes

select m.* from Mecanicos m
left join choferes c on c.nombre= m.nombre
WHERE c.Nombre is null;

select m.*
from Choferes c
right join Mecanicos m on m.Nombre = c.Nombre
where c.Nombre is null;


-- 9) Listar el nombre de los mecánicos de la empresa Fast.
select Nombre
from Mecanicos
where Empresa = 'fast';

-- List empleados cuyo salario mayor igual  a 2000 y menor igual 5000

select *
from Empleados
where salario between 2000 and 5000;

-- otra forma
select * 
from Empleados
where  salario >= 2000 and salario <= 5000;

-- List empleados  cuyo nombre empieza con A

--comienza
select *
from Empleados
where nombre like 'a%' ;

--termina
select *
from Empleados
where nombre like '%a' ;

--contiene
select *
from Empleados
where nombre like '%der%' ;



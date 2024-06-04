--Consultas Ejercicio 5 TIENE 30 PREGUNTAS

--Simples y de reunión

--1.	Mostrar los datos de las válvulas cuyo diámetro esté entre 10 y 20 mm

select*
from valvulas
where diamValv between 10 and 20;

--2.	Mostrar RUT y Descripción de todas las Petroquímicas
select dscPet, rutPet
from petroquimica;

--3.	Mostrar todos los datos de los arrendamientos entre el 01/01/2010 y el 31/12/2013
select *
from arrienda
where fchArr between '01/01/2010' and '31/12/2013';

--4.	Mostrar número de serie y descripción de todas las válvulas

select * from
valvulas;

select * from
series;

select distinct s.numSerie, v.dscValv
from series s, valvulas v
where v.codValv= s.codValv;

select distinct s.numSerie, v.dscValv
from series s
join valvulas v on s.codValv= v.codValv;

--5.	Mostrar número de serie y descripción de las válvulas arrendadas en mayo de 2013

select distinct s.numSerie, v.dscValv
from series s, arrienda a, valvulas v
where a.numSerie=s.numSerie
and s.codValv=v.codValv
and a.fchArr between '01-05-2013' and '31-05-2013';

--6.	Mostrar número de serie, descripción de la válvula, descripción de la Petroquímica para todas las válvulas arrendadas.

select a.numSerie, v.dscValv, p.dscPet 
from arrienda a, petroquimica p, valvulas v
where p.rutPet= a.rutPet
and v.codValv=a.codValv

--7.	Mostrar los datos de los Inspectores asignados a las solicitudes de inspección (no mostrar datos repetidos).



select distinct i.* 
from inspectores i, solicitan s
where i.ciInsp= s.ciInsp;

select distinct i.*
from inspectores i
join solicitan s on s.ciInsp= i.ciInsp;

--8.	Mostar las descripciones de las válvulas que son compatibles entre si.

select * from valvulas;
select * from compatible;

select distinct v.dscValv, v2.dscValv
from valvulas v, compatible c, valvulas v2
where v.codValv=c.codValv 
and v2.codValv=c.CompValv;

--9.	Mostrar la descripción de la petroquímica y la descripción de los lugares donde están sus sucursales.



select distinct p.dscPet,l.dscLug
from lugares l, sucursal s, petroquimica p
where s.codLug=l.codLug
and p.rutPet=s.rutPet;

--10.	 Para cada válvula mostrar número de serie y la descripción de sus dimensiones
select * from valvulas;
select * from series;
select * from dimensiones;

select v.codValv, s.numSerie, d.dscDim
from series s, dimensiones d, valvulas v
where s.codDim=d.codDim
and v.codValv=s.codValv;

--Con funciones de agregación

--11 Mostrar la cantidad total de modelos de válvulas diferentes arrendadas en el año
select YEAR (a.fchArr) Año, COUNT (distinct a.numSerie) Cant_Total
from arrienda a
group by YEAR (a.fchArr)


--11B En el año cuya cantidad sea <10
 

select YEAR (a.fchArr) Año, COUNT (distinct a.numSerie) Cant_Total
from arrienda a
group by YEAR (a.fchArr)
having count (distinct a.numSerie)<10;

--12 Mostrar la fecha del último arrendamiento

select * from arrienda

select max (fchArr)Ultima_Fecha
from arrienda

--13 Mostrar para cada válvula cuántos números de serie tiene


SELECT v.codValv, COUNT(s.numSerie) Cant_NumSeries
from valvulas v, series s
where v.codValv=s.codValv
group by v.codValv;


--14Mostrar la descripción de cada Petroquímica y cuántas sucursales tiene.

select p.dscPet, count (s.numSuc) Cant_Sucursal
from petroquimica p, sucursal s
where p.rutPet=s.rutPet
group by p.dscPet;

--15 Mostrar para cada válvula cuál fue su primer arrendamiento y cuantas veces fue arrendada por cada número de serie.

select * from
arrienda a



--16 Mostrar cuántas solicitudes de inspección tuvo cada Agencia Gubernamental.

select * from inspecciones
select * from solicitan
select * from of_gub

select o.codOfice, count (s.numInsp) Cant_Solicitudes 
from solicitan s, of_gub o
where s.codOfice= o.codOfice
group by o.codOfice;

--16b Mostrar cuántas solicitudes de inspección tuvo cada Agencia Gubernamental mientras la cantidad sea igual al maximo.

select o.codOfice, count (s.numInsp) Cant_Insp
from solicitan s, of_gub o
where s.codOfice= o.codOfice
group by o.codOfice;


(select max(a.Cant_Insp)
							from (	select count(s.numInsp) Cant_Insp
									from of_gub o, solicitan s
									where s.codOfice = o.codOfice
									group by o.codOfice) a);

-- 17 Mostrar cuántos modelos diferentes de válvula fueron arrendados por cada Petroquímica

select p.dscPet, count(distinct s.codValv) Cant
from arrienda a, series s, petroquimica p
where a.rutPet =p.rutPet
and s.numSerie = a.numSerie
group by p.dscPet;



-- 17 b - Mostrar cuántos modelos diferentes de válvula fueron arrendados por cada Petroquímica con la menor cantidad

select p.dscPet, count(distinct s.codValv) Cant
from arrienda a, series s, petroquimica p
where a.rutPet =p.rutPet
and s.numSerie = a.numSerie
group by p.dscPet
having count(distinct s.codValv) = (select MIN(a.Cant)
									from (select count(distinct s.codValv) Cant
									from arrienda a, series s, petroquimica p
									where a.rutPet =p.rutPet
									and s.numSerie = a.numSerie
									group by p.dscPet) a);

-- 18 ¿ Cuántas inspecciones tuvo cada inspector hasta el momento ?

select * from solicitan;
select*from inspectores;

select i.ciInsp, count (s.numInsp) Cant_Insp
from solicitan s, inspectores i
where i.ciInsp=s.ciInsp
group by i.ciInsp;

--si quiero ver los inspectores sin inspecciones (es decir los 0)

select i.ciInsp, count (s.numInsp) Cant_Insp
from solicitan s, inspectores i
where i.ciInsp=s.ciInsp
group by i.ciInsp;

 --19 Modificar el ejercicio 13 para que solo muestre las válvulas que tuvieron menos de 10 número de serie.

 SELECT v.codValv, COUNT(s.numSerie) Cant_NumSeries
from valvulas v, series s
where v.codValv=s.codValv
group by v.codValv
having count (s.numSerie)<10;

--20 Modificar el ejercicio 17 para que muestre solo las Petroquímicas que arrendaron menos de 2 modelos diferentes de válvulas.

select p.dscPet, count(distinct s.codValv) Cant
from arrienda a, series s, petroquimica p
where a.rutPet =p.rutPet
and s.numSerie = a.numSerie
group by p.dscPet;

--
select p.dscPet, count(distinct s.codValv) Cant
from arrienda a, series s, petroquimica p
where a.rutPet =p.rutPet
and s.numSerie = a.numSerie
group by p.dscPet
having count (distinct s.codValv)<2;


-- Ejercicios de sub consultas:-------------------------------------------------------------------------------------------------------------------------------------------

-- 21 - Para el arrendamiento más reciente, mostrar código y descripción de los modelos de válvulas de dicha fecha.

select a.codValv, v.dscValv
from arrienda a, valvulas v
where a.codValv=v.codValv
and a.fchArr = (select max(a.fchArr) from arrienda a1);


select a.codValv, v.dscValv
from arrienda a, valvulas v
where a.codValv = v.codValv
and a.fchArr = (select MAX(a1.fchArr) from arrienda a1);


select * from valvulas;
select * from series;
select*from arrienda;

select * from solicitan;
select*from inspectores;
select*from lugares;
select*from petroquimica;
select*from sucursal;

-- 22 - Mostrar los modelos de válvulas que nunca fueron arrendados en el año 2013

select distinct a.codValv
from arrienda a 
where year(a.fchArr)<>2013;

select distinct a.codValv
from arrienda a
where year(a.fchArr) <> 2013;

--
select *
from arrienda a
where year(a.fchArr) <> 2014 and month(a.fchArr) <> 2;

--
select *
from arrienda a
where year(a.fchArr) <> 2014 or month(a.fchArr) <> 2;


-- 23 - Mostrar el nombre de los inspectores que nunca realizaron inspecciones.

select i.nomInsp
from inspectores i
left join solicitan s on s.ciInsp = i.ciInsp
where s.numInsp is null;

-- otra forma
select i.nomInsp
from inspectores i
where i.ciInsp not in (select distinct s.ciInsp from solicitan s);

-- otra forma
select i.nomInsp
from inspectores i
where not exists (select 1 
					from solicitan s 
					where s.ciInsp = i.ciInsp);


-- otra forma
select i.nomInsp
from inspectores i
left join solicitan s on s.ciInsp = i.ciInsp
group by i.ciInsp, i.nomInsp
Having count(s.numInsp)  = 0;

-- otra forma
select i.nomInsp
from inspectores i
left join solicitan s on s.ciInsp = i.ciInsp
group by i.nomInsp
Having count(s.numInsp)  = 0;

-- 24 - Mostrar los datos de las petroquímicas que hicieron arrendamientos en la fecha más antigua.
select p.*
from petroquimica p
join arrienda a ON p.rutPet = a.rutPet
where a.fchArr = (select min(fchArr) Mas_Antigua from arrienda);

-- 25 - Mostrar los datos de los lugares que tienen sucursales de petroquímicas.
select distinct l.*
from lugares l, sucursal s, petroquimica p
where l.codLug = s.codLug
and p.rutPet = s.rutPet;

-- otra forma
SELECT distinct l.*
from lugares l
inner join sucursal s ON s.codLug = l.codLug;

-- otra forma
SELECT distinct l.*
from lugares l
where l.codLug in (select distinct s.codLug from sucursal s);

-- otra forma
SELECT distinct l.*
from lugares l
where exists (select 1 from sucursal s where l.codLug = s.codLug);

-- 26 - Mostrar cuántos modelos diferentes de válvula fueron arrendados por cada Petroquímica, solo deben figurar aquellos modelos cuya cantidad sea superior al total general arrendado en el mes de febrero de 2014.
select a.rutPet, count( distinct a.codValv) Cant
from  series s 
join arrienda a on a.numSerie= a.numSerie
group by a.rutPet
having  count(distinct a.codValv) > (select count(distinct a1.codValv) Total_Arrendado
							from arrienda a1
							where month(a1.fchArr) = 2 and year(a1.fchArr) = 2014); 

-- Otra forma 
select p.dscPet, count( distinct a.codValv) Cant
from  petroquimica p
join arrienda a on a.rutPet = p.rutPet
group by p.dscPet
having  count(distinct a.codValv) > (select count(distinct a1.codValv) Total_Arrendado
							from arrienda a1
							where month(a1.fchArr) = 2 and year(a1.fchArr) = 2014); 

-- 27 - Para cada petroquímica, mostrar su nombre, la cantidad de modelos de válvula diferentes que arrendó, cuál fue la fecha de su primer arrendamiento 
--y cuál fue la fecha de su último arrendamiento, si la petroquímica no tiene arrendamientos, también se deben mostrar sus datos.
SELECT dscPet,
	(SELECT COUNT(DISTINCT(codValv)) 
	FROM arrienda 
	WHERE rutPet=petroquimica.rutPet) as total,
		(SELECT MIN(fchArr)
		FROM arrienda
		WHERE rutPet=petroquimica.rutPet) as primer,
			(SELECT MAX(fchArr)
		FROM arrienda  
		WHERE rutPet=petroquimica.rutPet) as ultimo
FROM petroquimica 



-- 28 - Para las válvulas de tipo retención (‘R’) poner el valor de la presión de acuerdo al promedio de valores de presión de todas las válvulas del mismo tipo.

update valvulas set presValv = (select AVG(v.presValv) 
					from valvulas v
					where v.tipoValv = 'R') 
where tipoValv = 'R';



-- 29 - Borrar de la tabla dimensiones todos aquellos registros que no tienen ningún número de serie asociado.
delete from dimensiones 
where codDim not in (select distinct codDim from series);


-- 30 - Del total de arrendamientos que tuvo cada petroquímica, obtener cuál fue el promedio, el máximo y el mínimo.

select AVG(a.Cant_Total) Prom, MAX(a.Cant_Total) Maximo, MIN(a.Cant_Total) Min
from (select a.rutPet, count(*) Cant_Total
		from arrienda a
		group by a.rutPet) a;

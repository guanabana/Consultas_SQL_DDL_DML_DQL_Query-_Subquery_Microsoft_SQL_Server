-- DDL
USE master;
GO
CREATE DATABASE BD_Ejercicio2;
GO
USE BD_Ejercicio2;
GO

--drop table Telefono;
--drop table Empleados;
--drop table Mecanicos;
--drop table Choferes;

create table Empleados(
Nombre varchar(20), 
Nro int not null primary key,
Depto int , 
Salario int ,
Sexo char(1));


Create table Telefono(
Nro int not null foreign key references Empleados,
tel varchar(10),
primary key (Nro, tel));


CREATE TABLE Mecanicos(
 Nombre VARCHAR (20),
 Salario INT , 
 Empresa VARCHAR(20),
 );

 
CREATE TABLE Choferes(
 Nombre VARCHAR (20),
 Salario INT , 
 Empresa VARCHAR(20),
 );



GO
-- DML

insert into Empleados (Nombre, Nro, Depto, Salario, Sexo)values ('Federico Azurra', 333456, 5, 7850, 'M');
insert into Empleados (Nombre, Nro, Depto, Salario, Sexo)values ('Paola Valdés', 453321, 4, 6980, 'F');
insert into Empleados (Nombre, Nro, Depto, Salario, Sexo)values ('Héctor Torres', 889546 ,5 ,8456, 'M');
insert into Empleados (Nombre, Nro, Depto, Salario, Sexo)values ('Maria Fernandez', 238956, 2, 9850, 'F');
insert into Empleados (Nombre, Nro, Depto, Salario, Sexo)values ('Sonia Ball', 889549, 2, 12365,'F');
insert into Empleados (Nombre, Nro, Depto, Salario, Sexo)values ('Martin Torres', 564520 ,5 ,4600, 'M');

insert into telefono (Nro,tel)values (333456, '094123456');
insert into telefono (Nro,tel)values (333456, '093123456');
insert into telefono (Nro,tel)values (238956, '091474852');
insert into telefono (Nro,tel)values (564520, '099654123');
insert into telefono (Nro,tel)values (564520, '094652365');

insert into Mecanicos (Nombre,Salario, Empresa)values ('A.Blanco', 6500, 'Fast');
insert into Mecanicos (Nombre,Salario, Empresa)values ('J.Martin', 5850, 'Giro');
insert into Mecanicos (Nombre,Salario, Empresa)values ('F.Salterain', 4050, 'Giro');
insert into Mecanicos (Nombre,Salario, Empresa)values ('P.Muñoz', 9700, 'Fast');
insert into Mecanicos (Nombre,Salario, Empresa)values ('R.Duald', 12300, 'Giro');

insert into Choferes (Nombre,Salario, Empresa)values ('A.Rey',4500, 'Veloz');
insert into Choferes (Nombre,Salario, Empresa)values ('S.Santos', 4550, 'Fast');
insert into Choferes (Nombre,Salario, Empresa)values ('J.Martin', 5850, 'Giro');
insert into Choferes (Nombre,Salario, Empresa)values ('P.Muñoz', 9700, 'Fast');
insert into Choferes (Nombre,Salario, Empresa)values ('G.Gallo', 10600, 'Giro')





CREATE DATABASE BD2_Ej1_EquiposFutbol
GO
USE BD2_Ej1_EquiposFutbol 
GO


/* 1 - Script de creación de todas las tablas, teniendo en cuenta las restricciones indicadas y las no indicadas*/

CREATE TABLE EQUIPOS(codEq numeric(4),
                     nomEq varchar(20),
					 presidente varchar(30),
					 CONSTRAINT PK_Equipos PRIMARY KEY(codEq),
					 CONSTRAINT UK_Presi UNIQUE(presidente)) 

CREATE TABLE CANCHAS(cancha character(10),
                     direccion varchar(30) not null,
					 zona varchar(20),
					 estado character(1),
					 codEq numeric(4),
					 CONSTRAINT PK_Cancha PRIMARY KEY(cancha),
					 CONSTRAINT FK_EquipoCancha FOREIGN KEY(codEq) REFERENCES Equipos(codEq),
					 CONSTRAINT CK_ZonaCancha CHECK(zona IN ('Sur','Norte','Este','Oeste')),
					 CONSTRAINT CK_EstadoCancha CHECK(estado IN ('P','H'))) 

CREATE TABLE PARTIDOS(codEq_l numeric(4),
                      codEq_v numeric(4),
					  fecha date,
					  goles_l numeric(2),
					  goles_v numeric(2),
					  cancha character(10),
					  CONSTRAINT PK_Partido PRIMARY KEY(codEq_l,codEq_v,fecha),
					  CONSTRAINT FK_Local FOREIGN KEY(codEq_l) REFERENCES Equipos(codEq),
					  CONSTRAINT FK_Visita FOREIGN KEY(codEq_v) REFERENCES Equipos(codEq),
					  CONSTRAINT FK_CanchaPartido FOREIGN KEY(cancha) REFERENCES canchas(cancha)) 

CREATE TABLE JUGADORES(ci numeric(10),
                       nombre varchar(30) not null,
					   direccion varchar(30),
					   sueldo numeric(12,2),
					   codEq numeric(4),
					   CONSTRAINT PK_Jugador PRIMARY KEY(ci),
					   CONSTRAINT FK_EquipoJugador FOREIGN KEY(codEq) REFERENCES Equipos(codEq),
					   CONSTRAINT CK_SueldoJugador CHECK(sueldo >= 20000)) 

/*2. Modificar la tabla partidos agregando un campo árbitro de hasta 30 caracteres*/

ALTER TABLE PARTIDOS ADD arbitro varchar (30); /*2. agregando campo*/


--3. Modificar la tabla canchas de tal manera que permita tener el estado X (indeterminado).

ALTER TABLE CANCHAS DROP CONSTRAINT CK_EstadoCancha /*ACA BORRO: modificar constraint, BORRAR Y HACER DE NUEVO*/

-- 3-A Modificar la tabla canchas de tal manera que permita tener el estado determinado como P, H, o X.
ALTER TABLE CANCHAS ADD CONSTRAINT CK_EstadoCancha CHECK(estado IN ('P','H','X')) /*AGREGO CONSTRAINT*/

/*
4. Crear una tabla Arbitros con la ci como identificador y un nombre de hasta 30 caracteres,
luego incluir la relación de esta tabla con la tabla partidos, para eso debe borrar el campo
creado en el punto 2.*/

CREATE TABLE ARBITROS(ci numeric(10),
						nombre varchar(30),
						CONSTRAINT PK_Arbitro PRIMARY KEY(ci))

--RELACION CON PARTIDOS
ALTER TABLE PARTIDOS DROP COLUMN ARBITRO
--AGREGAR CAMPO CEDULA
ALTER TABLE PARTIDOS ADD ci NUMERIC(10)

--AGREGAR LA RESTRICCION DE INTEGRIDAD

ALTER TABLE PARTIDOS ADD CONSTRAINT FK_ArbitroPartido FOREIGN KEY (ci) REFERENCES ARBITROS(ci)

--5. Crear los índices de todas las claves foráneas

--aSI SE creA: CREATE INDEX IDX_FechaPArtido ON PARTIDOS(FECHA)
--aSI SE boRRA: DROP INDEX IDX_FechaPArtido ON PARTIDOS

CREATE INDEX IDX_FK_ArbitroPartido ON PARTIDOS(ci)
CREATE INDEX IDX_FK_CanchaPartido ON PARTIDOS(cancha)
CREATE INDEX IDX_FK_EquipoLocal ON PARTIDOS(codEq_l)
CREATE INDEX IDX_FK_EquipoVisitante ON PARTIDOS(codEq_v)

CREATE INDEX IDX_FK_EquipoCancha ON CANCHAS(codEq)
CREATE INDEX IDX_FK_FK_EquipoJugador ON JUGADORES(codEq)


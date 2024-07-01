
CREATE DATABASE BD2_Ej1_Constructora

USE BD2_Ej1_Constructora

/*creo Tablas*/
/*CIUDAD(*codCiud, nomCiud, dptoCiud)*/

CREATE TABLE CIUDAD(codCiud NUMERIC(6) PRIMARY KEY,
					nomCiud VARCHAR(30) NOT NULL,
					dptoCiud VARCHAR(30)NOT NULL)

/*BORRRAR LA TABLA PARA PODRE CREARLA CON BUENAS PARACTICAS */


DROP TABLE CIUDAD

CREATE TABLE CIUDAD(codCiud NUMERIC(6),
					nomCiud VARCHAR(30) NOT NULL,
					dptoCiud VARCHAR(30)NOT NULL
					CONSTRAINT PK_Ciudad PRIMARY KEY (codCiud))

/*RNE: El mail de Empleado,(en caso de tener) no se puede repetir.
  RNE: El sueldo del Empleado debe ser mayor al minimo (20.000)*/

CREATE TABLE EMPLEADO(ci NUMERIC(10),
					  nombre VARCHAR(30) NOT NULL,
					  tel VARCHAR(30), 
					  dir VARCHAR(50) NOT NULL, 
					  mail VARCHAR(50), 
					  sueldo NUMERIC(12,2), 
					  codCiud NUMERIC(6),
					  CONSTRAINT PK_Empleado PRIMARY KEY (ci),
					  CONSTRAINT FK_CiudadEmpleado FOREIGN KEY (codCiud) REFERENCES Ciudad (codCiud),
					  CONSTRAINT CK_SueldoEmpleado CHECK (sueldo>20000),
					  CONSTRAINT UK_MailEmpleado UNIQUE (mail))

/*Obra tiene Categoría: Empresa y Obra Particular
  RNE: Obra solo puede tomar 2 valores 'E', O 'P'
  RNE: Si es Empresa, SI o SI  se debe cargar 'numExpediente, NO permiso' --NO SE RESUELVE CON CONSTRAINT SINO CON TRIGGERS- 
  RNE: Si es Particular, SI o SI, se debe cargar el ''permiso' NO numExpediente --NO SE RESUELVE CON CONSTRAINT SINO CON TRIGGERS-TIPO STEF 2'
  rne: DEFAULT: Por defecto se deja campo E //  CONSTRAINT DF_TipoObraPorDefecto DEFAULT(TipoObra 'E')*/

CREATE TABLE OBRA(codObra NUMERIC(6),
				  dscObra VARCHAR(40)NOT NULL, 
				  dirObra VARCHAR(50) NOT NULL, 
				  codCiud NUMERIC(6), 
				  TipoObra VARCHAR(1) , 
				  numExp NUMERIC(10),
				  permiso NUMERIC(10),
				  CONSTRAINT PK_Obra PRIMARY KEY (codObra),
				  CONSTRAINT FK_CiudadObra FOREIGN KEY (codCiud) REFERENCES Ciudad (codCiud), 
				  CONSTRAINT CK_TipoObra CHECK (TipoObra IN ('E', 'P')))
				  
/* TABLA TRABAJA SIN SIMPLIFICAR CLAVE COMPUESTA QUE TIENE 3 PK*/

CREATE TABLE TRABAJA(ci NUMERIC(10),
					codObra NUMERIC(6), 
				    ingresa DATE, 
					sale DATE,
					CONSTRAINT PK_Trabaja PRIMARY KEY (ci, codObra, ingresa),
					CONSTRAINT FK_CiTrabaja FOREIGN KEY (ci) REFERENCES Empleado (ci),
					CONSTRAINT FK_CodObraTrabaja FOREIGN KEY (codObra) REFERENCES Obra (codObra),
					 )

/*MEJORAS PARA PODER SIMPLIFICAR, NO TENER CLAVES COMPUESTAS (MUCHOS JOINS) CON ID AUTONUMERADO*/

DROP TABLE TRABAJA

CREATE TABLE TRABAJA(idTrabaja NUMERIC (10)IDENTITY,
					ci NUMERIC(10),
					codObra NUMERIC(6), 
				    ingresa DATE, 
					sale DATE,
					CONSTRAINT PK_Trabaja PRIMARY KEY (idTrabaja),
					CONSTRAINT UK_Trabaja UNIQUE (ci, codObra, ingresa),
					CONSTRAINT FK_CiTrabaja FOREIGN KEY (ci) REFERENCES Empleado (ci),
					CONSTRAINT FK_CodObraTrabaja FOREIGN KEY (codObra) REFERENCES Obra (codObra))


					/***********************************************ALTER TABLE************************************************************/
                    /*MODIFICAR ESTRUCTURAS DDL ALTER TABLE: Agregar, borrar, modificar COLUMNAS-- borrar, modificar, agregar CONSTRAINTS */


/**********Agregar columna  para Ciudad  para poder cargar pais***********************/

ALTER TABLE Ciudad ADD pais VARCHAR (30) NOT NULL

/*ACHICR TAMAÑO CAMPO dptoCiud --esto puede hacerse porque no tengo datos ingresados**/

ALTER TABLE Ciudad ALTER COLUMN dptoCiud VARCHAR(20) NOT NULL


/***********AGREGAR CONSTRATINT NOT NULL A INGRESA EN TRABAJA*************************/

ALTER TABLE Trabaja ALTER COLUMN ingresa DATE NOT NULL /*Genera error porque ingresa es constraint UNIQUE*/


/*1. ROMPO RESTRICCION*/       ALTER TABLE Trabaja DROP CONSTRAINT UK_Trabaja

/*2. MODIFICAR COLUMNA*/       ALTER TABLE Trabaja ALTER COLUMN ingresa DATE NOT NULL

/*3. CREAR RESTRICCION*/       ALTER TABLE Trabaja ADD CONSTRAINT UK_Trabaja UNIQUE (ci, codObra, ingresa)


/************Borrar Campo Tel de Tabla Empleado****************************************/

/*1 BORRAR COLUMNA*/           ALTER TABLE Empleado DROP COLUMN tel


/************Agregar un Tipo de Obra- CONSTRAINCT CHECK DE OBRA***********************/ 

/*1 BORRRAR CONSTRAINT CHECK*/ ALTER TABLE Obra DROP CONSTRAINT CK_TipoObra 

/*1 CREAR CONSTRAINT CHECK*/   ALTER TABLE Obra ADD CONSTRAINT CK_TipoObra CHECK (TipoObra IN ('E', 'P', 'X'))
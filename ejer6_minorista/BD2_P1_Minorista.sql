CREATE DATABASE BD2_P1_Minorista
USE BD2_P1_Minorista

CREATE TABLE Proveedores(prov_id NUMERIC(5),
						 prov_nombre VARCHAR(20) not null,
						 prov_mail  VARCHAR(20),
						 prov_tel NUMERIC(10),
						 prov_otros VARCHAR (10),
						 CONSTRAINT PK_Proveedores PRIMARY KEY (prov_id),
						 CONSTRAINT UK_MailProveedor UNIQUE (prov_mail)
						 )

CREATE TABLE Categorias(cat_id NUMERIC(5),
						cat_decrip VARCHAR(20) NOT NULL,
						cat_tipo VARCHAR(20),
						CONSTRAINT PK_Categorias PRIMARY KEY (cat_id),
						constraint CK_TipoCategorias CHECK (cat_tipo IN ('Electronicos', 'Vehiculos', 'Electrodomésticos','Otros'))
						)

CREATE TABLE Marcas(marca_id  NUMERIC(5),
					marca_decrip VARCHAR(30) ,
					marca_region VARCHAR(30),
					CONSTRAINT PK_Marcas PRIMARY KEY (marca_id),
					CONSTRAINT CK_RegionMarca CHECK (marca_region in('Asia', 'Europa', 'Lationomaerica', 'EEUU', 'Otros'))
					)

CREATE TABLE Items(item_id CHARACTER(10),
					item_descrip VARCHAR(20) NOT NULL,
					promedio_mensual NUMERIC (10,2),
					cant_reorden NUMERIC (10,2),
					cat_id NUMERIC(5),
					marca_id NUMERIC(5),
					CONSTRAINT PK_Items PRIMARY KEY (item_id),
					CONSTRAINT FK_CategoriaItems FOREIGN KEY (cat_id) REFERENCES Categorias (cat_id),
					CONSTRAINT FK_MarcaItems FOREIGN KEY (marca_id) REFERENCES Marcas (marca_id),
					CONSTRAINT CK_StockPromedioItems CHECK (promedio_mensual>=10)
					)

				
CREATE TABLE Nivel_Stock(item_id CHARACTER(10),
						stock_fch DATE,
						cantidad NUMERIC (10,2),
						CONSTRAINT PK_NivelStock PRIMARY KEY (item_id, stock_fch),
						CONSTRAINT FK_ItemNivelStock FOREIGN KEY (item_id) REFERENCES Items (item_id)
						)


CREATE TABLE Compras(item_id CHARACTER(10),
					 prov_id  NUMERIC(5),
					 fecha DATE,
					 cantidad NUMERIC (10,2),
					 fch_inic DATE,
					 fch_fin DATE,
					 precio NUMERIC (10,2),
					 descuento NUMERIC (10,2),
					 CONSTRAINT PK_Compras PRIMARY KEY (item_id, prov_id, fecha),
					 CONSTRAINT FK_ItemCompra FOREIGN KEY (item_id) REFERENCES Items (item_id),
					 CONSTRAINT FK_ProveedorCompra FOREIGN KEY (prov_id) REFERENCES Proveedores (prov_id) ,
					 CONSTRAINT CK_DescuentoCompra CHECK (descuento BETWEEN 0.10 AND 0.25)
					   )

/*A- Eliminar el campo prov_otros de la tabla Proveedores*/
ALTER TABLE Proveedores DROP COLUMN  prov_otros

/*B- Agregar el tipo de categoría ‘Cocina’ a la tabla Categorías*/

ALTER TABLE Categorias DROP CONSTRAINT CK_TipoCategorias
ALTER TABLE Categorias ADD CONSTRAINT CK_TipoCategorias CHECK (cat_tipo IN ('Electronicos', 'Vehiculos', 'Electrodomésticos','Otros', 'Cocina'))

/*C- Cambiar el tamaño de la descripción de marcas y llevarlo a 50 caracteres */

ALTER TABLE Marcas ALTER COLUMN marca_decrip VARCHAR(50)

/* D- En la tabla Items agregar el campo color de 10 caracteres y el campo peso de números con decimales.*/

ALTER TABLE Items ADD Color VARCHAR(10)
ALTER TABLE Items ADD Peso NUMERIC (10,2)

/* E- Asegurarse que los campos fch_inic y fch_fin sean del tipo datetime*/

ALTER TABLE Compras AlTER COLUMN fch_inic DATETIME
ALTER TABLE Compras AlTER COLUMN fch_fin DATETIME

/*Crear la tabla Paises que tenga un código de país de 4 caracteres que lo identifica, una descripción de 40
caracteres y un nombre de continente de 30 caracateres.*/

CREATE TABLE PAISES (cod_pais CHARACTER (4),
					 descripcion_pais VARCHAR (40),
					 nombre_pais VARCHAR (30),
					 CONSTRAINT PK_Paises PRIMARY KEY (cod_pais))

/*Modificar la tabla Proveedores para que también se registre el país del proveedor, se debe crear la
restricción correspondiente.*/

ALTER TABLE Proveedores ADD cod_pais CHARACTER (4)
ALTER TABLE Proveedores ADD CONSTRAINT FK_PaisProveedor FOREIGN KEY (cod_pais) REFERENCES Pais (cod_pais)
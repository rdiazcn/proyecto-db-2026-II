
-- Sistema de Gestión y Emisión de Facturas
-- Diseño físico (DDL) en PostgreSQL: 15 tablas


-- Limpieza para poder volver a ejecutar el script

DROP TABLE IF EXISTS proveedor       CASCADE;
DROP TABLE IF EXISTS categoria       CASCADE;
DROP TABLE IF EXISTS sucursal        CASCADE;
DROP TABLE IF EXISTS rol             CASCADE;
DROP TABLE IF EXISTS tipo_documento  CASCADE;


-- Tablas independientes (catálogos)

CREATE TABLE tipo_documento (
    codigo      VARCHAR(10) NOT NULL,
    descripcion VARCHAR(50) NOT NULL,
    longitud    SMALLINT    NOT NULL,
    CONSTRAINT pk_tipo_documento PRIMARY KEY (codigo),
    CONSTRAINT ck_tipo_documento_longitud CHECK (longitud > 0)
);

CREATE TABLE rol (
    codigo_rol  SMALLSERIAL,
    nombre      VARCHAR(30) NOT NULL,
    descripcion VARCHAR(100),
    CONSTRAINT pk_rol PRIMARY KEY (codigo_rol),
    CONSTRAINT uk_rol_nombre UNIQUE (nombre)
);

CREATE TABLE sucursal (
    codigo_sucursal SERIAL,
    nombre          VARCHAR(60)  NOT NULL,
    direccion       VARCHAR(150) NOT NULL,
    telefono        VARCHAR(20),
    CONSTRAINT pk_sucursal PRIMARY KEY (codigo_sucursal)
);

CREATE TABLE categoria (
    codigo_categoria SMALLSERIAL,
    nombre           VARCHAR(60) NOT NULL,
    descripcion      VARCHAR(150),
    CONSTRAINT pk_categoria PRIMARY KEY (codigo_categoria),
    CONSTRAINT uk_categoria_nombre UNIQUE (nombre)
);

CREATE TABLE proveedor (
    ruc          CHAR(11)     NOT NULL,
    razon_social VARCHAR(120) NOT NULL,
    direccion    VARCHAR(150) NOT NULL,
    correo       VARCHAR(100) NOT NULL,
    telefono     VARCHAR(20),
    CONSTRAINT pk_proveedor PRIMARY KEY (ruc)
);

-- Documentación (COMMENT ON)

COMMENT ON TABLE tipo_documento  IS 'Tipos de documento de identidad de los clientes (DNI, RUC).';
COMMENT ON TABLE rol             IS 'Roles que pueden tener los empleados.';
COMMENT ON TABLE sucursal        IS 'Sucursales de la empresa.';
COMMENT ON TABLE categoria       IS 'Categorías del catálogo de productos y servicios.';
COMMENT ON TABLE proveedor       IS 'Proveedores que suministran productos.';

-- Datos iniciales de los catálogos

INSERT INTO tipo_documento (codigo, descripcion, longitud) VALUES
    ('DNI', 'Documento Nacional de Identidad', 8),
    ('RUC', 'Registro Único de Contribuyentes', 11);


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
-- Tabla estado_factura
CREATE TABLE estado_factura (
    codigo_estado SMALLSERIAL,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT pk_estado_factura PRIMARY KEY (codigo_estado)
);

--  Tabla metodo_pago
CREATE TABLE metodo_pago (
    codigo_metodo SMALLSERIAL,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT pk_metodo_pago PRIMARY KEY (codigo_metodo)
);

-- Tabla cliente
CREATE TABLE cliente (
    numero_documento VARCHAR(20) NOT NULL,
    codigo_tipo_documento VARCHAR(10) NOT NULL,
    nombre_razon_social VARCHAR(150) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    estado VARCHAR(20) NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (numero_documento),
    CONSTRAINT fk_cliente_tipo_doc FOREIGN KEY (codigo_tipo_documento) REFERENCES tipo_documento(codigo)
);

-- Tabla empleado
CREATE TABLE empleado (
    codigo_empleado SERIAL,
    codigo_rol SMALLINT NOT NULL,
    codigo_sucursal INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY (codigo_empleado),
    CONSTRAINT fk_empleado_rol FOREIGN KEY (codigo_rol) REFERENCES rol(codigo_rol),
    CONSTRAINT fk_empleado_sucursal FOREIGN KEY (codigo_sucursal) REFERENCES sucursal(codigo_sucursal)
);

-- Tabla producto
CREATE TABLE producto (
    codigo VARCHAR(20) NOT NULL,
    codigo_categoria SMALLINT NOT NULL,
    ruc_proveedor CHAR(11),
    descripcion VARCHAR(150) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    CONSTRAINT pk_producto PRIMARY KEY (codigo),
    CONSTRAINT fk_producto_categoria FOREIGN KEY (codigo_categoria) REFERENCES categoria(codigo_categoria),
    CONSTRAINT fk_producto_proveedor FOREIGN KEY (ruc_proveedor) REFERENCES proveedor(ruc)
);
-----------------------------------------------
--tabla inventario
CREATE TABLE inventario (
    codigo_sucursal     INTEGER NOT NULL,
    cantidad_disponible INTEGER NOT NULL DEFAULT 0,
    stock_minimo        INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT fk_inventario_sucursal 
        FOREIGN KEY (codigo_sucursal) 
        REFERENCES sucursal (codigo_sucursal) 
        ON DELETE CASCADE
);
--tabla factura
CREATE TABLE factura (
    id_factura    SERIAL,
    serie         VARCHAR(10) NOT NULL,
    correlativo   INTEGER NOT NULL,
    fecha_emision DATE NOT NULL DEFAULT CURRENT_DATE,
    observacion   TEXT,
    CONSTRAINT pk_factura PRIMARY KEY (id_factura),
    CONSTRAINT uk_factura_numero UNIQUE (serie, correlativo)
);
--primera prueba del uso del insert
INSERT INTO(serie, correlativo,fecha_emision, observacion)
VALUES('serie1',1,'20-10-2026','venta realizada con descuento');

--tabla detalle_factura
CREATE TABLE detalle_factura (
    id_factura      INTEGER NOT NULL,
    cantidad        INTEGER NOT NULL CHECK (cantidad > 0),
    precio_aplicado NUMERIC(10, 2) NOT NULL CHECK (precio_aplicado >= 0),
    CONSTRAINT fk_detalle_factura 
        FOREIGN KEY (id_factura) 
        REFERENCES factura (id_factura) 
        ON DELETE CASCADE
);
--tabla nota_credito
CREATE TABLE nota_credito (
    id_nota_credito SERIAL,
    numero          VARCHAR(20) NOT NULL,
    fecha_emision   DATE NOT NULL DEFAULT CURRENT_DATE,
    motivo          TEXT NOT NULL,
    monto           NUMERIC(10, 2) NOT NULL CHECK (monto > 0),
    CONSTRAINT pk_nota_credito PRIMARY KEY (id_nota_credito),
    CONSTRAINT uk_nota_credito_numero UNIQUE (numero)
);
--tabla pago
CREATE TABLE pago (
    id_pago     SERIAL,
    numero_pago VARCHAR(20) NOT NULL,
    fecha_pago  DATE NOT NULL DEFAULT CURRENT_DATE,
    monto       NUMERIC(10, 2) NOT NULL CHECK (monto > 0),
    referencia  VARCHAR(100),
    CONSTRAINT pk_pago PRIMARY KEY (id_pago),
    CONSTRAINT uk_pago_numero UNIQUE (numero_pago)
);
--tabla metodo_pago
CREATE TABLE metodo_pago (
    codigo_metodo SERIAL,
    nombre        VARCHAR(50) NOT NULL,
    CONSTRAINT pk_metodo_pago PRIMARY KEY (codigo_metodo),
    CONSTRAINT uk_metodo_pago_nombre UNIQUE (nombre)
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

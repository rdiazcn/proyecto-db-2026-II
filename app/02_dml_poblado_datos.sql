-- rol
INSERT INTO rol (nombre, descripcion) VALUES
    ('Administrador', 'Gestiona usuarios, catálogos y configuración'),
    ('Vendedor',      'Emite facturas a los clientes'),
    ('Cajero',        'Registra los pagos recibidos'),
    ('Supervisor',    'Supervisa las ventas de la sucursal'),
    ('Contador',      'Revisa facturas y notas de crédito');
-- sucursal
INSERT INTO sucursal (nombre, direccion, telefono) VALUES
    ('Arequipa Centro', 'Calle Mercaderes 215, Cercado, Arequipa', '054-221100'),
    ('Arequipa Cayma',  'Av. Ramón Castilla 480, Cayma, Arequipa', '054-254300'),
    ('Arequipa Yanahuara', 'Av. Jerusalén 1020, Yanahuara, Arequipa', NULL),
    ('Lima Miraflores', 'Av. Larco 1150, Miraflores, Lima', '01-4455667'),
    ('Cusco Plaza',     'Av. El Sol 330, Cusco', '084-233900');
-- categoria
INSERT INTO categoria (nombre, descripcion) VALUES
    ('Tecnología', 'Equipos de cómputo y accesorios'),
    ('Hogar',      'Artículos para el hogar'),
    ('Oficina',    'Útiles y mobiliario de oficina'),
    ('Alimentos',  'Productos de consumo envasados'),
    ('Servicios',  'Servicios técnicos y de soporte');
--proveedor
INSERT INTO proveedor (ruc, razon_social, direccion, correo, telefono) VALUES
    ('20512345671', 'Distribuidora Andina S.A.C.', 'Av. Parra 410, Arequipa',   'ventas@andina.example.com',      '054-281234'),
    ('20498765432', 'TecnoImport Perú S.A.',       'Jr. Washington 780, Lima',  'contacto@tecnoimport.example.com', '01-3345566'),
    ('20601234567', 'Oficina Total E.I.R.L.',      'Av. Dolores 215, Arequipa', 'pedidos@oficinatotal.example.com', NULL),
    ('20577889900', 'Alimentos del Sur S.R.L.',    'Calle Puno 90, Juliaca',    'comercial@alisur.example.com',   '051-322100'),
    ('20433221100', 'Hogar y Más S.A.C.',          'Av. Grau 1300, Cusco',      'info@hogarymas.example.com',     '084-244500');
--metodo_pago
--cliente (depende de tipo_documento)
--empleado  (depende de rol y sucursal)
INSERT INTO empleado (codigo_rol, codigo_sucursal, nombre, correo) VALUES
    (1, 1, 'Rodrigo Díaz Cucalón',     'rodrigo.diaz@example.com'),
    (2, 1, 'Rony Choquecondo Luque',     'rony.choquecondo@example.com'),
    (2, 2, 'Alejandro Salazar Guillen',      'alejandro.salazar@example.com'),
    (3, 2, 'Regina Ticona Herrera',       'regina.ticona@example.com'),
    (4, 4, 'Maria Cornejo Lupa',        'maria.cornejo@example.com'),
    (5, 5, 'Jose Quispe Caceres',        'jose.quispe@example.com');
--producto (depende de categoria y proveedor)
--tipo_documento (ya poblado en init.sql)
--estado_factura
INSERT INTO estado_factura (nombre) VALUES
    ('Pendiente'),
    ('Pagada'),
    ('Anulada'),
    ('Vencida'),
    ('Parcialmente pagada');
--inventario (depende de producto y sucursal)
--factura (depende de cliente, empleado, sucursal y estado_factura)
--detalle_factura (depende de factura y producto)
--pago (depende de factura y metodo pago)
--nota_credito (depende de factura)
-- factura
-- inventario
INSERT INTO inventario (codigo_producto, codigo_sucursal, cantidad_disponible, stock_minimo) VALUES
    ('PROD-001', 1, 10, 2),
    ('PROD-002', 1, 50, 5),
    ('PROD-003', 2, 15, 3),
    ('PROD-004', 2, 8,  2),
    ('PROD-005', 1, 0,  0);

-- factura
INSERT INTO factura (serie, correlativo, fecha_emision, observacion, numero_documento, codigo_empleado, codigo_sucursal, codigo_estado) VALUES
    ('F001', 1, '2026-10-05', 'Venta al contado',          '70112233',    2, 1, 1),
    ('F001', 2, '2026-10-08', 'Atención preferencial',     '20123456789', 2, 1, 1),
    ('F001', 3, '2026-10-15', 'Entrega a domicilio',       '001234567',   3, 2, 1),
    ('F001', 4, '2026-10-20', 'Pago pendiente por revisar', '45678912',   3, 2, 1);    

-- detalle_factura
INSERT INTO detalle_factura (id_factura, codigo_producto, cantidad, precio_aplicado) VALUES
    (1, 'PROD-001', 1, 3500.00),
    (1, 'PROD-002', 2, 45.00),
    (2, 'PROD-004', 2, 450.00),
    (3, 'PROD-003', 1, 180.00),
    (4, 'PROD-005', 1, 100.00);

-- pago
INSERT INTO pago (numero_pago, fecha_pago, monto, referencia, id_factura, codigo_metodo) VALUES
    ('PAG-0001', '2026-10-05', 3590.00, NULL,          1, 1),
    ('PAG-0002', '2026-10-16', 180.00,  'TR-998877',   3, 3);

-- nota_credito
INSERT INTO nota_credito (numero, fecha_emision, motivo, monto, id_factura) VALUES
    ('NC01-0001', '2026-10-10', 'Devolución parcial de producto', 45.00, 1);
-------------------------------------------------
-- cliente: se marca como inactivo a un cliente que dejó de comprar
-- producto: aumento de 10 % a los productos de tecnología
-- sucursal: se registra el teléfono que faltaba
UPDATE sucursal
SET    telefono = '054-259876'
WHERE  codigo_sucursal = 3;

-- empleado: traslado de un empleado a otra sucursal
UPDATE empleado
SET    codigo_sucursal = 1
WHERE  codigo_empleado = 4;
-- proveedor: cambio de correo de contacto
UPDATE proveedor
SET    correo = 'ventas.nuevo@andina.example.com'
WHERE  ruc = '20512345671';
-- rol: se precisa la descripción del rol Contador
-- categoria: se amplía la descripción de Tecnología
-- metodo_pago: se renombra el método Tarjeta
-- tipo_documento: se aclara la descripción del CE
-- estado_factura: se renombra el estado inicial
UPDATE estado_factura
SET    nombre = 'Pendiente de pago'
WHERE  codigo_estado = 1;
-- inventario: reposición de 20 laptops en la sucursal 1
--     (la llave es compuesta: producto y sucursal)
-- factura: las facturas pendientes emitidas antes del 10/10 pasan a Vencida (4)
-- detalle_factura: se corrige la cantidad en una factura aún pendiente
-- pago: se registra el número de recibo de un pago en efectivo
--  nota_credito: se detalla el motivo de la anulación

-- inventario
UPDATE inventario
SET    cantidad_disponible = cantidad_disponible + 20
WHERE  codigo_producto = 'PROD-001' AND codigo_sucursal = 1;

-- factura
UPDATE factura
SET    codigo_estado = 4
WHERE  codigo_estado = 1 AND fecha_emision < '2026-10-10';

-- detalle_factura
UPDATE detalle_factura
SET    cantidad = 3
WHERE  id_factura = 1 AND codigo_producto = 'PROD-002';

-- pago
UPDATE pago
SET    referencia = 'REC-EF-2026-001'
WHERE  id_pago = 1;

-- nota_credito
UPDATE nota_credito
SET    motivo = 'Anulación total por devolución de mercancía defectuosa de fábrica'
WHERE  id_nota_credito = 1;

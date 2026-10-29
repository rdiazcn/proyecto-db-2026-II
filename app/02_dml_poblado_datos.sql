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
--empleado  (depende de rol y sucursal)
INSERT INTO empleado (codigo_rol, codigo_sucursal, nombre, correo) VALUES
    (1, 1, 'Rodrigo Díaz Cucalón',     'rodrigo.diaz@example.com'),
    (2, 1, 'Rony Choquecondo Luque',     'rony.choquecondo@example.com'),
    (2, 2, 'Alejandro Salazar Guillen',      'alejandro.salazar@example.com'),
    (3, 2, 'Regina Ticona Herrera',       'regina.ticona@example.com'),
    (4, 4, 'Maria Cornejo Lupa',        'maria.cornejo@example.com'),
    (5, 5, 'Jose Quispe Caceres',        'jose.quispe@example.com');

-------------------------------------------------
-- sucursal: se registra el teléfono que faltaba
UPDATE sucursal
SET    telefono = '054-259876'
WHERE  codigo_sucursal = 3;

-- empleado: traslado de un empleado a otra sucursal
UPDATE empleado
SET    codigo_sucursal = 1
WHERE  codigo_empleado = 4;

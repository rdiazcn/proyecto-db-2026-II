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

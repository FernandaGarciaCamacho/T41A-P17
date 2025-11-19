INSERT INTO usuarios (data)
VALUES 
  ('{"nombre": "Ana", "activo": true, "edad": 30}'),
  ('{"nombre": "Juan", "activo": false, "edad": 25}');

INSERT INTO productos_jsonb (nombre, specs)
VALUES
('Laptop X1', '{"color": "negro", "tamano": "15", "categoria": "computo", "peso": 1.5}'),
('Mouse Pro', '{"color": "rojo", "categoria": "accesorio", "dpi": 2400}'),
('Monitor Ultra', '{"color": "negro", "tamano": "27", "categoria": "pantalla"}'),
('Teclado Mecanico', '{"color": "blanco", "categoria": "accesorio"}'),
('Tablet Z', '{"color": "azul", "tamano": "10", "categoria": "movil"}');

INSERT INTO productos_hstore (nombre, atributos, precio)
VALUES
('Laptop', 'marca => Dell, color => negro, peso => 1.5', 800),
('Mouse', 'marca => Logitech, color => rojo, peso => 0.1', 50),
('Monitor', 'marca => LG, color => negro, tamano => 27', 300),
('Teclado', 'marca => HyperX, color => blanco, peso => 0.8', 120),
('Tablet', 'marca => Samsung, color => azul, peso => 0.5', 450);

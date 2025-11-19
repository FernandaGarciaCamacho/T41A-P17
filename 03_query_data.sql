SELECT data->>'nombre' AS nombre
FROM usuarios
WHERE data->>'activo' = 'true';

CREATE INDEX idx_data_gin ON usuarios USING GIN (data);

SELECT * FROM usuarios
WHERE data @> '{"activo": true}';
--Json
SELECT nombre
FROM productos_jsonb
WHERE specs->>'color' = 'negro';

SELECT nombre
FROM productos_jsonb
WHERE specs->>'tamano' = '15';

SELECT nombre
FROM productos_jsonb
WHERE specs->>'categoria' = 'accesorio';

CREATE INDEX idx_specs_gin ON productos_jsonb USING GIN (specs);

SELECT *
FROM productos_jsonb
WHERE specs @> '{"color": "negro"}';

-- HSTORE

SELECT nombre
FROM productos_hstore
WHERE atributos -> 'color' = 'rojo';

UPDATE productos_hstore
SET atributos = atributos || 'peso => 2.0'
WHERE nombre = 'Laptop';

UPDATE productos_hstore
SET atributos = delete(atributos, 'color')
WHERE nombre = 'Tablet';

SELECT *
FROM productos_hstore
WHERE atributos ? 'marca';

SELECT nombre, precio
FROM productos_hstore
WHERE atributos->'marca' = 'Samsung'
  AND precio > 300;

SELECT id, skeys(atributos) AS clave, svals(atributos) AS valor
FROM productos_hstore;

SELECT COUNT(*)
FROM productos_hstore
WHERE atributos ? 'color';

CREATE INDEX idx_hstore_gin ON productos_hstore USING GIN (atributos);

SELECT atributos->'marca' AS marca, COUNT(*)
FROM productos_hstore
GROUP BY marca;

SELECT nombre, hstore_to_json(atributos)
FROM productos_hstore;

SELECT json_to_hstore('{"color":"rojo","peso":"1.0"}'::json);

SELECT *
FROM productos_hstore
WHERE atributos ?& ARRAY['color', 'peso'];

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM usuarios WHERE id = 1 AND data->>'nombre' = 'Ana'
  ) THEN
    RAISE NOTICE 'OK: nombre correcto para id 1';
  ELSE
    RAISE EXCEPTION 'Fallo: nombre incorrecto para id 1';
  END IF;

  IF EXISTS (
    SELECT 1 FROM usuarios WHERE id = 1 AND data->>'activo' = 'true'
  ) THEN
    RAISE NOTICE 'OK: usuario activo para id 1';
  ELSE
    RAISE EXCEPTION 'Fallo: usuario no está activo para id 1';
  END IF;

  IF EXISTS (
    SELECT 1 FROM usuarios WHERE id = 2 AND data->>'edad' = '25'
  ) THEN
    RAISE NOTICE 'OK: edad correcta para id 2';
  ELSE
    RAISE EXCEPTION 'Fallo: edad incorrecta para id 2';
  END IF;
END;
$$;

-- 

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM productos_jsonb
    WHERE nombre = 'Mouse Pro' AND specs->>'color' = 'rojo'
  ) THEN
    RAISE NOTICE 'OK: Mouse Pro es rojo';
  ELSE
    RAISE EXCEPTION 'Fallo: Mouse Pro NO es rojo';
  END IF;

  IF EXISTS (
    SELECT 1 FROM productos_jsonb
    WHERE nombre = 'Laptop X1' AND specs->>'tamano' = '15'
  ) THEN
    RAISE NOTICE 'OK: Laptop X1 tamaño correcto';
  ELSE
    RAISE EXCEPTION 'Fallo: tamaño incorrecto para Laptop X1';
  END IF;
END;
$$;

--

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM productos_hstore
    WHERE nombre = 'Monitor' AND atributos->'marca' = 'LG'
  ) THEN
    RAISE NOTICE 'OK: Monitor tiene marca LG';
  ELSE
    RAISE EXCEPTION 'Fallo: Monitor NO tiene marca LG';
  END IF;

  IF EXISTS (
    SELECT 1 FROM productos_hstore
    WHERE nombre = 'Teclado' AND atributos ? 'color'
  ) THEN
    RAISE NOTICE 'OK: Teclado tiene atributo color';
  ELSE
    RAISE EXCEPTION 'Fallo: Teclado NO tiene atributo color';
  END IF;

  IF EXISTS (
    SELECT 1 FROM productos_hstore
    WHERE nombre = 'Tablet' AND atributos->'peso' = '0.5'
  ) THEN
    RAISE NOTICE 'OK: Tablet tiene peso correcto';
  ELSE
    RAISE EXCEPTION 'Fallo: peso incorrecto para Tablet';
  END IF;
END;
$$;

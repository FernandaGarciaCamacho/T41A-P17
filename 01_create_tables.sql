CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  data JSONB
);

CREATE EXTENSION IF NOT EXISTS hstore;

CREATE TABLE productos_jsonb (
  id SERIAL PRIMARY KEY,
  nombre TEXT,
  specs JSONB
);

CREATE TABLE productos_hstore (
  id SERIAL PRIMARY KEY,
  nombre TEXT,
  atributos HSTORE,
  precio NUMERIC
);

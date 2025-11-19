import psycopg2
import pytest

DB_CONFIG = {
    "dbname": "test_db",
    "user": "postgres",
    "password": "postgres",
    "host": "localhost",
    "port": 5432
}

def run_query(query):
    with psycopg2.connect(**DB_CONFIG) as conn:
        with conn.cursor() as cur:
            cur.execute(query)
            return cur.fetchall()

def test_nombre_ana():
    result = run_query("SELECT data->>'nombre' FROM usuarios WHERE id = 1;")
    print(f'resultado del query: {result}')
    assert result[0][0] == "Ana"

def test_usuario_activo():
    result = run_query("SELECT data->>'activo' FROM usuarios WHERE id = 1;")
    assert result[0][0] == "true"

def test_edad_juan():
    result = run_query("SELECT data->>'edad' FROM usuarios WHERE id = 2;")
    assert result[0][0] == "25"


def run_query(query):
    with psycopg2.connect(**DB_CONFIG) as conn:
        with conn.cursor() as cur:
            cur.execute(query)
            try:
                return cur.fetchall()
            except psycopg2.ProgrammingError:
                return None


def test_jsonb_mouse_color():
    """Mouse Pro debe ser rojo"""
    result = run_query("""
        SELECT specs->>'color' 
        FROM productos_jsonb 
        WHERE nombre = 'Mouse Pro';
    """)
    assert result[0][0] == "rojo"


def test_jsonb_laptop_tamano():
    """Laptop X1 debe tener tamano = 15"""
    result = run_query("""
        SELECT specs->>'tamano'
        FROM productos_jsonb
        WHERE nombre = 'Laptop X1';
    """)
    assert result[0][0] == "15"


def test_jsonb_categoria_accesorio():
    """Teclado Mecanico debe ser categoria accesorio"""
    result = run_query("""
        SELECT specs->>'categoria'
        FROM productos_jsonb
        WHERE nombre = 'Teclado Mecanico';
    """)
    assert result[0][0] == "accesorio"


def test_jsonb_color_negro_existentes():
    """Validar que existan productos con color negro"""
    result = run_query("""
        SELECT COUNT(*)
        FROM productos_jsonb
        WHERE specs->>'color' = 'negro';
    """)
    assert result[0][0] >= 1


def test_hstore_laptop_marca():
    """La Laptop debe tener marca Dell"""
    result = run_query("""
        SELECT atributos->'marca'
        FROM productos_hstore
        WHERE nombre = 'Laptop';
    """)
    assert result[0][0] == "Dell"


def test_hstore_mouse_color():
    """Mouse debe tener color rojo"""
    result = run_query("""
        SELECT atributos->'color'
        FROM productos_hstore
        WHERE nombre = 'Mouse';
    """)
    assert result[0][0] == "rojo"


def test_hstore_monitor_tamano():
    """Monitor debe tener tamano = 27"""
    result = run_query("""
        SELECT atributos->'tamano'
        FROM productos_hstore
        WHERE nombre = 'Monitor';
    """)
    assert result[0][0] == "27"


def test_hstore_teclado_tiene_color():
    """Teclado debe tener atributo color"""
    result = run_query("""
        SELECT atributos ? 'color'
        FROM productos_hstore
        WHERE nombre = 'Teclado';
    """)
    assert result[0][0] is True


def test_hstore_tablet_peso():
    """Tablet debe tener peso 0.5"""
    result = run_query("""
        SELECT atributos->'peso'
        FROM productos_hstore
        WHERE nombre = 'Tablet';
    """)
    assert result[0][0] == "0.5"


def test_hstore_conteo_color():
    """Debe haber al menos 3 productos con atributo color"""
    result = run_query("""
        SELECT COUNT(*)
        FROM productos_hstore
        WHERE atributos ? 'color';
    """)
    assert result[0][0] >= 3


def test_hstore_marca_samsung_y_precio():
    """Tablet debe ser marca Samsung y precio > 300"""
    result = run_query("""
        SELECT precio
        FROM productos_hstore
        WHERE atributos->'marca' = 'Samsung'
          AND precio > 300;
    """)
    assert len(result) == 1


def test_hstore_claves_multiples():
    """Validar que Teclado tenga 'color' y 'peso'"""
    result = run_query("""
        SELECT atributos ?& ARRAY['color', 'peso']
        FROM productos_hstore
        WHERE nombre = 'Teclado';
    """)
    assert result[0][0] is True

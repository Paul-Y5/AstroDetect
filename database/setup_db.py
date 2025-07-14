import sqlite3

def execute_sql_file(db_file, sql_file):
    try:
        conn = sqlite3.connect(db_file)
        cursor = conn.cursor()

        with open(sql_file, 'r', encoding='utf-8') as f:
            sql_script = f.read()

        cursor.executescript(sql_script)
        conn.commit()
        print(f"Base de dados criada com sucesso a partir de {sql_file}!")
    except Exception as e:
        print(f"Erro: {e}")
    finally:
        conn.close()

if __name__ == "__main__":
    execute_sql_file("astros_report.db", "schema.sql")

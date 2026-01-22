import os
from etl.db import get_engine

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SQL_DIR = os.path.join(BASE_DIR,"sql")
SQL_FILES_IN_ORDER = [
    "abc_sales.sql"
]
def run_sql_file(conn, path):
#   print("Running {filepath} ...")
    with open(path, "r", encoding="utf-8") as f:
        sql = f.read()
    statements = [s.strip() for s in sql.split(";") if s.strip()]
    for stmt in statements:
        conn.exec_driver_sql(stmt)
    

def init_db():
    engine= get_engine()
    with engine.begin() as conn:
        for filename in SQL_FILES_IN_ORDER:
            path = os.path.join(SQL_DIR, filename)

            if not os.path.exists(path):
                raise FileNotFoundError(f"SQL file not found: {path}")
           # with open(path, "r", encoding="utf-8") as f:
           #     sql = f.read()
           #     conn.exec_driver_sql(sql)
            print(f"Running SQL file: {filename}")
            run_sql_file(conn, path)
            print(f"Completed: {filename}")

    print("PostgreSQL schema initialized successfully")

if __name__=="__main__":
    init_db()

import os
from etl.db import get_engine

SQL_DIR = os.path.join(os.path.dirname(__file__),".","sql")
SQL_FILES_IN_ORDER = [
    "ABC_Sales_Database_Schema.sql"
]
def run_sql_file(conn, filepath):
    print("Running {filepath} ...")
    with open(filepath, "r", encoding="utf-8") as f:
        sql = f.read()
        conn.exec_driver_sql(sql)
    print(f"Finished {filepath}")

def init_db():
    engine= get_engine()
    with engine.begin() as conn:
        for filename in SQL_FILES_IN_ORDER:
            path = os.path.join(SQL_DIR, filename)

            if not os.path.exists(path):
                raise FileNotFoundError(f"SQL file not found: {path}")
            run_sql_file(conn, path)
    print("PostgreSQL schema initialized successfully")

if __name__=="__main__":
    init_db()

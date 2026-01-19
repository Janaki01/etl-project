from etl.db import get_engine
def init_db():
    engine= get_engine()
    with engine.begin() as conn:
        with open("sql/init_db.sql") as f:
            sql = f.read()
            conn.exec_driver_sql(sql)
    print("PostgreSQL schema initialized successfully")

if __name__=="__main__":
    init_db()

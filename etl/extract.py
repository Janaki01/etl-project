import pandas as pd
from sqlalchemy import create_engine 

def extract_data(db_url, sql_file):
    print("Extracting data...")
    engine = create_engine(db_url)
    with open(sql_file, "r") as f:
        query = f.read()
    df = pd.read_sql(query, engine)
    return df
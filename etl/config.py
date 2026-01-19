import os

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
S3_BUCKET = os.getenv("S3_BUCKET")
DB_URL = (
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}" f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)
#AWS_ACCESS_KEY_ID = os.getenv("AWS_ACCESS_KEY_ID")
#AWS_SECRET_ACCESS_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")

#if not DB_URL: 
#    raise ValueError("DB_URL is not set")
#if not S3_BUCKET: 
#    raise ValueError("S3_BUCKET is not set")
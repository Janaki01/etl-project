import os

DB_URL = os.getenv("DB_URL")
S3_BUCKET = os.getenv("S3_BUCKET")
AWS_ACCESS_KEY_ID = os.getenv("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")

if not DB_URL: 
    raise ValueError("DB_URL is not set")
if not S3_BUCKET: 
    raise ValueError("S3_BUCKET is not set")
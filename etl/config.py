import os
DB_URL = os.getenv("DB_URL")
S3_BUCKET = os.getenv("S3_BUCKET")
AWS_REGION = os.getenv("AWS_REGION", "ap-south-1")
OUTPUR_DIR = "output"
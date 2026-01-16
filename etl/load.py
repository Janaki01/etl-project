import os
import boto3

def save_excel(df, filename):
    print("Saving Excel...")

    os.makedirs("output", exist_ok=True)
    path = f"output/{filename}"
    df.to_excel(path, index=False)
    return path

def upload_to_s3(file_path, bucket, key):
    print("Uploading to s3...")
    s3 = boto3.client("s3")
    s3.upload_file(file_path, bucket, key)

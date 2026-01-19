print("main.py is executing")

from etl.config import DB_URL, S3_BUCKET
from etl.extract import extract_data
from etl.transform import clean_data
from etl.load import save_excel, upload_to_s3
from etl.charts import bar_chart, pie_chart
import os

def run_etl():
    print("ETL Started...")
    
    os.makedirs("output", exist_ok=True)

    #1.Extract
    print("Extracting data")
    df = extract_data(DB_URL, "sql/sales.sql")
    df = clean_data(df)
    excel_file = save_excel(df, "sales_report.xlsx")

    #2.transform
  #  print("Transforming data")
  #  df_sales = clean_data(df_sales)

    #3.Load Excel
   # print("Saving Excel")
    excel_file = save_excel(df,"sales_report.xlsx")

    #4.charts
    print("Creating Charts")
    print(df.head())
    print(df.dtypes)
   # bar_chart(df_sales, "region", "revenue", "output/revenue_by_region.png")
    bar_chart(df, "region", "revenue", "revenue_by_region.png")
    pie_chart(df, "category", "category_distribution.png")

    #5. Upload to s3
    print("Uploading to s3")
    upload_to_s3(excel_file, S3_BUCKET, "reports/sales_report.xlsx")
  #  upload_to_s3("output/revenue_by_region.png", S3_BUCKET, "charts/revenue_by_region.png")
  #  upload_to_s3("output/sales_share.png", S3_BUCKET, "charts/sales_share.png")

    print("ETL Completed Successfully")

if __name__== "__main__":
    run_etl()
   
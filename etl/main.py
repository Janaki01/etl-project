print("main.py loaded")
from etl.config import DB_URL, S3_BUCKET
from etl.extract import extract_data
from etl.transform import clean_data
from etl.load import save_excel, upload_to_s3
from etl.charts import bar_chart, pie_chart

def run_etl():
    print ("ETL Started...")

    #1.Extract
    df_sales = extract_data(DB_URL, "sql/sales.sql")

    #2.transform
    df_sales = clean_data(df_sales)

    #3.Load Excel
    excel_file = save_excel(df_sales,"sales_report.xlsx")

    #4.charts
    bar_chart(df_sales, "region", "revenue", "revenue_by_region.png")
    pie_chart(df_sales, "category", "sales_share.png")

    #5. Upload to s3
    upload_to_s3(excel_file, S3_BUCKET, "reports/sales_report.xlsx")
    upload_to_s3("output/revenue_by_region.png", S3_BUCKET, "charts/revenue_by_region.png")
    upload_to_s3("output/sales_share.png", S3_BUCKET, "charts/sales_share.png")

    print("ETL Completed Successfully")

    if __name__== "__main__":
        run_etl()
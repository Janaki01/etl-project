output "s3_bucket" {
    value = aws_s3_bucket.reports.bucket
}
output "db_endpoint" {
    value = aws_db_instance.etl_db.address
}
output "lambda_name" {
    value = aws_lambda_function.etl_lambda.function_name
}
output "s3_bucket" {
    value = aws_s3_bucket.reports.bucket
}
output "db_endpoint" {
    value = aws_db_instance.postgres.address
}
output "lambda_name" {
    value = aws_lambda_function.etl_lambda.function_name
}
output "rds_endpoint" {
    value = aws_db_instance.postgres.address
}
output "rds_db_name" {
    value = var.db_name
}
output "rds_username" {
    value = var.db_user
}
output "rds_port" {
    value = aws_db_instance.postgres.port
}
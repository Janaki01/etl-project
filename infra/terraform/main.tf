provider "aws" {
  region = var.region
}

# S3 BUCKET
resource "aws_s3_bucket" "reports" {
  bucket = var.s3_bucket_name
}

#IAM ROLE FOR LAMBDA
resource "aws_iam_role" "lambda_role" {
    name = "${var.project_name}-lambda-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = { Service = "lambda.amazonaws.com"}
            Action = "sts:AssumeRole"
        }]
    })
}
resource "aws_iam_policy" "lambda_policy" {
    name = "${var.project_name}-lambda-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement= [
        {
        Effect = "Allow"
        Action = [
          "s3:PubObject",
          "s3:GetObject",
          "s3:ListBucket"
          ]
          Resource = [
            aws_s3_bucket.reports.arn, "${aws_s3_bucket.reports.arn}/*"
            ]
        },
        {
          Effect = "Allow"
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            ]
            Resource = "*"
          }
        ]
    })
} 
resource "aws_iam_role_policy_attachment" "lambda_attach" {
    role = aws_iam_role.lambda_role.name
    policy_arn = aws_iam_policy.lambda_policy.arn
}
#RDS DATABASE

resource "aws_db_instance" "etl_db" {
    identifier = "${var.project_name}-db"
    engine = "postgres"
    engine_version = "15"
    instance_class = "db.t3.micro"
    allocated_storage = 20
    db_name = var.db_name
    username = var.db_user
    password = var.db_password
    skip_final_snapshot = true
    publicly_accessible = true
}

# LAMBDA FUNCTION
resource "aws_lambda_function" "etl_lambda" {
    function_name = "${var.project_name}-etl"
    role = aws_iam_role.lambda_role.arn
    handler ="main.run_etl"
    runtime = "python3.10"
    timeout = 300

    filename = "etl_lambda.zip"
    source_code_hash = filebase64sha256("etl_lambda.zip")
    environment {
        variables = {
            DB_URL = "postgressql://${var.db_user}:${var.db_password}@${aws_db_instance.etl_db.address}:5432/${var.db_name}"
            S3_BUCKET = aws_s3_bucket.reports.bucket_domain_name
        }
    }
} 
 #EVENTBRIDGE SCHEDULE
 resource "aws_cloudwatch_event_rule" "daily_run" {
    name = "${var.project_name}-daily"
    schedule_expression = "cron(0 2 * * ? *)"
 }
 resource "aws_cloudwatch_event_target" "lambda_target" {
    rule = aws_cloudwatch_event_rule.daily_run.name
    arn = aws_lambda_function.etl_lambda.arn
 }
 resource "aws_lambda_permission" "allow_eventbridge" {
    statement_id = "AllowExecutionFromEventBridge"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.etl_lambda.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.daily_run.arn
 }
          
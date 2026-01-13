variable "region" {
    default = "ap-south-1"
}
variable "project_name" {
    default = "etl-automation"
}
variable "db_name" {
    default = "etldb"
}
variable "db_user" {
    default = "etluser"
}
variable "db_password" {
    description = "RDS password"
    sensitive = true
}
variable "s3_bucket_name" {
    default = "etl-report"
}

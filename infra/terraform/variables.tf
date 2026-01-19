variable "region" {
    default = "ap-south-1"
}
variable "project_name" {
    default = "etl-automation"
}
variable "db_name" {
    default = "etldb"
    type = string
    description = "PostgreSQL database name"
}
variable "db_user" {
    default = "etluser"
    type = string
    description = "PostgreSQL master username"
}
variable "db_password" {
    description = "RDS password"
    sensitive = true
    type = string
}
variable "s3_bucket_name" {
    description = "S3 bucket for ETL reports"
    default = "etl-report"
}
variable "db_instance_class" {
    description = "RDS instance size"
    type = string
    default = "db.t3.micro"
}
variable "db_allocated_storage" {
    description = "RDS allocated storage"
    type = number
    default = 20
  
}

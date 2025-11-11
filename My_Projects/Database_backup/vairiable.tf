variable "database_name" {
  description = "The name of the database to back up"
  type        = string
}
variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store database backups"
  type        = string
}
variable "backup_schedule" {
  description = "The schedule for database backups in cron format"
  type        = string
  default= "cron(0 22 * * ? *)"

}
variable "lambda_function_name" {
  description = "The name of the Lambda function for database backup"
  type        = string
  default     = "daily-db-backup"
}
variable "lambda_timeout" {
  description = "The timeout for the Lambda function in seconds"
  type        = number
  default     = 900
}
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}
variable "iam_role_name" {
  description = "The name of the IAM role for Lambda function"
  type        = string
  default     = "DatabaseBackupRole"
}
variable "iam_policy_name" {
  description = "The name of the IAM policy for Lambda function"
  type        = string
  default     = "Lambda-S3-AccessPolicy"
}
variable "lambda_runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
  default     = "python3.8"
}
variable "lambda_handler" {
  description = "The handler for the Lambda function"
  type        = string
  default     = "lambda_function.lambda_handler"
}
variable "db_host" {
  description = "The database host address"
  type        = string
}
variable "db_port" {
  description = "The database port number"
  type        = number
}
variable "database_user" {
  description = "The database user name"
  type        = string
}
variable "database_password" {
  description = "The database user password"
  type        = string
  sensitive  = true
}

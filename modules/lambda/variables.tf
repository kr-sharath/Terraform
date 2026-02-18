variable "runtime" {
  description = "The runtime of the lambda function"
  default     = "nodejs20.x"
  type        = string
}

variable "region" {
  type = string
}

variable "function_name" {
  type        = string
  description = "The name of the lambda function"
}

variable "lambda_role_name" {
  type        = string
  description = "The name of the IAM role for the lambda function"
}

variable "handler" {
  type        = string
  description = "value of the handler"
}

variable "policy_name" {
  type        = string
  description = "value of the policy name"
}

variable "timeout" {
  type        = number
  description = "lambda execution time in seconds"
}

variable "s3_bucket" {
  type        = string
  description = "name of the s3 bucket where code exists for lambda"
}

variable "s3_key" {
  type        = string
  description = "name of the s3 key"
}
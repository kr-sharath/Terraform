variable "runtime" {
  description = "The runtime of the lambda function"
  default     = "nodejs20.x"
  type        = string
}

variable "region" {
  default = "us-east-1"
  type    = string
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

variable "filename" {
  type        = string
  description = "value of the filename"
}

variable "policy_name" {
  type        = string
  description = "value of the policy name"
}

variable "timeout" {
  type = number
  description = "lambda execution time in seconds"
}
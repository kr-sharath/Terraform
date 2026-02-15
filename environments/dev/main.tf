terraform {
    required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.32.1"
    }
  }
}

providere "aws"{
    region = "ap-south-1"
}

module "lambda" {
  source        = "../../modules/lambda"
  function_name = "test-lambda"
  runtime       = var.runtime
  handler       = "index.handler"
  timeout       = 30
  lambda_role_name = "test-role"
  policy_name   = "lambda_test_policy"
  s3_bucket     = "444198540026-test-bucket"
  s3_key        = "index.zip"
  region        = var.region
}

module "api_gateway" {
  source      = "../../modules/api_gateway"
  lambda_name = module.lambda.function_name
  lambda_arn  = module.lambda.invoke_arn
  api_name    = var.api_name
  stage_name  = var.stage_name
}


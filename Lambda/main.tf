provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "us-east-2"
}

module "lambda" {
  providers = {
    aws.us-east-1  = aws.us-east-1
    aws.us-east-2 = aws.us-east-2
  }
  source           = "./modules"
  function_name    = "test_lambda_${terraform.workspace}"
  runtime          = "nodejs22.x"
  lambda_role_name = "test_lambda_${terraform.workspace}_role"
  handler          = "index.handler"
  filename         = "${path.module}/lambda.zip"
  policy_name      = "test_lambda_${terraform.workspace}_policy"
}

terraform {
  backend "s3" {
    use_lockfile = true
    encrypt = true
    bucket  = "sample-devops-bucket"
    key     = "StateFiles"
    region  = "us-east-1"
  }
}


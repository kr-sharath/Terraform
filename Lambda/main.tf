provider "aws" {
  region = "us-east-1"
  alias  = "use-1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "use-2"
}

module "lambda" {
  providers = {
    aws.use-1  = aws.use-1
    aws.use-2 = aws.use-2
  }
  source           = "./modules"
  function_name    = "test_lambda_${terraform.workspace}"
  runtime          = "nodejs22.x"
  lambda_role_name = "test_lambda_${terraform.workspace}_role"
  handler          = "index.handler"
  filename         = "${path.module}/lambda.zip"
  policy_name      = "test_lambda_${terraform.workspace}_policy"
  timeout          = 180
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


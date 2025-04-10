terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.us-east-1,
        aws.us-east-2
      ]
    }
  }
}
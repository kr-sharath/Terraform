terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.use-1,
        aws.use-2
      ]
    }
  }
}
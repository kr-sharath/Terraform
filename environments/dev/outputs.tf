output "lambda_arn" {
  value = module.lambda.invoke_arn
}

output "invoke_url" {
  value = module.api_gateway.invoke_url
} 
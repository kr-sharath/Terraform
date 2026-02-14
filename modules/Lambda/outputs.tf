output "function_name" {
  value = aws_lambda_function.test_lambda.function_name
}

output "invoke_arn" {
  value = aws_lambda_function.test_lambda.invoke_arn
}
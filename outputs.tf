output "lambda_arn" {
  value       = aws_lambda_function.this.arn
  description = "ARN identifying lambda function"
}
output "lambda_qualified_arn" {
  value       = aws_lambda_function.this.qualified_arn
  description = "ARN identifying lambda function version"
}
output "lambda_invoke_arn" {
  value       = aws_lambda_function.this.invoke_arn
  description = "ARN to be used for invoking Lambda Function from API Gateway"
}
output "lambda_version" {
  value       = aws_lambda_function.this.version
  description = "Latest published version of your Lambda Function"
}
output "cloudwatch_logs_group_arn" {
  value       = aws_cloudwatch_log_group.this.arn
  description = "ARN specifying the log group"
}

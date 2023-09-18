output "table_name" {
  description = "DynamoDB table name."
  value       = aws_dynamodb_table.Test_dynamodb.name
}

output "stream_arn" {
  description = "Stream value."
  value       = aws_dynamodb_table.Test_dynamodb.stream_arn
}

output "table_arn" {
  description = "DynamoDB table ARN."
  value       = aws_dynamodb_table.Test_dynamodb.arn
}

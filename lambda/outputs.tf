output "lambda" {
  value = "${aws_lambda_function.lambda.arn}"
}

output "lambda_alias_current_arn" {
    description = "The ARN identifying your Lambda function alias."
    value       = "${aws_lambda_alias.lambda_alias_current.arn}"
}

output "lambda_latest_version" {
    description = "Latest published version of your Lambda Function."
    value       = "${aws_lambda_function.lambda.version}"
}

output "log_group_name" {
    description = "Name of the log group that messages are output to"
    value = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
}


output "lambda_alias_current_invoke_arn" {
    description = "The ARN to be used for invoking Lambda Function from API Gateway - to be used in"
    value       = "${aws_lambda_alias.lambda_alias_current.invoke_arn}"
}
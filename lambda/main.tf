
resource "aws_lambda_function" "lambda" {
  function_name    = var.name
  description      = "pod test lambda"
  filename         = "${data.archive_file.zip.output_path}"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"
  
  memory_size      = var.memory_size
  timeout          = var.timeout
  role             = var.role_arn
  handler          = "hello_lambda.lambda_handler"
  runtime          = "python3.9"

  environment {
    variables = {
      greeting = "Hello"
    }
  }
}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "hello_lambda.py"
  output_path = "hello_lambda.zip"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "/aws/lambda/pod-log"
  retention_in_days = 365
}

resource "aws_lambda_alias" "lambda_alias_current" {
  name              = "${var.lambda_alias_current}"
  function_name     = "${aws_lambda_function.lambda.arn}"
  function_version  = "${aws_lambda_function.lambda.version}"
}

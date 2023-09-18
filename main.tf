
data "aws_region" "current" {}

module "dynamo_db"{
  source                      = "./dynamodb"
  name                        = "Test-table"
  hash_key                    = var.hash_key
  billing_mode                = var.billing_mode
  secondary_hash_key          = var.secondary_hash_key
  secondary_read_capacity     = var.secondary_read_capacity
  secondary_write_capacity    = var.secondary_write_capacity
  stream_enabled              = var.stream_enabled
  stream_view_type            = var.stream_view_type
}


module "create_role" {
  source                      = "./roles"
  lambda_role_name            = "lambda-role"
  logging_policy_name         = "cwlogs"
  lambda_policy_name          = "lambdapolicy"
  pod_apigw_cloudwatch_role   = "apirole"
  pod_apigw_cloudwatch_policy = "apipolicy"

}


module "Pod_lambda" {

  source                  = "./lambda"
  name                    = var.name
  memory_size             = var.memory_size
  timeout                 = var.timeout
  role_arn                = module.create_role.arn
  lambda_alias_current    = var.lambda_alias_current
}

module "pod_api_gateway" {
  source            = "./apigateway"
  uri               = module.Pod_lambda.lambda_alias_current_invoke_arn
  function_name     = module.Pod_lambda.lambda
  deploy_path       = var.deploy_path
  is_enabled        = var.api_gateway_enabled
  
}
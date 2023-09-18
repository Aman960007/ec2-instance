
resource "aws_api_gateway_rest_api" "api_gateway" {
  count       = var.is_enabled ? 1 : 0
  name        = "pod_apigateway"
  description = "Pod API-Gateway"
  policy      = var.gateway_policy

  
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "proxy" {
  count       = var.is_enabled ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.api_gateway[count.index].id
  parent_id   = aws_api_gateway_rest_api.api_gateway[count.index].root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  count         = var.is_enabled ? 1 : 0
  rest_api_id   = aws_api_gateway_rest_api.api_gateway[count.index].id
  resource_id   = aws_api_gateway_resource.proxy[count.index].id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_resource" {
  count       = var.is_enabled ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.api_gateway[count.index].id
  resource_id = aws_api_gateway_method.proxy[count.index].resource_id
  http_method = aws_api_gateway_method.proxy[count.index].http_method

  content_handling        = "CONVERT_TO_TEXT"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.uri
}

resource "aws_api_gateway_method" "proxy_root" {
  count         = var.is_enabled ? 1 : 0
  rest_api_id   = aws_api_gateway_rest_api.api_gateway[count.index].id
  resource_id   = aws_api_gateway_rest_api.api_gateway[count.index].root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_root" {
  count       = var.is_enabled ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.api_gateway[count.index].id
  resource_id = aws_api_gateway_method.proxy_root[count.index].resource_id
  http_method = aws_api_gateway_method.proxy_root[count.index].http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.uri
}




resource "aws_api_gateway_deployment" "deployment" {
  count       = var.is_enabled ? 1 : 0

  depends_on = [
    aws_api_gateway_integration.integration_resource,
    aws_api_gateway_integration.integration_root,
  ]

  triggers = {
    redeployment = sha1(jsonencode([aws_api_gateway_rest_api.api_gateway[0].name, aws_api_gateway_rest_api.api_gateway[0].body, var.gateway_policy, aws_api_gateway_integration.integration_root[0].uri]))
  }

  lifecycle {
    create_before_destroy = true
  }

  rest_api_id = aws_api_gateway_rest_api.api_gateway[count.index].id
}

resource "aws_api_gateway_stage" "stage" {
  count         = var.is_enabled ? 1 : 0
  stage_name    = var.deploy_path
  rest_api_id   = aws_api_gateway_rest_api.api_gateway[count.index].id
  deployment_id = aws_api_gateway_deployment.deployment[count.index].id
  description = "stage-${md5(var.gateway_policy)}-${md5(var.function_name)}"
  
  
  depends_on = [
    aws_api_gateway_deployment.deployment,
    aws_cloudwatch_log_group.log_group
  ]

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.log_group[count.index].arn
    format          = jsonencode({ "requestId":"$context.requestId",
      "ip": "$context.identity.sourceIp",
      "caller":"$context.identity.caller",
      "user":"$context.identity.user",
      "requestTime":"$context.requestTime",
      "httpMethod":"$context.httpMethod",
      "resourcePath":"$context.resourcePath",
      "status":"$context.status",
      "protocol":"$context.protocol",
      "responseLength":"$context.responseLength" })
  }

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_cloudwatch_log_group" "log_group" {
  count             = var.is_enabled ? 1 : 0
  name              = "API-Gateway-Access-Logs_${aws_api_gateway_rest_api.api_gateway[count.index].id}/${var.deploy_path}"
  retention_in_days = 365
}

resource "aws_api_gateway_method_settings" "logs" {
  count       = var.is_enabled ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.api_gateway[count.index].id
  stage_name  = aws_api_gateway_stage.stage[count.index].stage_name
  method_path = "*/*"

  settings {
    metrics_enabled     = true
    logging_level       = var.logging_level
    data_trace_enabled  = true
  }
}

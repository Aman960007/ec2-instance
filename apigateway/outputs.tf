output "api_base_url" {
    description = "Base URL to invoke the REST API"
    value       = "${aws_api_gateway_deployment.deployment[*].invoke_url}"
}

output "execution_arn" {
    description = "Execution arn for the API Gateway"
    value       = "${aws_api_gateway_rest_api.api_gateway[*].execution_arn}"
}

output "api_id" {
    description = "The ID of the REST API"
    value       = element(concat(aws_api_gateway_rest_api.api_gateway.*.id, [""]), 0)
    
}

output "deployment_id" {
    description = "Execution arn for the API Gateway"
    value       = "${aws_api_gateway_deployment.deployment[*].id}"
}

output "api_name" {
    description = "The name of the REST API"
    value       = aws_api_gateway_rest_api.api_gateway[0].name
}
output "stage_arn" {
    description = "ARN of the API Gateway Stage."
    value       = length(aws_api_gateway_stage.stage[0]) > 0 ? aws_api_gateway_stage.stage[0].arn : null
}


variable "deploy_path" {
  description = "Deployment path for the API gateway"
  type        = string
}

variable "gateway_policy" {
  description = "Resource policy to restrict access to the API Gateway"
  type = string
  default = ""
}

variable "uri" {
  description = "The Lambda input URI"
  type = string
}

variable "function_name" {
  description = "The Lambda function name"
  type = string
}

variable "lambda_alias_name" {
  type = string
  default = "current_version"
}

variable "is_enabled" {
  type = bool
}

variable "logging_level" {
  type = string
  default = "INFO"
}

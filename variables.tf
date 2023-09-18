# Dynamo Db
variable "billing_mode" {
	type = string
}

variable "secondary_read_capacity" {
	type = number
}

variable "secondary_write_capacity" {
	type = number
}

variable "stream_enabled" {
	type = bool
}

variable "stream_view_type" {
	type = string
}

variable "aws_region" {
  type = string
}



variable "secondary_hash_key" {
  description = "key type"
  type        = string

}

variable "hash_key" {
  description = "key type"
  type        = string
}


#############################################################

variable "name" {
    description = "Lambda name"
    type        = string
}

variable "memory_size" {
  type        = string
}

variable "timeout" {
    description = "Timeout period in seconds"
    type        = number
    default     = 110
}

variable "publish" {
  type        = bool
}

variable "lambda_alias_current" {
  type        = string
}

# api-gateway
variable "deploy_path" {
  description = "Deployment path for the API gateway"
  type        = string
}

variable "api_gateway_enabled" {
  description = "Deployment path for the API gateway"
  type        = bool
}


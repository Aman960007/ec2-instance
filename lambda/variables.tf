variable "role_arn" {
    description = "ARN of the role under which the Lambda should execute"
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

variable "lambda_alias_current" {
    description = "Name for the alias you are creating."
    type        = string
}

variable "name" {
    description = "Lambda name"
    type        = string
}
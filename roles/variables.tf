

# ######################################
# cloudwatch
# ######################################
variable "logging_policy_name" {
    type = string
}

# ######################################
# Lambda
# ######################################

variable "lambda_role_name" {
  type = string
}

variable "lambda_policy_name" {
    type = string
}

########################################

variable "pod_apigw_cloudwatch_role" {
  type = string
}

variable "pod_apigw_cloudwatch_policy" {
    type = string
}



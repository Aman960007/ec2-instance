# DynamoDb

billing_mode              = "PAY_PER_REQUEST"
secondary_read_capacity   = 2
secondary_write_capacity  = 2
stream_enabled            = true
stream_view_type          = "NEW_AND_OLD_IMAGES"



hash_key                  = "Id"
secondary_hash_key        = "Id"


#Lambda

memory_size                 = "2048"
publish                     = true
name                        = "Pod_lambda"
lambda_alias_current        = "current_version"
lambda_description          = "Pod project"
log_level                   = "Information"

# API path
deploy_path                 = "develop"
api_gateway_enabled         = true
logging_level               = "INFO"

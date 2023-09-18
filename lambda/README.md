Terraform AWS Lambda
===================================

A Terraform module for creating a new lambda

The lambda module requires:

The lambda resource consists of:

- lambda function
- security group for lambda
- iam role for executing lambda
- iam policy for lambda

Usage
-----

To use the module, include something like the following in your Terraform
configuration:

```hcl-terraform
module "lambda" {
  source                       = "../lambda"
  region                       = "eu-west-2"
  component                    = "my-lambda"
  deployment_identifier        = "development-europe"
  include_vpc_access           = true
  vpc_id                       = "VPC-1234"
  lambda_subnet_ids            = ["subnet-id-1"]
  lambda_zip_path              = "lambda.zip"
  lambda_ingress_cidr_blocks   = ["10.10.0.0/16"]
  lambda_egress_cidr_blocks    = ["0.0.0.0/8"]
  lambda_environment_variables = {
    "TEST_ENV_VARIABLE" = "test-value"
  }
  lambda_function_name         = "lambda-function"
  lambda_handler               = "handler.hello"
  lambda_description           = "An optional description"
  tags                         = {
    "AdditionalTags" = "my-tag"
  }
  lambda_execution_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams",
            "logs:CreateLogStream",
            "logs:DeleteLogStream",
            "logs:FilterLogEvents",
            "logs:GetLogEvents",
            "logs:PutLogEvents",
          ],
          "Resource" : [
            "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "sns:Publish"
          ],
          "Resource" : [
            "arn:aws:sns:${var.region}:${data.aws_caller_identity.current.account_id}:*"
          ]
        }
      ]
    })
}
```

### Compatibility

This module is compatible with Terraform versions greater than or equal to
Terraform 1.5.0

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "lambda_role" {
  name                  = var.lambda_role_name
  path                  = "/service-role/"
  
  assume_role_policy    = data.aws_iam_policy_document.lambda_assume_role.json
  force_detach_policies = true
}
# ###########################################################
# CloudWatch logging
# ###########################################################
data "aws_iam_policy_document" "logging_permissions" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
      ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "logging_policy" {
  name   = var.logging_policy_name
  policy = data.aws_iam_policy_document.logging_permissions.json
}
resource "aws_iam_role_policy_attachment" "logging_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.logging_policy.arn
}


data "aws_iam_policy_document" "lambda_permissions" {
  statement {
    effect = "Allow"
    actions = [
      "lambda:CreateFunction",
				"lambda:TagResource",
				"lambda:ListVersionsByFunction",
				"lambda:GetLayerVersion",
				"lambda:PublishLayerVersion",
				"lambda:InvokeAsync",
				"lambda:GetAccountSettings",
				"lambda:GetFunctionConfiguration",
				"lambda:CreateEventSourceMapping",
				"lambda:GetLayerVersionPolicy",
				"lambda:RemoveLayerVersionPermission",
				"lambda:UntagResource",
				"lambda:PutFunctionConcurrency",
				"lambda:ListTags",
				"lambda:DeleteLayerVersion",
				"lambda:ListLayerVersions",
				"lambda:ListLayers",
				"lambda:DeleteFunction",
				"lambda:GetAlias",
				"lambda:UpdateEventSourceMapping",
				"lambda:ListFunctions",
				"lambda:GetEventSourceMapping",
				"lambda:InvokeFunction",
				"lambda:GetFunction",
				"lambda:ListAliases",
				"lambda:UpdateFunctionConfiguration",
				"lambda:AddLayerVersionPermission",
				"lambda:UpdateAlias",
				"lambda:UpdateFunctionCode",
				"lambda:AddPermission",
				"lambda:ListEventSourceMappings",
				"lambda:DeleteAlias",
				"lambda:PublishVersion",
				"lambda:DeleteFunctionConcurrency",
				"lambda:DeleteEventSourceMapping",
				"lambda:RemovePermission",
				"lambda:GetPolicy",
				"lambda:CreateAlias",
				"s3:ListBucket",
        "s3:PutObject",
        "s3:GetObject",
				"s3:ListAllMyBuckets",
				"s3:DeleteObject",
        "dynamodb:BatchGetItem",
        "dynamodb:GetItem",
        "dynamodb:GetRecords",
        "dynamodb:Scan",
        "dynamodb:Query",
        "dynamodb:GetShardIterator",
        "dynamodb:DescribeStream",
        "dynamodb:ListStreams"	

      ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name   = var.lambda_policy_name
  policy = data.aws_iam_policy_document.lambda_permissions.json
}
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

################################################################

data "aws_iam_policy_document" "pod_apigw_allow_manage_resources" {
  version = "2012-10-17"
  statement {
    actions = [
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:GetLogEvents",
      "logs:FilterLogEvents"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "logs:CreateLogDelivery",
      "logs:PutResourcePolicy",
      "logs:UpdateLogDelivery",
      "logs:DeleteLogDelivery",
      "logs:CreateLogGroup",
      "logs:DescribeResourcePolicies",
      "logs:GetLogDelivery",
      "logs:ListLogDeliveries"
    ]

    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "pod_apigw_allow_assume_role" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "pod_apigw_allow_manage_resources" {
  name = var.pod_apigw_cloudwatch_policy
  policy = data.aws_iam_policy_document.pod_apigw_allow_manage_resources.json
  role = aws_iam_role.pod_apigw_cloudwatch_role.id
  
}

resource "aws_iam_role" "pod_apigw_cloudwatch_role" {
  name = var.pod_apigw_cloudwatch_role
  assume_role_policy = data.aws_iam_policy_document.pod_apigw_allow_assume_role.json
}
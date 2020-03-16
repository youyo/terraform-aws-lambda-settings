resource "aws_lambda_function" "this" {
  function_name                  = var.name
  filename                       = "${path.module}/lambda_function.zip"
  role                           = aws_iam_role.this.arn
  handler                        = var.handler
  runtime                        = var.runtime
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  layers                         = var.layers
  description                    = var.description
  reserved_concurrent_executions = var.reserved_concurrent_executions
  publish                        = var.publish
  kms_key_arn                    = var.kms_key_arn

  dynamic "environment" {
    for_each = length(var.environment_variables) > 0 ? [true] : []

    content {
      variables = var.environment_variables
    }
  }

  dynamic "vpc_config" {
    for_each = var.enable_vpc_config ? [true] : []

    content {
      security_group_ids = var.vpc_config_security_group_ids
      subnet_ids         = var.vpc_config_subnet_ids
    }
  }

  tracing_config {
    mode = var.tracing_config_mode
  }

  dynamic "dead_letter_config" {
    for_each = var.enable_dead_letter_config ? [true] : []

    content {
      target_arn = var.dead_letter_config_target_arn
    }
  }

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )

  depends_on = [
    aws_cloudwatch_log_group.this
  ]
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.name}"
  retention_in_days = var.retention_in_days

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

resource "aws_iam_role" "this" {
  name_prefix        = "${var.name}-"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  path               = var.role_path

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy" "this" {
  name_prefix = "${var.name}-"
  role        = aws_iam_role.this.name
  policy      = var.role_policy
}

resource "aws_lambda_permission" "this" {
  count = var.add_sns_permission ? 1 : 0

  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_topic_arn
}

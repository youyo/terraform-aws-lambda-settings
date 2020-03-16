# AWS Lambda Terraform module

Terraform module which creates Lambda resources on AWS.  
Not deploy function code, and configure other settings.  
  
How do you deploy your code?  
I use lambroll.  
https://github.com/fujiwara/lambroll

## Requiirements

- Terraform version > 0.12

## Basic Usage

```hcl
module "lambda-settings" {
  source = "youyo/lambda-settings/aws"

  name    = "my-function"
  handler = "lambda_function.lambda_handler"
  runtime = "python3.8"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

- Custom IAM Role policy

```hcl
module "lambda-settings" {
  source = "youyo/lambda-settings/aws"

  role_policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "s3:*"
    ]
    resources = ["*"]
  }
}
```

- Invoke from SNS

```hcl
module "lambda-settings" {
  source = "youyo/lambda-settings/aws"

  add_sns_permission = true
  sns_topic_arn      = aws_sns_topic.default.arn
}

resource "aws_sns_topic" "default" {}

resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = aws_sns_topic.default.arn
  protocol  = "lambda"
  endpoint  = module.lambda-settings.lambda_arn
}
```

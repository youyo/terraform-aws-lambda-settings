# AWS Lambda Terraform module

Terraform module which creates Lambda resources on AWS.  
Not deploy function code, and configure other settings.

## Requiirements

- Terraform version > 0.12

## Usage

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

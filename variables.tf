variable "name" {
  type        = string
  default     = "lambda-function"
  description = "A unique name for your Lambda Function"
}
variable "handler" {
  type        = string
  default     = "lambda_function.lambda_handler"
  description = "The function entrypoint in your code"
}
variable "runtime" {
  type        = string
  default     = "python3.8"
  description = "Lambda Function Runtime"
}
variable "memory_size" {
  type        = number
  default     = 128
  description = "Amount of memory in MB your Lambda Function can use at runtime"
}
variable "timeout" {
  type        = number
  default     = 10
  description = "The amount of time your Lambda Function has to run in seconds"
}
variable "layers" {
  type        = list(string)
  default     = []
  description = "List of Lambda Layer Version ARNs to attach to your Lambda Function"
}
variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "A map that defines environment variables for the Lambda function"
}
variable "retention_in_days" {
  type        = number
  default     = 180
  description = "Specifies the number of days you want to retain log events in the specified log group"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource"
}
variable "role_policy" {
  type        = string
  default     = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Action\":[\"logs:CreateLogGroup\",\"logs:CreateLogStream\",\"logs:PutLogEvents\"],\"Resource\":\"*\"}]}"
  description = "IAM role policy attached to the Lambda Function"
}
variable "role_path" {
  type        = string
  default     = "/"
  description = "The path to the lambda iam role"
}
variable "enable_vpc_config" {
  type        = bool
  default     = false
  description = "Provide this to allow your function to access your VPC"
}
variable "vpc_config_security_group_ids" {
  type        = list(string)
  default     = []
  description = "A list of security group IDs associated with the Lambda function"
}
variable "vpc_config_subnet_ids" {
  type        = list(string)
  default     = []
  description = "A list of subnet IDs associated with the Lambda function"
}
variable "tracing_config_mode" {
  type        = string
  default     = "PassThrough"
  description = "The function's AWS X-Ray tracing configuration"
}
variable "enable_dead_letter_config" {
  type        = bool
  default     = false
  description = "The dead-letter queue for failed asynchronous invocations"
}
variable "dead_letter_config_target_arn" {
  type        = string
  default     = ""
  description = "The ARN of an SNS topic or SQS queue to notify when an invocation fails"
}
variable "description" {
  type        = string
  default     = ""
  description = "Description of what your Lambda Function does"
}
variable "reserved_concurrent_executions" {
  type        = number
  default     = -1
  description = "The amount of reserved concurrent executions for this lambda function"
}
variable "publish" {
  type        = bool
  default     = false
  description = "Whether to publish creation/change as new Lambda Function Version"
}
variable "kms_key_arn" {
  type        = string
  default     = ""
  description = "ARN of the KMS key that is used to encrypt environment variables"
}
variable "add_sns_permission" {
  type        = bool
  default     = false
  description = "Creates a Lambda permission to allow SNS invoking the Lambda function"
}
variable "sns_topic_arn" {
  type        = string
  default     = ""
  description = "ARN of the SNS topic"
}

variable "aws_region" {
  description = "The AWS region where resources will be created"
  default     = "us-east-1"
}

variable "readonly_group_name" {
  description = "Read-only IAM group for support engineers"
  default     = "SupportTechsReadOnly"
}

variable "engineer_group_name" {
  description = "IAM group for engineers with EC2 access"
  default     = "Engineers"
}

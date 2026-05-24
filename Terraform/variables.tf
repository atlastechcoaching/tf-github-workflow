variable "aws_region" {
  description = "AWS region where resources are created."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix used for demo resources."
  type        = string
  default     = "tf-github-workflow"
}

variable "instance_type" {
  description = "EC2 instance type for the demo web server."
  type        = string
  default     = "t3.micro"
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access HTTP on the instance."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "default_tags" {
  description = "Tags applied to all supported AWS resources."
  type        = map(string)
  default = {
    Project     = "tf-github-workflow"
    Environment = "training"
    ManagedBy   = "terraform"
  }
}

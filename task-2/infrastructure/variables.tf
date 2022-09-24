variable "aws_profile" {
  description = "AWS Profile to create resources using Terraform"
  default     = "my-terraform-user"
}

variable "aws_region" {
  description = "AWS region to create resources using Terraform"
  default     = "ap-southeast-2"
}

variable "jenkins_vpc_id" {
  description = "AWS VPC to provision Jenkins instance (use default vpc)"
  default     = "vpc-009c785ea07081f0d"
}

variable "jenkins_subnet_a_id" {
  description = "AWS Subnet to provision Jenkins instance"
  default = "subnet-096d491a2cb4fb9f4"
}
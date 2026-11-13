variable "aws_region" {
  description = "AWS region containing the existing infrastructure and new security groups."
  type        = string
}

variable "project_id" {
  description = "Project identifier applied to the security groups."
  type        = string
}

variable "allowed_ip_range" {
  description = "List of CIDR ranges allowed to access the public-facing infrastructure."
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the existing VPC."
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the existing public subnet."
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the existing private subnet."
  type        = string
}

variable "public_instance_id" {
  description = "ID of the existing public EC2 instance."
  type        = string
}

variable "private_instance_id" {
  description = "ID of the existing private EC2 instance."
  type        = string
}

variable "ssh_security_group_name" {
  description = "Name of the SSH security group."
  type        = string
}

variable "public_http_security_group_name" {
  description = "Name of the public HTTP security group."
  type        = string
}

variable "private_http_security_group_name" {
  description = "Name of the private HTTP security group."
  type        = string
}

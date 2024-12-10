variable "base_ami" {
  description = "AMI for the base instance"
  type        = string
}

variable "ami_name" {
  description = "Name for the AMI"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the base instance"
  type        = string
}

variable "user_data" {
  description = "User data script for the base instance"
  type        = string
}

variable "instances" {
  description = "Details for additional webserver instances"
  type = map(object({
    instance_type = string
    subnet_id     = string
    user_data     = string
  }))
}

variable "security_group_id" {
  description = "Security group ID for the instances"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for the load balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the resources"
  type        = string
}

variable "lb_name" {
  description = "Name of the application load balancer"
  type        = string
}

variable "tg_name" {
  description = "Name of the target group"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

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


variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnets"
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
}



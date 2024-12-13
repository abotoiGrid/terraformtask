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
variable "instance_ids" {
  description = "Map of instance IDs to attach to the target group"
  type        = map(string)
}
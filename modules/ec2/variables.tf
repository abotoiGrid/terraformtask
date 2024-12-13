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

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "instances" {
  description = "List of instances to create"
  type = list(object({
    instance_type = string
    subnet_index  = number
    user_data     = string
  }))
}

variable "security_group_id" {
  description = "Security group ID for the instances"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

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

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

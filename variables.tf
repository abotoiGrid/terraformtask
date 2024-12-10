# variable "cidr" {
#   default = "10.0.0.0/16"
# }

# variable "vpc_id" {
#   description = "VPC ID for the resources"
#   type        = string
# }

# variable "subnets" {
#   description = "Subnet configurations"
#   type = list(object({
#     cidr_block        = string
#     availability_zone = string
#   }))
# }

# variable "security_groups" {
#   description = "Security group IDs for the ALB"
#   type        = list(string)
# }

# variable "target_ids" {
#   description = "Instance IDs for the Target Group attachments"
#   type        = list(string)
# }

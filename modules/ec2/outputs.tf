output "instance_ids" {
  value = { for idx, instance in aws_instance.web_instances : idx => instance.id }
}
resource "aws_instance" "base_instance" {
  ami           = var.base_ami
  instance_type = var.instance_type
  user_data     = base64encode(file("${path.root}/scripts/${var.user_data}"))
  tags          = var.tags
}

resource "aws_ami_from_instance" "ami" {
  name               = var.ami_name
  description        = "AMI for webservers"
  source_instance_id = aws_instance.base_instance.id
  tags               = var.tags
}

resource "aws_instance" "web_instances" {
  for_each = { for idx, instance in var.instances : idx => instance }

  ami                    = aws_ami_from_instance.ami.id
  instance_type          = each.value.instance_type
  subnet_id              = var.subnet_ids[each.value.subnet_index]
  vpc_security_group_ids = [var.security_group_id]
  user_data              = base64encode(file("${path.root}/scripts/${each.value.user_data}"))
  tags                   = merge(var.tags, { Name = "webserver${each.key + 1}" })
}


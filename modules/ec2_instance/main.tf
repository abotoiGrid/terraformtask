resource "aws_instance" "base_instance" {
  ami           = var.base_ami
  instance_type = var.instance_type
  user_data     = base64encode(file(var.user_data))
  tags          = var.tags
}

resource "aws_ami_from_instance" "ami" {
  name               = var.ami_name
  description        = "AMI for webservers"
  source_instance_id = aws_instance.base_instance.id
  tags               = var.tags
}

resource "aws_instance" "web_instances" {
  for_each = var.instances

  ami                    = aws_ami_from_instance.ami.id
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  user_data              = base64encode(file(each.value.user_data))
  tags                   = merge(var.tags, { Name = each.key })
}

resource "aws_lb" "application_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids
  tags               = var.tags
}

resource "aws_lb_target_group" "target_group" {
  name     = var.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "attachments" {
  for_each = aws_instance.web_instances

  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }
}

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
  for_each = var.instance_ids

  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = each.value
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
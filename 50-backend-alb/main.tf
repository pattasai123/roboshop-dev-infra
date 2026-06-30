resource "aws_lb" "frontend-lb" {
  name               = "frontend-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.security_groups]
  subnets            = local.subnet

  enable_deletion_protection = true

  tags = merge(
    var.frontend_lb_tags,
    local.common_tags,
    {
      Name = local.common_name
    }
  )
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.frontend-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "hi, i am from backend"
      status_code  = "200"
    }
  }
}
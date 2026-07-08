resource "aws_lb" "backend_lb" {
  name               = "backend-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.security_groups]
  subnets            = local.subnet

  enable_deletion_protection = false

  tags = merge(
    var.backend_lb_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-backend_lb"
    }
  )
}
resource "aws_lb_listener" "backend" {
  load_balancer_arn = aws_lb.backend_lb.arn
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
resource "aws_route53_record" "backend" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "*.backend-alb-${var.env}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.backend_lb.dns_name
    zone_id                = aws_lb.backend_lb.zone_id
    evaluate_target_health = true
  }
}
resource "aws_ssm_parameter" "backend_alb_arn" {
  name  = "/${var.project}/${var.environment}/backend_alb_arn"
  type  = "String"
  value = aws_lb.backend-lb.arn
}
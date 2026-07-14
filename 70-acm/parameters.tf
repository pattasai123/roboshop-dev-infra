resource "aws_ssm_parameter" "frontend_alb_arn" {
  name  = "/${var.project}/${var.env}/frontend_alb_arn"
  type  = "String"
  value = aws_acm_certificate.roboshop.arn
}
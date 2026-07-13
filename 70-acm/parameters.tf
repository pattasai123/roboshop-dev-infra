resource "aws_ssm_parameter" "fronted_alb_arn" {
  name  = "/${var.project}/${var.env}/fronted_alb_arn
  value = aws_acm_certificate.roboshop.arn
}
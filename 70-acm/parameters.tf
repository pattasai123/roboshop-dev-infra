resource "aws_ssm_parameter" "fronted_alb_arn" {
  name  = "/${var.project}/${var.env}/fronted_alb_arn"
  type  = "String"
  value = aws_acm_certificate.roboshop.arn
}
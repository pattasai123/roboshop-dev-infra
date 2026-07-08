data "aws_ssm_parameter" "backend_lb_sg_id" {
  name = "/${var.project}/${var.env}/backend_lb_sg_id"
}

data "aws_ssm_parameter" "private_subnet_a" {
  name = "/${var.project}/${var.env}/private_subnet_a"
}

data "aws_ssm_parameter" "private_subnet_b" {
  name = "/${var.project}/${var.env}/private_subnet_b"
}

data "aws_route53_zone" "zone" {
  name         = "bongu.online"
  private_zone = false
}
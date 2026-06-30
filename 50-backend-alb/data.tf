data "aws_ssm_parameter" "frontend-lb_sg_id" {
  name = "/${var.project}/${var.environment}/frontend-lb_sg_id"
}

data "aws_ssm_parameter" "public_subnet_a" {
  name = "/${var.project}/${var.environment}/public_subnet_a"
}

data "aws_ssm_parameter" "public_subnet_b" {
  name = "/${var.project}/${var.environment}/public_subnet_b"
}

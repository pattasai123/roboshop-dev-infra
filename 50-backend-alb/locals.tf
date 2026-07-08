locals{
    security_groups=data.aws_ssm_parameter.backend_lb_sg_id.value
    subnet=[
    data.aws_ssm_parameter.private_subnet_a.value,
    data.aws_ssm_parameter.private_subnet_b.value
    ]
    common_name = "${var.project}-${var.env}"

  common_tags = {
    project   = var.project
    env       = var.env
    terraform = true
  }
}
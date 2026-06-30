locals{
    security_groups=data.aws_ssm_parameter.frontend-lb_sg_id.value
    subnet=[
    data.aws_ssm_parameter.public_subnet_a.value,
    data.aws_ssm_parameter.public_subnet_b.value
    ]
    common_name = "${var.project}-${var.environment}-bastion"

  common_tags = {
    project   = var.project
    env       = var.environment
    terraform = true
  }
}
locals {
  ami              = data.aws_ami.joindevops.id
  fronted= data.aws_ssm_parameter.fronted_lb_sg_id.value
  frontend_arn=data.aws_ssm_parameter.fronted_alb_arn.value
   subnet=[
    data.aws_ssm_parameter.public_subnet_a.value,
    data.aws_ssm_parameter.public_subnet_b.value
    ]
  common_name = "${var.project}-${var.env}"

  common_tags = {
    project   = var.project
    env       = var.env
    terraform = true
  }
}
locals {
  ami              = data.aws_ami.joindevops.id
  catalogue_sg_id    = data.aws_ssm_parameter.catalogue_sg_id.value
   subnet=[
    data.aws_ssm_parameter.private_subnet_a.value,
    data.aws_ssm_parameter.private_subnet_b.value
    ]
  common_name = "${var.project}-${var.environment}"

  common_tags = {
    project   = var.project
    env       = var.environment
    terraform = true
  }
}
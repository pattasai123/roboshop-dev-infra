locals {
  ami              = data.aws_ami.joindevops.id
  mongodb_sg_id    = data.aws_ssm_parameter.mongodb_sg_id.value
   subnet=[
    data.aws_ssm_parameter.database_subnet_a.value,
    data.aws_ssm_parameter.database_subnet_b.value
    ]
  common_name = "${var.project}-${var.environment}-mongodb"

  common_tags = {
    project   = var.project
    env       = var.environment
    terraform = true
  }
}
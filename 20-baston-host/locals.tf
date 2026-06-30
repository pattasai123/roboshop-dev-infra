locals {
  ami              = data.aws_ami.joindevops.id
  bastion_sg_id    = data.aws_ssm_parameter.bastion_sg_id.value

  common_name = "${var.project}-${var.environment}-bastion"

  common_tags = {
    project   = var.project
    env       = var.environment
    terraform = true
  }
}
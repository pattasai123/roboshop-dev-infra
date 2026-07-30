locals {
  ami              = data.aws_ami.vpn.id
  vpn_sg_id    = data.aws_ssm_parameter.vpn_sg_id.value

  common_name = "${var.project}-${var.environment}-vpn"

  common_tags = {
    project   = var.project
    env       = var.environment
    terraform = true
  }
}
module "security_group" {
  source = "git::https://github.com/pattasai123/terraform-aws-security.git"

  count=length(var.sg_names)
  name        = var.sg_names[count.index]
  description = "roboshop dev security group"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  sg_name=var.sg_names[count.index]
  project=var.project
  environment=var.environment
}
/*
resource "aws_security_group_rule" "frontend_group" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id=module.security_group[11].sg_id
  security_group_id = module.security_group[9].sg_id
}
*/
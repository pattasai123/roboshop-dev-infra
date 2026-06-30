data "aws_ami" "joindevops" {
  most_recent = true
  owners      = ["832510228841"]
}

data "aws_ssm_parameter" "public_subnet_a" {
  name = "/${var.project}/${var.environment}/public_subnet_a"
}
data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/${var.project}/${var.environment}/bastion_sg_id"
}
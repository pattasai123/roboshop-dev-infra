data "aws_ami" "joindevops" {
  most_recent = true
  owners      = ["832510228841"]
}

data "aws_iam_role" "ec2" {
  name = "EC2ssmparameters"
}

data "aws_ssm_parameter" "private_subnet_a" {
  name = "/${var.project}/${var.environment}/database_subnet_a"
}
data "aws_ssm_parameter" "private_subnet_b" {
  name = "/${var.project}/${var.environment}/database_subnet_b"
}
data "aws_ssm_parameter" "catalogue_sg_id" {
  name = "/${var.project}/${var.environment}/catalogue_sg_id"
}

data "aws_route53_zone" "zone" {
  name         = "bongu.online"
  private_zone = false
}

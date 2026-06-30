resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.env_name}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
}
resource "aws_ssm_parameter" "public_subnet_a" {
  name  = "/${var.project_name}/${var.env_name}/public_subnet_a"
  type  = "String"
  value = module.vpc.public_subnet_ids[0]
}

resource "aws_ssm_parameter" "public_subnet_b" {
  name  = "/${var.project_name}/${var.env_name}/public_subnet_b"
  type  = "String"
  value = module.vpc.public_subnet_ids[1]
}
resource "aws_ssm_parameter" "private_subnet_a" {
  name  = "/${var.project_name}/${var.env_name}/private_subnet_a"
  type  = "String"
  value = module.vpc.private_subnet_ids[0]
}

resource "aws_ssm_parameter" "private_subnet_b" {
  name  = "/${var.project_name}/${var.env_name}/private_subnet_b"
  type  = "String"
  value = module.vpc.private_subnet_ids[1]
}
resource "aws_ssm_parameter" "database_subnet_a" {
  name  = "/${var.project_name}/${var.env_name}/database_subnet_a"
  type  = "String"
  value = module.vpc.database_subnet_ids[0]
}

resource "aws_ssm_parameter" "database_subnet_b" {
  name  = "/${var.project_name}/${var.env_name}/database_subnet_b"
  type  = "String"
  value = module.vpc.database_subnet_ids[1]
}
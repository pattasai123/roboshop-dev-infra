data "aws_ami" "vpn" {
    owners           = ["679593333241"]
    most_recent      = true
    
    filter {
        name   = "name"
        values = ["OpenVPN Access Server Community Image-8fbe3379-*"]
    }
}

data "aws_ssm_parameter" "public_subnet_a" {
  name = "/${var.project}/${var.environment}/public_subnet_a"
}
data "aws_ssm_parameter" "vpn_sg_id" {
  name = "/${var.project}/${var.environment}/vpn_sg_id"
}

data "aws_route53_zone" "zone" {
  name         = "bongu.online"
  private_zone = false
}

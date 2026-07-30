resource "aws_instance" "vpn" {
  ami                    = local.ami
  instance_type          = var.instance_type

  subnet_id              = data.aws_ssm_parameter.public_subnet_a.value
  vpc_security_group_ids = [local.vpn_sg_id]
  user_data=file("vpn.sh")
  tags = merge(
    var.vpn_tags,
    local.common_tags,
    {
      Name = local.common_name
    }
  )
}

resource "aws_route53_record" "route53" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "vpn.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.vpn.public_ip]
  allow_overwrite = true
}
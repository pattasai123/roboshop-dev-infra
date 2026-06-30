resource "aws_instance" "bastion-host" {
  ami                    = local.ami
  instance_type          = var.instance_type

  subnet_id              = data.aws_ssm_parameter.public_subnet_a.value
  vpc_security_group_ids = [local.bastion_sg_id]

  tags = merge(
    var.bastion_tags,
    local.common_tags,
    {
      Name = local.common_name
    }
  )
}
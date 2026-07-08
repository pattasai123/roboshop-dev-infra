resource "aws_iam_instance_profile" "bastion" {
  name = "bastion"
  role = data.aws_iam_role.bastion.name
}

resource "aws_instance" "bastion-host" {
  ami                    = local.ami
  instance_type          = var.instance_type

  subnet_id              = data.aws_ssm_parameter.public_subnet_a.value
  vpc_security_group_ids = [local.bastion_sg_id]
  user_data=file("bootstrap.sh")
  iam_instance_profile   = aws_iam_instance_profile.bastion.name
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }
  tags = merge(
    var.bastion_tags,
    local.common_tags,
    {
      Name = local.common_name
    }
  )
}
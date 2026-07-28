resource "aws_instance" "vpc" {
  ami                    = local.ami
  instance_type          = var.instance_type

  subnet_id              = data.aws_ssm_parameter.public_subnet_a.value
  vpc_security_group_ids = [local.vpc_sg_id]
  user_data=file("vpc.sh")
  iam_instance_profile   = aws_iam_instance_profile.bastion.name
  tags = merge(
    var.vpc_tags,
    local.common_tags,
    {
      Name = local.common_name
    }
  )
}
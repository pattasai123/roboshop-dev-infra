locals {
  ami              = data.aws_ami.joindevops.id
  mongodb_sg_id    = data.aws_ssm_parameter.mongodb_sg_id.value
  redis_sg_id    = data.aws_ssm_parameter.redis_sg_id.value

  rabbitmq_sg_id    = data.aws_ssm_parameter.rabbitmq_sg_id.value
   subnet=[
    data.aws_ssm_parameter.database_subnet_a.value,
    data.aws_ssm_parameter.database_subnet_b.value
    ]
  common_name = "${var.project}-${var.environment}"

  common_tags = {
    project   = var.project
    env       = var.environment
    terraform = true
  }
}
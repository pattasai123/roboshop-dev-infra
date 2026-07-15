resource "aws_security_group_rule" "bastion_group" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id=local.source_security_group
  security_group_id = local.security_group
}

resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.source_security_group
  cidr_blocks=["0.0.0.0/0"]
}

resource "aws_security_group_rule" "mongodb" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  security_group_id        = data.aws_ssm_parameter.mongodb_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}

resource "aws_security_group_rule" "redis" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  security_group_id        = data.aws_ssm_parameter.redis_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}

resource "aws_security_group_rule" "rabbitmq" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  security_group_id        = data.aws_ssm_parameter.rabbitmq_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}

resource "aws_security_group_rule" "mysql" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  security_group_id        = data.aws_ssm_parameter.mysql_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}

resource "aws_security_group_rule" "catalogue" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.catalogue_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}
resource "aws_security_group_rule" "user" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.user_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}
resource "aws_security_group_rule" "cart" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.cart_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}
resource "aws_security_group_rule" "shipping" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.shipping_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}
resource "aws_security_group_rule" "payment" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.payment_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}
/*
resource "aws_security_group_rule" "cataloguet_to_bastion" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.bastion_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.catalogue_sg_id.value
}
*/

resource "aws_security_group_rule" "catalogue_to_mongodb" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.mongodb_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.catalogue_sg_id.value
}

resource "aws_security_group_rule" "catalogue_to_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.redis_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.catalogue_sg_id.value
}

resource "aws_security_group_rule" "user_to_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.redis_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.user_sg_id.value
}

resource "aws_security_group_rule" "cart_to_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.redis_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.cart_sg_id.value
}

resource "aws_security_group_rule" "shipping_to_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.mysql_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.shipping_sg_id.value
}

resource "aws_security_group_rule" "payment_to_rabbitmq" {
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.rabbitmq_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.payment_sg_id.value
}

resource "aws_security_group_rule" "backend-alb-to-catalogue" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.catalogue_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.backend_lb_sg_id.value
}

resource "aws_security_group_rule" "fronted-to-backend_lb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.backend_lb_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.frontend_sg_id.value
}

resource "aws_security_group_rule" "fronted-to-fronted_lb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.frontend_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.fronted_lb_sg_id.value
}

resource "aws_security_group_rule" "internet-to-fronted-alb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = data.aws_ssm_parameter.fronted_lb_sg_id.value
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "cart-to-catalogue" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.catalogue_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.cart_sg_id.value
}

resource "aws_security_group_rule" "cart-to-redis" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.redis_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.cart_sg_id.value
}

resource "aws_security_group_rule" "shipping-to-cart" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.cart_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.shipping_sg_id.value
}

resource "aws_security_group_rule" "payment-to-cart" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.cart_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.payment_sg_id.value
}

resource "aws_security_group_rule" "payment-to-user" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = data.aws_ssm_parameter.user_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.payment_sg_id.value
}
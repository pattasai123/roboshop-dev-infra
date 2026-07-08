resource "aws_instance" "catalogue_host" {
  ami                    = local.ami
  instance_type          = var.instance_type

  subnet_id              = local.subnet[0]
  vpc_security_group_ids = [local.catalogue_sg_id]

  tags = merge(
    var.bastion_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-catalogue"
    }
  )
}

 resource "terraform_data" "catalogue" {
 
  triggers_replace = [
    aws_instance.catalogue_host.id
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    password    = "DevOps321"
    host        = aws_instance.catalogue_host.private_ip
  }
  provisioner "file" {
    source      = "bootstrap.sh"             # Path on your local machine
    destination = "/tmp/bootstrap.sh"     # Path on the remote server
  }
  provisioner "remote-exec" {
    
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh"
    ]
  }
}

resource "aws_route53_record" "route53" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "${var.instance}-${var.env}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.catalogue_host.private_ip]
  allow_overwrite = true
}

resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue_host.id
  state       = "stopped" # Valid values: running, stopped
  depends_on = [terraform_data.catalogue]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "terraform-catalogue"
  source_instance_id = aws_instance.catalogue_host.id
  depends_on = [aws_ec2_instance_state.catalogue]
}
 
resource "aws_lb_target_group" "catalogue" {
  name     = "${local.common_name}-catalogue-lb-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc_id.value
  deregistration_delay = 100
  health_check{
    enabled= "true"
    healthy_threshold = 2
    interval = 10
    matcher = "200-299"
    path = "/health"
    port = 8080
    protocol = "HTTP"
    unhealthy_threshold = 2
  }
  depends_on = [aws_ami_from_instance.catalogue]
}

resource "aws_launch_template" "catalogue" {
  name = "${local.common_name}-catalogue-launch-template"
  image_id = "ami-aws_ami_from_instance.catalogue.id"

  instance_initiated_shutdown_behavior = "terminate"
  
  instance_type = "t3.micro"

  placement {
    availability_zone = "us-east-1a"
  }

  vpc_security_group_ids = local.subnet

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name="${local.common_name}-catalogue"
      }
    )
  }
    tag_specifications {
    resource_type = "volume"

    tags = merge(
      local.common_tags,
      {
        Name="${local.common_name}-catalogue"
      }
    )
  }
  tags = merge(
      local.common_tags,
      {
        Name="${local.common_name}-catalogue"
      }
    )
    depends_on = [aws_lb_target_group.catalogue]
}

resource "aws_autoscaling_group" "catalogue" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.catalogue.id
    version = "$Latest"
  }
  depends_on = [aws_launch_template.catalogue]
}

resource "aws_autoscaling_policy" "catalogue" {
  name                   = "${local.common_name}-catalogue-autoscaling-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 100
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  depends_on = [aws_autoscaling_group.catalogue]
}

resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = local.backend_alb_arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  condition {
    host_header {
      values = ["catalogue.backend_alb-${var.env}.${var.domain_name}"]
    }
  }
  depends_on = [aws_autoscaling_policy.catalogue]
}
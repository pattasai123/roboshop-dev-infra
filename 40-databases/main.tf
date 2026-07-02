resource "aws_instance" "mongodb_host" {
  ami                    = local.ami
  instance_type          = var.instance_type

  subnet_id              = local.subnet[0]
  vpc_security_group_ids = [local.mongodb_sg_id]

  tags = merge(
    var.bastion_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-mongodb"
    }
  )
}

 resource "terraform_data" "mongodb" {
 
  triggers_replace = [
    aws_instance.mongodb_host.id
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    password    = "DevOps321"
    host        = aws_instance.mongodb_host.private_ip
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


resource "aws_instance" "redis_host" {
  ami                    = local.ami
  instance_type          = var.instance_type

  subnet_id              = local.subnet[0]
  vpc_security_group_ids = [local.redis_sg_id]

  tags = merge(
    var.bastion_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-redis"
    }
  )
}

 resource "terraform_data" "redis" {
 
  triggers_replace = [
    aws_instance.redis_host.id
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    password    = "DevOps321"
    host        = aws_instance.redis_host.private_ip
  }
  provisioner "file" {
    source      = "bootstrap.sh"             # Path on your local machine
    destination = "/tmp/bootstrap.sh"     # Path on the remote server
  }
  provisioner "remote-exec" {
    
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis"
    ]
  }
}

resource "aws_instance" "rabbitmq_host" {
  ami                    = local.ami
  instance_type          = var.instance_type

  subnet_id              = local.subnet[0]
  vpc_security_group_ids = [local.rabbitmq_sg_id]

  tags = merge(
    var.bastion_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-rabbitmq"
    }
  )
}

 resource "terraform_data" "rabbitmq" {
 
  triggers_replace = [
    aws_instance.rabbitmq_host.id
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    password    = "DevOps321"
    host        = aws_instance.rabbitmq_host.private_ip
  }
   provisioner "file" {
    source      = "bootstrap.sh"             # Path on your local machine
    destination = "/tmp/bootstrap.sh"     # Path on the remote server
  }
  provisioner "remote-exec" {
    
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq"
    ]
  }
}


resource "aws_instance" "mysql_host" {
  ami                    = local.ami
  instance_type          = var.instance_type

  subnet_id              = local.subnet[0]
  vpc_security_group_ids = [local.mysql_sg_id]
  iam_instance_profile= EC2ssmparameters.mysql.name

  tags = merge(
    var.bastion_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-mysql"
    }
  )
}

resource "aws_iam_instance_profile" "mysql" {
  name = "mysql"
  role = EC2ssmparameters
}

 resource "terraform_data" "mysql" {
 
 triggers_replace = [
    aws_instance.mysql_host.id
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    password    = "DevOps321"
    host        = aws_instance.mysql_host.private_ip
  }
   provisioner "file" {
    source      = "bootstrap.sh"             # Path on your local machine
    destination = "/tmp/bootstrap.sh"     # Path on the remote server
  }
  provisioner "remote-exec" {
    
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mysql dev"
    ]
  }
}
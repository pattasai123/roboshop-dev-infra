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

 resource "null_resource" "cluster" {
 
  triggers = {
    instance_id = aws_instance.mongodb_host.id
  }

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

/*
resource "aws_instance" "redis_host" {
  ami                    = local.ami
  instance_type          = var.instance_type

  subnet_id              = local.subnet[0]
  vpc_security_group_ids = [local.redis_sg_id]

  tags = merge(
    var.bastion_tags,
    local.common_tags,
    {
      Name = local.common_name
    }
  )
}

 resource "null_resource" "cluster" {
 
  triggers = {
    instance_id = aws_instance.redis_host.id
  }

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
      "sudo sh /tmp/bootstrap.sh"
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
      Name = local.common_name
    }
  )
}

 resource "null_resource" "cluster" {
 
  triggers = {
    instance_id = aws_instance.rabbitmq_host.id
  }

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
      "sudo sh /tmp/bootstrap.sh"
    ]
  }
}
*/
resource "aws_instance" "mongodb_host" {
  ami                    = local.ami
  instance_type          = var.instance_type

  subnet_id              = local.subnet[0]
  vpc_security_group_ids = [local.mongodb_sg_id]

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
    instance_id = aws_instance.mongodb_host.id
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    password = "DevOps321"
    host        = aws_instance.mongodb_host.private_ip
  }

  provisioner "remote-exec" {
    
    inline = [
      "echo hello world"
    ]
  }
}
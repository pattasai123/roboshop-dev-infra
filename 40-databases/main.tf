resource "aws_instance" "mongodb-host" {
  ami                    = local.ami
  instance_type          = var.instance_type

  subnet_id              = local.subnet
  vpc_security_group_ids = [local.mongodb_sg_id]

  tags = merge(
    var.bastion_tags,
    local.common_tags,
    {
      Name = local.common_name
    }
  )
  resource "null_resource" "cluster" {
 
  triggers_replace = [
    aws_instance.web.id
  ]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    password = "DevOps321"
    host        = aws_instance.mongodb-host.private_ip
  }

  provisioner "remote-exec" {
    
    inline = [
      "echo hello world"
    ]
  }
}
}
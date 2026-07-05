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
  count=1
  zone_id = aws_route53_zone.zone.zone_id
  name    = "${var.terraform[count.index]}-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.terraform[count.index].private_ip]
  allow_overwrite = true
}
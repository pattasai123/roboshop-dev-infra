data "aws_ami" "joindevops" {
  most_recent = true
  owners      = ["832510228841"]
}

data "aws_route53_zone" "zone" {
  name         = "bongu.online"
  private_zone = false
}

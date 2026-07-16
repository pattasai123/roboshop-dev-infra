module "component"{
  source="git::https://github.com/pattasai123/terraform-roboshop-dev-components.git"
  for_each=var.components
  components=each.key
  instance_type="t3.micro"
  priority=each.value
  project=var.project
  env=var.env
  domain_name=var.domain_name
}

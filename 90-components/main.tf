module "component"{
  source="git::https://github.com/pattasai123/terraform-roboshop-dev-components.git"
  for_each=var.components
  components=each.key
  priority=each.value
  
  instance_type="t3.micro"
  project=var.project
  env=var.env
  domain_name=var.domain_name
}

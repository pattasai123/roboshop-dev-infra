module "component"{
  source="../../terraform-roboshop-dev-components"
  components=var.components
  instance="t3.micro"
  project=var.project
  env=var.env
  domain_name=var.domain_name
}

module "vpc"{
    source= "git::https://github.com/pattasai123/terraform-vpc.git"

    #VPC
    vpc_cidr=var.vpc_cidr
    project_name=var.project_name
    env_name=var.env_name
    user_tags=var.user_tags

    #public subnets
    public_subnet_cidr=var.public_cidr

    #private subnets
    private_subnet_cidr=var.private_cidr

    #database subnets
    database_subnet_cidr=var.database_cidr
}

/*
data "aws_availability_zones" "available" {
  state = "available"
}
*/
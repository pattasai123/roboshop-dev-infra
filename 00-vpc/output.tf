output "vpc"{
    value=module.vpc.vpc_id
}
/*
output "av_zone"{
    value=data.aws_availability_zones.available
}
*/

output "public_subnet_id"{
    value=module.vpc.public_subnet_ids
}

output "private_subnet_id"{
    value=module.vpc.private_subnet_ids
}

output "database_subnet_id"{
    value=module.vpc.database_subnet_ids
}

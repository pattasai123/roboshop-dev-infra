output "sg"{
    value=module.security_group[*].sg_id
}
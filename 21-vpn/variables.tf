variable "instance_type"{
    default="t3.micro"
}

variable "vpn_tags"{
    type=map(string)
    default={}
}

variable "project"{
    default="roboshop"
}

variable "environment"{
    default="dev"
}

variable "domain_name"{
    default="bongu.online"
}
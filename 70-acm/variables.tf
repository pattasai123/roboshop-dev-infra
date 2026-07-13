variable "instance_type"{
    default="t3.micro"
}

variable "acm_tags"{
    type=map(string)
    default={}
}

variable "project"{
    default="roboshop"
}

variable "env"{
    default="dev"
}

variable "domain_name"{
    default="bongu.online"
}

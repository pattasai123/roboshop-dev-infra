variable "instance_type"{
    default="t3.micro"
}

variable "bastion_tags"{
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

variable "instance"{
    default="catalogue"
}
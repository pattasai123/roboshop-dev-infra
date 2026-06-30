variable "project"{
    default="roboshop"
}

variable "environment"{
    default="dev"
}

variable "sg_names"{
    default=["mongodb","redis","mysql","rabbitmq","catalogue","user","cart","payment","shipping","frontend","bastion","frontend-lb"]
}
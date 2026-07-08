variable "frontend_lb_tags"{
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
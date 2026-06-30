variable "frontend_lb_tags"{
    type=map(string)
    default={}
}

variable "project"{
    default="roboshop"
}

variable "environment"{
    default="dev"
}
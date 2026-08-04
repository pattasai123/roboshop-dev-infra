variable "project"{
    default="roboshop"
}

variable "env"{
    default="dev"
}

variable "domain_name"{
    default="bongu.online"

}

variable "cloudfront_tags"{
    type=map(string)
    default={}
}


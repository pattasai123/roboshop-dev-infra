variable "vpc_cidr"{
    default="10.0.0.0/16"
}

variable "project_name"{
    default="roboshop"
}

variable "env_name"{
    default="dev"
}

variable "user_tags"{
    default={
        nmae="roboshop-dev-infra"
        DontDelete= true
    }
}

variable "public_cidr"{
    default=["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_cidr"{
    default=["10.0.11.0/24","10.0.12.0/24"]
}

variable "database_cidr"{
    default=["10.0.21.0/24","10.0.22.0/24"]
}
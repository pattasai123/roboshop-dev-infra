variable "project"{
    default="roboshop"
}

variable "env"{
    default="dev"
}

variable "domain_name"{
    default="bongu.online"

}

variable "components" {
  type = map(number)

  default = {
    catalogue = 10
    user      = 20
    cart      = 30
    payment   = 40
    shipping  = 50
    frontend  = 10
  }
}


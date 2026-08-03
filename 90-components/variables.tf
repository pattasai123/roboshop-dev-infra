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
  default = {
        /*
        catalogue = {
            priority = 10
        }
        user = {
            priority = 20
        }
        cart = {
           priority = 30
        }
        shipping = {
            priority = 40
        }
        */
        payment = {
           priority = 50
        }
        /*
        frontend = {
            priority = 10
        }
        */
    }
}


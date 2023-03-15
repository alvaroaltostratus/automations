variable "project" {
    type        = string
    description = "El proyecto (cliente) en el que vamos a trabajar."
}

variable "region" {
    type        = string
    description = "La región donde se va a aplicar el parche."
}

variable "zones" {
    type        = list(string)
    description = "Las zonas en donde se va a aplicar el parche."
}
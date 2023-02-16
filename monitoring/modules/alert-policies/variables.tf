variable "client_project" {
    type        = string
    description = "El proyecto (cliente) en el que vamos a trabajar."
}

variable "client_project_number" {
    type        = string
    description = "El numero de proyecto del cliente."
}

variable "notification_channel" {
    type        = string
    description = "El canal de notificacion (pub/sub)"
}
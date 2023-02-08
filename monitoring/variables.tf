variable "client_project" {
    type        = string
    description = "El proyecto (cliente) en el que vamos a trabajar."
}

variable "obm_project" {
    type        = string
    default     = "monitorizacionobm"
    description = "El proyecto (obm) en el que vamos a trabajar."
}

variable "topic_name" {
    type        = string
    description = "Nombre descriptivo del cliente en OBM."
}
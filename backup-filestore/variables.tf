variable "project_id" {
    type        = string
    description = "El proyecto en el que vamos a trabajar."
}

variable "region" {
    type        = string
    description = "La región en la que están los recursos."
}

variable "apis" {
    type        = list
    description = "Las apis que necesitamos activar."
    default     = [ "cloudscheduler.googleapis.com", 
                    "cloudfunctions.googleapis.com",
                    "file.googleapis.com" ]
}

variable "instance_zone" {
    type        = string
    description = "La zona en la que está el filestore."
}

variable "instance_name" {
    type        = string
    description = "El nombre de la instancia de filestore."
}

variable "file_share_name" {
    type        = string
    description = "El nombre del file share."
}
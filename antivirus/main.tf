terraform {
  required_providers {
    google = {
        source  = "hashicorp/google"
        version = ">= 4.50.0"
    }
  }
}

provider "google" {
    project = var.project_id
    region  = var.region
}

# Habilitar APIs necesarias
resource "google_project_service" "google_resource_manager_api" {
    service = "cloudresourcemanager.googleapis.com"
}

# Importo el módulo de IAM
module "iam_module" {
  source      = "./modules/iam"
  project_id  = var.project_id
}
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

# Activar las apis necesarias para los backups de filestore
resource "google_project_service" "apis" {
  for_each  = toset(var.apis)
  service   = each.key
}

# Importo el módulo de iam para las service accounts
module "iam" {
  source      = "./modules/iam"

  project_id  = var.project_id
}

# Importo el módulo de cloud functions
module "functions" {
  source                = "./modules/functions"
  
  backupagent_email     = module.iam.backupagent_email
  schedulerunner_email  = module.iam.schedulerunner_email

  project_id            = var.project_id
  region                = var.region
  instance_zone         = var.instance_name
  instance_name         = var.instance_name
  file_share_name       = var.file_share_name
}

# Importo el módulo de cloud scheduler
module "scheduler" {
  source  = "./modules/scheduler"

  schedulerunner_email  = module.iam.schedulerunner_email
  function_uri          = module.functions.fsbackup_uri
}
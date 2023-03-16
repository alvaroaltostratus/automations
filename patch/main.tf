provider "google" {
    project = var.project
    region  = var.region
}

resource "google_project_service" "osconfig_service" {
    service = "osconfig.googleapis.com"
}

resource "google_compute_project_metadata" "project_metadata" {
    metadata = {
        enable-osconfig  = "TRUE"
        enable-guest-attributes = "TRUE"
    }
}

module "windows-patch" {
    source  = "./modules/windows"
    zones   = var.zones
}
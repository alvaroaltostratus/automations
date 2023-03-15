provider "google" {
    project = var.project_id
    region  = var.region
}

module "windows-patch" {
    source  = "./modules/windows"
    zones   = var.zones
}
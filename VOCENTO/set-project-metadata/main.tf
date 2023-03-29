provider "google" {
    project = var.project_id
    region  = var.region
}

resource "google_compute_project_metadata" "project_metadata" {
    metadata = {
        enable-osconfig  = "TRUE"
        enable-guest-attributes = "TRUE"
    }
}
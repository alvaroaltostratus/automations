locals {
  disks  = jsondecode(file("${path.module}/../scripts/disks.json"))
}

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

resource "google_compute_resource_policy" "snapshot_schedule" {
    name = "politica-estandar"
    description = "Backup diario en horario nocturno y con una retención de 15 días."

    snapshot_schedule_policy {
        schedule {
            daily_schedule {
              days_in_cycle = 1
              start_time = "01:00"
            }
        }

        retention_policy {
          max_retention_days = 15
        }

        snapshot_properties {
          guest_flush = true
        }
    }
}

resource "google_compute_disk_resource_policy_attachment" "snapshot_schedule_attachment" {
  for_each  = { for disk in local.disks.disks : disk.name => disk }
  name      = google_compute_resource_policy.snapshot_schedule.name
  disk      = each.value.name
  zone      = each.value.zone
}
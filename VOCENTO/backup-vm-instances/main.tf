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
          max_retention_days = 7
        }

        snapshot_properties {
          guest_flush = true
        }
    }
}

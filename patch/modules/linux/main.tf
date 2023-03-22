resource "google_os_config_patch_deployment" "linux_patch_deployment" {
    patch_deployment_id = "linux-patch-deployment"

    instance_filter {
      zones = var.zones
    }

    patch_config {
        reboot_config = "DEFAULT"

        apt {
            type = "UPGRADE"
        }
    }
    
    recurring_schedule {
        time_of_day {
            hours   = 1
            minutes = 0
        }

        time_zone {
            id = "Europe/Madrid"
        }
        
        monthly {
            week_day_of_month {
                day_of_week = "SUNDAY"
                week_ordinal = 1
            }
        }
    }

    rollout {
        disruption_budget {
            percentage = "25%"
        }
    }
}
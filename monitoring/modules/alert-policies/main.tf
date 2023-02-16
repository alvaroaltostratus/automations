resource "google_monitoring_alert_policy" "disk_policy" {
  alert_strategy {
    auto_close = "604800s"
  }

  combiner = "OR"

  conditions {
    condition_threshold {
      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
      }

      comparison      = "COMPARISON_GT"
      duration        = "0s"
      filter          = "resource.type = \"gce_instance\" AND metric.type = \"agent.googleapis.com/disk/percent_used\" AND metric.labels.state = \"used\""
      threshold_value = "90"

      trigger {
        count   = "1"
        percent = "0"
      }
    }

    display_name = "VM Instance - Disk utilization"
  }

  notification_channels = [ var.notification_channel ]

  display_name          = "alerta-${var.client_project}-disk"
  enabled               = "true"
  project               = var.client_project
}

resource "google_monitoring_alert_policy" "cpu_policy" {
  alert_strategy {
    auto_close = "604800s"
  }

  combiner = "OR"

  conditions {
    condition_threshold {
      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
      }

      comparison      = "COMPARISON_GT"
      duration        = "0s"
      filter          = "resource.type = \"gce_instance\" AND metric.type = \"agent.googleapis.com/cpu/utilization\" AND metric.labels.cpu_state != \"idle\""
      threshold_value = "1"

      trigger {
        count   = "1"
        percent = "0"
      }
    }

    display_name = "VM Instance - CPU utilization"
  }

  notification_channels = [ var.notification_channel ]

  display_name          = "alerta-${var.client_project}-cpu"
  enabled               = "true"
  project               = var.client_project
}

resource "google_monitoring_alert_policy" "memory_policy" {
  alert_strategy {
    auto_close = "604800s"
  }

  combiner = "OR"

  conditions {
    condition_threshold {
      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
      }

      comparison      = "COMPARISON_GT"
      duration        = "0s"
      filter          = "resource.type = \"gce_instance\" AND metric.type = \"agent.googleapis.com/memory/percent_used\" AND metric.labels.state = \"used\""
      threshold_value = "90"

      trigger {
        count   = "1"
        percent = "0"
      }
    }

    display_name = "VM Instance - Memory utilization"
  }

  notification_channels = [ var.notification_channel ]

  display_name          = "alerta-${var.client_project}-memory"
  enabled               = "true"
  project               = var.client_project
}
#"projects/${var.obm_project}/notificationChannels/${var.notification_channel}"
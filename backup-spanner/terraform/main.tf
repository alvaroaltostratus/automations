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

resource "google_pubsub_topic" "cloud_spanner_scheduled_backups" {
    name    = "cloud-spanner-scheduled-backups"
}

resource "google_cloudfunctions_function" "spanner-create-backup" {
    name    = "SpannerCreateBackup"
    runtime = "go113"

    event_trigger {
        event_type  = "providers/cloud.pubsub/eventTypes/topic.publish"
        resource    = google_pubsub_topic.cloud_spanner_scheduled_backups.name
    }
}
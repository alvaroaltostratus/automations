resource "google_pubsub_topic" "topic" {
    project = var.obm_project
    name    = var.topic_name
}

resource "google_pubsub_subscription" "subscription" {
    project                         = var.obm_project
    name                            = "${var.topic_name}-sub"
    topic                           = google_pubsub_topic.topic.name
    ack_deadline_seconds            = 10
    enable_exactly_once_delivery    = false
    enable_message_ordering         = false
    message_retention_duration      = "604800s"
    retain_acked_messages           = false

    expiration_policy {
        ttl = ""
    }

    depends_on = [
      google_pubsub_topic.topic
    ]
}

resource "google_monitoring_notification_channel" "notification" {
    project         = var.client_project
    display_name    = "PubSubOBM"
    type            = "pubsub"

    labels          = {
        "topic": "projects/${google_pubsub_topic.topic.project}/topics/${google_pubsub_topic.topic.name}"
    }

    depends_on = [
        google_pubsub_subscription.subscription
    ]
}

resource "google_pubsub_topic_iam_member" "pubsub_member" {
    project = var.obm_project
    member  = "serviceAccount:service-${var.client_project_number}@gcp-sa-monitoring-notification.iam.gserviceaccount.com"
    role    = "roles/pubsub.publisher"
    topic   = google_pubsub_topic.topic.name
    
    depends_on = [
      google_pubsub_topic.topic
    ]
}

module "alert_policies" {
    source                  = "./modules/alert-policies"
    client_project          = var.client_project
    notification_channel    = google_monitoring_notification_channel.notification.id

    depends_on = [
      google_monitoring_notification_channel.notification
    ]
}

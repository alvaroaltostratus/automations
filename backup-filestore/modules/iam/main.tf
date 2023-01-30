# Crear service account para el cloud scheduler
resource "google_service_account" "schedulerunner" {
    account_id      = "schedulerunner"
    display_name    = "Service Account for FS Backups-Scheduler"
}

# Crear service account para el cloud functions
resource "google_service_account" "backupagent" {
    account_id      = "backupagent"
    display_name    = "Service Account for FS Backups-GCF"
}

# Le doy rol de serviceAgent a la service account del cloud scheduler
resource "google_service_account_iam_binding" "schedulerunner" {
    service_account_id  = google_service_account.schedulerunner.name
    role                = "roles/cloudscheduler.serviceAgent"
    members             = [ "serviceAccount:${google_service_account.schedulerunner.email}" ]
}

# Le doy permiso de file editor a la service account del cloud functions
resource "google_project_iam_binding" "backupagent" {
    project = var.project_id
    role    = "roles/file.editor"
    members = [" serviceAccount:${google_service_account.backupagent.email} "]
}

output "schedulerunner_email" {
    value = google_service_account.schedulerunner.email
}

output "backupagent_email" {
    value = google_service_account.backupagent.email
}
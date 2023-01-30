# Crear el scheduler que ejecuta la cloud function
resource "google_cloud_scheduler_job" "fsbackupschedule" {
    name        = "fsbackupschedule"
    schedule    = "0 22 * * 1-5"

    http_target {
        http_method = "GET"
        uri         = var.function_uri

        oidc_token {
            service_account_email   = var.schedulerunner_email
            audience                = var.function_uri
        }
    }
}

# Crear service account para el antivirus
resource "google_service_account" "antivirus_service_account" {
    display_name    = "Antivirus"
    account_id      = "antivirus"
    description     = "Cuenta para el antivirus de TrendMicro"
}

# Dar el role de compute viewer a la service account del antivirus
resource "google_project_iam_binding" "antivirus_service_account_iam_binding" {
    role    = "roles/compute.viewer"
    project = var.project_id
    members = [ "serviceAccount:${google_service_account.antivirus_service_account.email}" ]
}

# Crear una key de la service account
resource "google_service_account_key" "antivirus_service_account_key" {
    service_account_id  = google_service_account.antivirus_service_account.name
}

# Guardar las credenciales en un fichero 'credentials.json' para usar en la consola de TrendMicro
resource "local_file" "antivirus_service_account_credentials" {
    content     = base64decode(google_service_account_key.antivirus_service_account_key.private_key)
    filename    = "credentials.json"
}

# Creo un zip del source code del backup
data "archive_file" "source" {
    type        = "zip"
    source_dir  = "./src"
    output_path = "/tmp/backup.zip"
}

# Creo un bucket en el que guardar el .zip
resource "google_storage_bucket" "backup_bucket" {
    name     = "${var.project_id}-function"
    location = var.region
}

# Subo el archivo del backup al bucket
resource "google_storage_bucket_object" "zip" {
    source       = data.archive_file.source.output_path
    content_type = "application/zip"

    name         = "src-${data.archive_file.source.output_md5}.zip"
    bucket       = google_storage_bucket.backup_bucket.name

    depends_on   = [
        google_storage_bucket.backup_bucket,
        data.archive_file.source
    ]
}

# Creo la función que ejecuta el backup
resource "google_cloudfunctions_function" "fsbackup" {
    name                    = "fsbackup"
    runtime                 = "python37"

    trigger_http            = true
    entry_point             = "create_backup"

    service_account_email   = var.backupagent_email

    source_archive_bucket = google_storage_bucket.backup_bucket.name
    source_archive_object = google_storage_bucket_object.zip.name

    environment_variables = {
        PROJECT_ID = var.project_id,
        SOURCE_INSTANCE_ZONE = var.instance_zone,
        SOURCE_INSTANCE_NAME = var.instance_name,
        SOURCE_FILE_SHARE_NAME = var.file_share_name,
        BACKUP_REGION = var.region
    }

    depends_on = [
        google_storage_bucket.backup_bucket,
        google_storage_bucket_object
    ]
}

# Le doy rol de invoker a la service account del cloud scheduler
resource "google_cloudfunctions_function_iam_binding" "schedulerunner" {
    project         = var.project_id
    cloud_function  = google_cloudfunctions_function.fsbackup.name
    members         = [ "serviceAccount:${var.schedulerunner_email}" ]
    role            = "roles/cloudfunctions.invoker"
}

output "fsbackup_uri" {
    value   = "https://${google_cloudfunctions_function.fsbackup.region}-${var.project_id}.cloudfunctions.net/${google_cloudfunctions_function.fsbackup.name}"
}

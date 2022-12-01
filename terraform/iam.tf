data "google_iam_role" "data-editor" {
  name = "roles/bigquery.dataEditor"
}

data "google_iam_role" "job-user" {
  name = "roles/bigquery.jobUser"
}

data "google_iam_role" "token-creator" {
  name = "roles/iam.serviceAccountTokenCreator"
}

data "google_iam_role" "storage-viewer" {
  name = "roles/storage.objectViewer"
}

# Dedicated SA for DBT workload
resource "google_service_account" "this" {
  account_id   = "dbt-sa"
  display_name = "DBT Service Account"
  description  = "A Service Account for DBT workload"
}

# Custom role for DBT workload with set of permissions to use BigQuery
resource "google_project_iam_custom_role" "this" {
  role_id = "dbtRole"
  title   = "DBT service account role"
  permissions = setsubtract(
    concat(
      data.google_iam_role.data-editor.included_permissions,
      data.google_iam_role.job-user.included_permissions,
      data.google_iam_role.token-creator.included_permissions,
      data.google_iam_role.storage-viewer.included_permissions
    ),
    ["resourcemanager.projects.list"]
  )
}

# Binding roles to DBT GCP SA
resource "google_project_iam_member" "this" {
  depends_on = [
    google_service_account.this,
    google_project_iam_custom_role.this
  ]
  project = local.project
  role    = google_project_iam_custom_role.this.id
  member  = "serviceAccount:${google_service_account.this.email}"
}

# Binding between GCP SA and K8s SA
resource "google_service_account_iam_binding" "this" {
  depends_on = [
    google_project_iam_member.this
  ]
  service_account_id = google_service_account.this.id
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${local.project}.svc.id.goog[dbt/dbt-sa]"
  ]
}

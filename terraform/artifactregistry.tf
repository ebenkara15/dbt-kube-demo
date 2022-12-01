resource "google_artifact_registry_repository" "this" {
  location      = "europe-west1"
  repository_id = "demo-repo"
  description   = "A Docker repository hosting DBT images"
  format        = "DOCKER"
}

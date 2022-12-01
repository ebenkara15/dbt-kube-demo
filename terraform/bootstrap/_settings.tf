locals {
  services_apis = [
    "iam.googleapis.com",
    "storage.googleapis.com",
    "container.googleapis.com",
    "bigquery.googleapis.com",
    "artifactregistry.googleapis.com"
  ]
}
provider "google" {
  project = "kube-dbt-demo"
  region  = "europe-west1"
}

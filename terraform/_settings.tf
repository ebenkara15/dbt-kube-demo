terraform {
  backend "gcs" {
    bucket = "terraform-kube-dbt-demo"
    prefix = "state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.43.1"
    }
  }
}

locals {
  project = "kube-dbt-demo"
  region  = "europe-west1"
}

provider "google" {
  project = local.project
  region  = local.region
}

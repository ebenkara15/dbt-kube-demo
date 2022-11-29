resource "google_bigquery_dataset" "this" {
  dataset_id  = "dbt_data"
  description = "Dataset holding all DBT generated tables"
  location    = "europe-west1"
}

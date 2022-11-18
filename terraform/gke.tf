resource "google_container_cluster" "this" {
  name = "kube-dbt"

  enable_autopilot = true
}

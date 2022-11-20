resource "google_compute_network" "this" {
  name                    = "demo-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "this" {
  name          = "kube-sn"
  network       = google_compute_network.this.id
  ip_cidr_range = "10.10.10.0/24"

  secondary_ip_range = [
    {
      range_name    = "services"
      ip_cidr_range = "10.10.11.0/24"
    },
    {
      range_name    = "pods"
      ip_cidr_range = "10.1.0.0/20"
    }
  ]

  private_ip_google_access = true
}

resource "google_compute_address" "this" {
  name = "dbt"
}

resource "google_compute_router" "this" {
  name    = "dbt"
  network = google_compute_network.this.id
}

resource "google_compute_router_nat" "this" {
  name                               = "dbt"
  router                             = google_compute_router.this.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.this.self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.this.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  depends_on = [google_compute_address.this]
}

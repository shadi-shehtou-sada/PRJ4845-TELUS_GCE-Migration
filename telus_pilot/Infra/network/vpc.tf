
# Create a VPC network
resource "google_compute_network" "oss_hybrid_vpc" {
  name                            = var.network_name
  project                         = local.project_id
  auto_create_subnetworks         = false # Set to false to manually create subnets
  description                     = "VPC for the hybrid network"
  delete_default_routes_on_create = true
}


# Create a subnetwork
resource "google_compute_subnetwork" "oss_hybrid_subnetwork" {
  name                     = var.oss_hybrid_vpc_1_np_subnets[0].subnet_name
  ip_cidr_range            = var.oss_hybrid_vpc_1_np_subnets[0].subnet_ip
  region                   = var.region
  project                  = local.project_id
  network                  = google_compute_network.oss_hybrid_vpc.id
  private_ip_google_access = var.oss_hybrid_vpc_1_np_subnets[0].subnet_private_access
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

}


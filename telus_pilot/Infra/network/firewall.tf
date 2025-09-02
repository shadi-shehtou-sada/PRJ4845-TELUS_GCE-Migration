/******************************************
 Firewall Rules
 *****************************************/

// Allow SSH via IAP when using the allow-iap-ssh tag for Linux workloads.

resource "google_compute_firewall" "allow_iap_ssh" {
  name        = "fw-${var.network_name}-1000-i-a-all-iap-ssh-tcp-22"
  description = "Allows ingress IAP SSH connections"
  network     = var.network_name
  project     = local.project_id
  direction   = "INGRESS"
  priority    = 1000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  source_ranges = ["35.235.240.0/20"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["allow-iap-ssh"]
}



// Allow RDP via IAP when using the allow-iap-rdp tag for Windows workloads.

resource "google_compute_firewall" "allow_iap_rdp" {
  name        = "fw-${var.network_name}-1000-i-a-all-iap-rdp-tcp-3389"
  description = "Allows ingress IAP RDP connections"
  network     = var.network_name
  project     = local.project_id
  direction   = "INGRESS"
  priority    = 1000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  source_ranges = ["35.235.240.0/20"]


  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  target_tags = ["allow-iap-rdp"]
}


// Allow Ingress traffic from pilot subnet

resource "google_compute_firewall" "allow_pilot_ingress" {
  name        = "fw-${var.network_name}-1000-i-a-env-ingress"
  description = "Allow Ingress traffic from all environment"
  network     = var.network_name
  project     = local.project_id
  direction   = "INGRESS"
  priority    = 1000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "all"
  }


  source_ranges = ["10.32.0.0/28"]

}



// Allow private API access.

# resource "google_compute_firewall" "allow_private_api_egress" {
#   name        = "fw-${local.network_name}-65534-e-a-google-apis-all-tcp-443"
#   description = "Allows egress traffic to private Google APIs"
#   network     = local.network_name
#   project     = local.project_id
#   direction   = "EGRESS"
#   priority    = 65534

#   log_config {
#     metadata = "INCLUDE_ALL_METADATA"
#   }

#   allow {
#     protocol = "tcp"
#     ports    = ["443"]
#   }

#   destination_ranges = [local.private_googleapis_cidr]

#   #target_tags = ["allow-google-apis"]  #optional attribute
# }

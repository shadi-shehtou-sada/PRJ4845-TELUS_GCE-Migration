# Create VPN Gateway
resource "google_compute_ha_vpn_gateway" "vpn_gateway_ha" {
  region  = "northamerica-northeast2"
  name    = "oss-hybrid-vpc-1-vpn-gw"
  project = local.project_id
  network = google_compute_network.oss_hybrid_vpc.id
}

# Create a VPN External Gateway
resource "google_compute_external_vpn_gateway" "vpn_external_gateway_ha" {
  name            = "oss-hybrid-vpc-1-vpn-external-gw"
  project         = local.project_id
  redundancy_type = "TWO_IPS_REDUNDANCY"
  description     = "oss-hybrid-vpc-1-vpn-external-gw"
  interface {
    id         = 0
    ip_address = var.ha_ext_vpn_gateway_ip_1
  }
  interface {
    id         = 1
    ip_address = var.ha_ext_vpn_gateway_ip_2
  }
}

# Create VPN Tunnel 1
resource "google_compute_vpn_tunnel" "vpn_tunnel1_toro_ha" {
  name                            = "vpn-tunnel1-ha"
  project                         = local.project_id
  region                          = var.region
  vpn_gateway                     = google_compute_ha_vpn_gateway.vpn_gateway_ha.id
  peer_external_gateway           = google_compute_external_vpn_gateway.vpn_external_gateway_ha.id
  peer_external_gateway_interface = 0
  shared_secret                   = var.ha_shared_secret
  router                          = google_compute_router.vpn_router_ha_toro.id
  vpn_gateway_interface           = 0
}

# Create VPN Tunnel 2
resource "google_compute_vpn_tunnel" "vpn_tunnel2_toro_ha" {
  name                            = "vpn-tunnel2-ha"
  project                         = local.project_id
  region                          = var.region
  vpn_gateway                     = google_compute_ha_vpn_gateway.vpn_gateway_ha.id
  peer_external_gateway           = google_compute_external_vpn_gateway.vpn_external_gateway_ha.id
  peer_external_gateway_interface = 1
  shared_secret                   = var.ha_shared_secret
  router                          = google_compute_router.vpn_router_ha_toro.id
  vpn_gateway_interface           = 1
}



# Create Cloud Router
resource "google_compute_router" "vpn_router_ha_toro" {
  name    = "oss-toro-ha-vpn-cr-pilot-1"
  project = local.project_id
  network = google_compute_network.oss_hybrid_vpc.id
  region  = var.region
  bgp {
    asn            = var.ha_router_asn
    advertise_mode = "CUSTOM"
    advertised_ip_ranges {
      range = var.ha_bgp_subnets_001
    }
    # advertised_ip_ranges {
    #   range = var.ha_bgp_subnets_002
    # }
    # advertised_ip_ranges {
    #   range = var.ha_bgp_subnets_003
    # }
  }
}


# Create First Cloud Router Interface 
resource "google_compute_router_interface" "vpn_router_interface1_toro_ha" {
  depends_on = [google_compute_router.vpn_router_ha_toro]
  name       = "cloud-router-toro-interface1-ha"
  project    = local.project_id
  router     = google_compute_router.vpn_router_ha_toro.name
  region     = var.region
  ip_range   = var.ha_router_interface1_ip_range
  vpn_tunnel = google_compute_vpn_tunnel.vpn_tunnel1_toro_ha.name
}

# Create First Cloud Router Peer
resource "google_compute_router_peer" "vpn_router_peer1_toro_ha" {
  depends_on                = [google_compute_router.vpn_router_ha_toro]
  name                      = "cloud-router-peer1-toro-ha"
  project                   = local.project_id
  router                    = google_compute_router.vpn_router_ha_toro.name
  region                    = var.region
  peer_ip_address           = var.ha_router_peer1_ip_address
  peer_asn                  = var.ha_peer_asn
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.vpn_router_interface1_toro_ha.name
}

# Create Second Cloud Router Interface
resource "google_compute_router_interface" "vpn_router_interface2_toro_ha" {
  depends_on = [google_compute_router.vpn_router_ha_toro]
  name       = "cloud-router-toro-interface2-ha"
  project    = local.project_id
  router     = google_compute_router.vpn_router_ha_toro.name
  region     = var.region
  ip_range   = var.ha_router_interface2_ip_range
  vpn_tunnel = google_compute_vpn_tunnel.vpn_tunnel2_toro_ha.name
}

# Create Second Cloud Router Peer
resource "google_compute_router_peer" "vpn_router_peer2_toro_ha" {
  depends_on                = [google_compute_router.vpn_router_ha_toro]
  name                      = "cloud-router-peer2-toro-ha"
  project                   = local.project_id
  router                    = google_compute_router.vpn_router_ha_toro.name
  region                    = var.region
  peer_ip_address           = var.ha_router_peer2_ip_address
  peer_asn                  = var.ha_peer_asn
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.vpn_router_interface2_toro_ha.name
}

//**  VPC  **//


## VPC Name ##

network_name = "oss-hybrid-vpc-1-np"

## VPC Subnets ##


oss_hybrid_vpc_1_np_subnets = [
  {
    subnet_name           = "oss-hybrid-subnets-1-np"
    subnet_ip             = "10.32.0.0/28"
    subnet_region         = "northamerica-northeast2"
    subnet_flow_logs      = "true"
    subnet_private_access = "true"
    description           = "oss-hybrid-subnets-1-np"
  }
]

## VPC Routs ##

# oss_hybrid_vpc_1_np_routes = [
# {
#   name              = "rt-vpc-cs-shared-inter-1000-all-default-private-api"
#   description       = "Route through IGW to allow private google api access."
#   destination_range = "199.36.153.8/30"
#   next_hop_internet = "true"
#   priority          = "1000"
# },

# ]



//**  VPN  **//

# CWY VPN Settings

region                        = "northamerica-northeast2"
ha_ext_vpn_gateway_ip_1       = "34.152.69.209" # to be added after the nfv-vpc-1-np VPN GW creation
ha_ext_vpn_gateway_ip_2       = "34.177.65.221" # to be added after the nfv-vpc-1-np VPN GW creation
ha_shared_secret              = ""              # to be added by Telus for security control
ha_router_asn                 = "64513"
ha_peer_asn                   = "65022"
ha_router_interface1_ip_range = "169.254.22.66/30"
ha_router_interface2_ip_range = "169.254.22.82/30"
ha_router_peer1_ip_address    = "169.254.22.65"
ha_router_peer2_ip_address    = "169.254.22.81"

ha_bgp_subnets_001 = "10.32.0.10/32"
# ha_bgp_subnets_002 = "10.32.0.3/32"
# ha_bgp_subnets_003 = "10.32.0.4/32"





//**  VPC  **//


variable "network_name" {
  type        = string
  description = "Network name"
  default     = ""
}

variable "oss_hybrid_vpc_1_np_subnets" {
  type = list(object({
    subnet_name           = string
    subnet_ip             = string
    subnet_region         = string
    subnet_private_access = optional(string)
    subnet_flow_logs      = optional(string)
  description = optional(string) }))
  description = "Subnets"
  default     = []
}


variable "oss_hybrid_vpc_1_np_routes" {
  type        = list(map(string))
  description = "Routes"
  default     = []
}




//**  VPN  **//

variable "region" {
  type        = string
  description = "Region"
  default     = ""
}

variable "ha_ext_vpn_gateway_ip_1" {
  type        = string
  description = "CWY Public IP #1 of the external VPN Gateway"
}

variable "ha_ext_vpn_gateway_ip_2" {
  type        = string
  description = "CWY Public IP #1 of the external VPN Gateway"
}

variable "ha_router_asn" {
  description = "CWY ASN for local side of BGP sessions"
  type        = string
  default     = ""
}

variable "ha_peer_asn" {
  description = "CWY ASN for peer side of BGP sessions"
  type        = string
  default     = ""
}

variable "ha_shared_secret" {
  description = "Tunnel shared secret"
  type        = string
}

variable "ha_router_interface1_ip_range" {
  description = "CWY Router Interface #1 IP Range"
  type        = string
}

variable "ha_router_interface2_ip_range" {
  description = "CWY Router Interface #2 IP Range"
  type        = string
}

variable "ha_router_peer1_ip_address" {
  description = "CWY Router Peer #1 IP Address"
  type        = string
}

variable "ha_router_peer2_ip_address" {
  description = "CWY Router Peer #2 IP Address"
  type        = string
}

variable "ha_bgp_subnets_001" {
  description = "GCP ranges to be advertised over BGP"
  type        = string
}

# variable "ha_bgp_subnets_002" {
#   description = "GCP ranges to be advertised over BGP"
#   type        = string
# }

# variable "ha_bgp_subnets_003" {
#   description = "GCP ranges to be advertised over BGP"
#   type        = string
# }




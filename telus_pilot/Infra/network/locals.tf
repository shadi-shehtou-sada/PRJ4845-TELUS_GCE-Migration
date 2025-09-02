//**  VPC + NAT  **//

locals {
  project_id              = "cto-rcoe-lab-np-366752"
  mtu                     = 1460
  private_googleapis_cidr = "199.36.153.8/30"
}

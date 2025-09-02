
# Create a VM
resource "google_compute_instance" "oss_hybrid_vpc_1_np_test_vm_01" {
  name         = "oss_hybrid_vpc_1_np_test_vm_01"
  machine_type = "n2-standard-2"
  zone         = "northamerica-northeast2-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.oss_hybrid_vpc.id
    subnetwork = google_compute_subnetwork.oss_hybrid_subnetwork.id
    network_ip = "10.32.0.10"
  }
}

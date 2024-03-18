resource "google_compute_instance" "vm-jenkins" {
  name         = "jenkins"
  machine_type = "e2-standard-2"
  zone         = "europe-west3-a"

  tags = ["web"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2204-jammy-v20230612"
    }
  }

#   // Local SSD disk
#   scratch_disk {
#     interface = "SCSI"
#   }

  metadata = {
    ssh-keys = join("\n", [for key in var.ssh_keys : "${key.user}:${key.publickey}"])
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}

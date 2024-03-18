resource "google_container_cluster" "devops-k8s" {
  name               = "devops-k8s"
  location           = "europe-west3-a"
  initial_node_count = 3
  node_config {
    disk_size_gb = "25"
    disk_type = "pd-standard"
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}

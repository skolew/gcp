output "vm-jenkins-public-ip" {
    description = "Public IP of the Jenkins VM"
    value = google_compute_instance.vm-jenkins.network_interface.0.access_config.0.nat_ip
}
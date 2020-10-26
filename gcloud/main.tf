provider "google" {
  project = "sodium-stage-292312"
  region  = "europe-west3"
  zone    = "europe-west3-c"
  credentials = file("My First Project-e35197c62223.json")
}
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance-${count.index + 1}"
  machine_type = "e2-medium"
  count = 2

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20201014"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}
resource "google_compute_network" "vpc_network" {
  name                    = "my-network-158"
  auto_create_subnetworks = "true"
}
resource "google_compute_firewall" "open-tcp" {
  name    = "open-tcp"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "9090"]
  }
}
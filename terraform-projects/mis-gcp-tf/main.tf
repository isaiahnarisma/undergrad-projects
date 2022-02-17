terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("mis484-6_naris.json")
  project = "mis484-prjct" 
  region  = "us-central1"
  zone    = "us-central1-a"
}
resource "google_compute_network" "vpc_network" {
  name = "terraform-dev-network"
}
resource "google_compute_address" "terraform_int" {
  name = "terraform-int-address"
  address_type = "INTERNAL"
}
resource "google_compute_instance" "vm_instance" {
  project = "mis484-prjct"
	name	= "terraform-dev-instance"
	machine_type = "f1-micro"

	boot_disk {
		initialize_params {
			image = "debian-cloud/debian-9"
		}
	}

	network_interface {
		network = google_compute_network.vpc_network.name
		access_config {
		}
	}
}

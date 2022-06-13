provider "google" {
  project     = var.project
  region      = var.region
  credentials = file(var.credentials)
}

data "google_compute_zones" "azs" {
  region = var.region
}

data "google_compute_network" "vpc" {
  name = var.vpc-network
}

data "google_container_engine_versions" "k8s-version" {
  location       = var.region
  version_prefix = var.version-prefix
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.identifier}-subnet"
  region        = var.region
  network       = data.google_compute_network.vpc.name
  ip_cidr_range = var.subnet-cidr
}

# GKE cluster
resource "google_container_cluster" "capg" {
  name               = var.identifier
  location           = var.region
  min_master_version = data.google_container_engine_versions.k8s-version.latest_master_version

  remove_default_node_pool = true
  initial_node_count       = 1
  node_locations           = length(var.zones) > 0 ? var.zones : toset(data.google_compute_zones.azs.names)

  network    = data.google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  dynamic "ip_allocation_policy" {
    for_each = var.vpc-native ? tolist([""]) : tolist([])
    content {

    }
  }
  networking_mode = var.vpc-native ? "VPC_NATIVE" : "ROUTES"

  dynamic "private_cluster_config" {
    for_each = var.private-cluster ? tolist([""]) : tolist([])
    content {
      enable_private_nodes    = var.private-cluster
      enable_private_endpoint = false
    }
  }

}

resource "google_container_node_pool" "capg-wk" {
  name       = "${google_container_cluster.capg.name}-wk"
  location   = var.region
  cluster    = google_container_cluster.capg.name
  node_count = var.num-nodes
  version    = data.google_container_engine_versions.k8s-version.latest_node_version

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    # labels = {
    #   env = var.project
    # }

    # preemptible  = true
    machine_type = var.instance-type
    disk_size_gb = var.disk-size
    tags         = ["kind", "capg"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

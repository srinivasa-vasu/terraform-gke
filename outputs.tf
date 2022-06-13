output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project
  description = "GCloud Project ID"
}

output "k8s_cluster_name" {
  value       = google_container_cluster.capg.name
  description = "GKE Cluster Name"
}

output "k8s_cluster_host" {
  value       = google_container_cluster.capg.endpoint
  description = "GKE Cluster Host"
}

output "k8s_master_version" {
  value = data.google_container_engine_versions.k8s-version.latest_master_version
}

output "k8s_node_version" {
  value = data.google_container_engine_versions.k8s-version.latest_node_version
}

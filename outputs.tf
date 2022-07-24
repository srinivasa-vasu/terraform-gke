output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project
  description = "GCloud Project ID"
}

output "k8s_cluster_info" {
  value = [
    for cluster in google_container_cluster.capg :
    {
      "name"     = cluster.name,
      "endpoint" = cluster.endpoint,
      "context"  = "gcloud container clusters get-credentials ${cluster.name} --region ${var.region} --project ${var.project}"
    }
  ]
}

output "k8s_master_version" {
  value = data.google_container_engine_versions.k8s-version.latest_master_version
}

output "k8s_node_version" {
  value = data.google_container_engine_versions.k8s-version.latest_node_version
}

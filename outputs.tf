output "k8s_external_endpoint" {
  value       = yandex_kubernetes_cluster.this.master[0].external_v4_endpoint
  description = "External address of k8s endpoint"
}

output "k8s_cluster_id" {
  value       = yandex_kubernetes_cluster.this.id
  description = "ID of the k8s cluster"
}

output "k8s_kubectl_config" {
  value       = local.kubectl_config
  description = "Generate config to connect k8s cluster"
}

output "psql_fqdn" {
  value       = flatten(yandex_mdb_postgresql_cluster.this.host.*.fqdn)
  description = "PostgreSQL domain names"
}

output "redis_fqdn" {
  value       = flatten(yandex_mdb_redis_cluster.this.host.*.fqdn)
  description = "Redis domain names"
}

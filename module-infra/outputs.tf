output "k3d_cluster_info" {
  value = local_exec.create_k3d_cluster.stdout
}

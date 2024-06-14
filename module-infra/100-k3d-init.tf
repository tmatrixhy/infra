resource "local_exec" "create_k3d_cluster" {
  command = "${path.module}/scripts/create-k3d-cluster.sh"
}

resource "local_file" "certs" {
  content = file("${path.module}/scripts/certificates/ca.crt")
  filename = "${path.module}/certs/ca.crt"
}

resource "local_exec" "generate_certs" {
  command = "${path.module}/scripts/generate-certs.sh"
  depends_on = [local_exec.create_k3d_cluster]
}

output "ca_cert" {
  value = file("${path.module}/certs/ca.crt")
}

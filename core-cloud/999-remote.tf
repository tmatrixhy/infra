resource "null_resource" "bootstrap_tailscale" {
  #
  # install tailscale and bring it up
  # 

  depends_on = [ null_resource.update_bashrc ]
  
  count = var.ssh_private_key_path != "" ? 1 : 0

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("${var.ssh_private_key_path}/${random_id.key.hex}")
    host        = digitalocean_droplet.primary_server.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "attempt=0",
      "until [ $attempt -ge 3 ]; do",
      "  curl -fsSL https://tailscale.com/install.sh | sh && break",
      "  attempt=$((attempt + 1))",
      "  sleep 15",
      "done",
      "if [ $attempt -lt 3 ]; then",
      "  tailscale up --authkey=${tailscale_tailnet_key.primary_server.key}",
      "else",
      "  echo 'Failed to install Tailscale after 3 attempts' >&2",
      "  exit 1",
      "fi"
    ]
  }
} 

resource "null_resource" "bootstrap_script" {
  # 
  # run bootstrap script and cleanup
  # 

  depends_on = [ null_resource.bootstrap_tailscale ]
  count = var.ssh_private_key_path != "" ? 1 : 0

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("${var.ssh_private_key_path}/${random_id.key.hex}")
    host        = digitalocean_droplet.primary_server.ipv4_address
  }
  
  provisioner "file" {
    source      = var.bootstrap_script
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "attempt=0",
      "until [ $attempt -ge 3 ]; do",
      "  /tmp/bootstrap.sh && break",
      "  attempt=$((attempt + 1))",
      "  sleep 15",
      "done",
      "rm -rf /tmp/bootstrap.sh"
    ]
  }
}

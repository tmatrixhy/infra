
resource "null_resource" "bootstrap_tailscale" {
  depends_on = [ digitalocean_droplet.primary_server, 
                tailscale_tailnet_key.primary_server ]
  count = var.ssh_private_key_path != "" ? 1 : 0

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("${var.ssh_private_key_path}/${random_id.key.hex}")
    host        = local.full_domain_name
  }

  provisioner "remote-exec" {
    inline = [
      "curl -fsSL https://tailscale.com/install.sh | sh",
      "tailscale up --authkey=${tailscale_tailnet_key.primary_server.key}"
    ]
  }
} 

resource "null_resource" "bootstrap_script" {
  depends_on = [ digitalocean_droplet.primary_server, 
                tailscale_tailnet_key.primary_server,
                null_resource.bootstrap_tailscale ]
  count = var.ssh_private_key_path != "" ? 1 : 0

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("${var.ssh_private_key_path}/${random_id.key.hex}")
    host        = local.full_domain_name
  }
  
  provisioner "file" {
    source      = var.bootstrap_script
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "for i in {1..3}; do /tmp/bootstrap.sh && break || sleep 15; done",
      "rm -rf /tmp/bootstrap.sh"
    ]
  }
}

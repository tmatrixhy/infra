resource "digitalocean_ssh_key" "generated_key" {
  name       = random_id.key.hex
  public_key = file("${var.ssh_private_key_path}/${random_id.key.hex}.pub")

  depends_on = [null_resource.generate_ssh_key]
}

resource "digitalocean_droplet" "primary_server" {
  name   = var.droplet_name
  size   = var.droplet_size
  image  = var.droplet_image
  region = var.droplet_region

  # The VPC UUID, if needed
  #vpc_uuid = var.droplet_vpc

  # Enable monitoring
  monitoring = true

  # Add SSH keys
  ssh_keys = concat(
    [ digitalocean_ssh_key.generated_key.fingerprint ],
    var.additional_droplet_ssh_keys
  )              
}

resource "null_resource" "run_remote_commands" {
  depends_on = [ digitalocean_droplet.primary_server, 
                tailscale_tailnet_key.primary_server ]
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
      "curl -fsSL https://tailscale.com/install.sh | sh",
      "tailscale up --authkey=${tailscale_tailnet_key.primary_server.key}",
      "chmod +x /tmp/bootstrap.sh",
      "for i in {1..3}; do /tmp/bootstrap.sh && break || sleep 15; done"
    ]
  }
}

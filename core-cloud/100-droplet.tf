resource "digitalocean_ssh_key" "generated_key" {
  name       = random_id.ssh_key_name.hex
  public_key = file("${var.ssh_private_key_path}/${random_id.ssh_key_name.hex}.pub")

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
  ssh_keys = var.droplet_ssh_keys
}

resource "null_resource" "wait_for_instance" {
  depends_on = [ digitalocean_droplet.primary_server ]
  provisioner "local-exec" {
    command = "sleep 30"
  }
}

resource "null_resource" "run_remote_commands" {
  depends_on = [null_resource.wait_for_instance]
  count = var.ssh_private_key_path != "" ? 1 : 0

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.ssh_private_key_path)
    host        = local.full_domain_name
  }
  
  provisioner "file" {
    source      = var.bootstrap_script
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "/tmp/bootstrap.sh"
    ]
  }
}

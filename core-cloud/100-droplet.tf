resource "digitalocean_ssh_key" "generated_key" {
  name       = random_id.key.hex
  public_key = file("${var.ssh_private_key_path}/${random_id.key.hex}.pub")

  depends_on = [null_resource.generate_ssh_key]
}

resource "digitalocean_droplet" "primary_server" {
  depends_on = [ null_resource.delete_ssh_key ]
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

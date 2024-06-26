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

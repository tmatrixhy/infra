resource "tailscale_tailnet_key" "primary_server" {
  #
  # generate tailscale key to use for droplet
  #

  reusable      = true
  ephemeral     = false
  preauthorized = true
  description   = "Key for Digital Ocean Primary K3S Server"
}

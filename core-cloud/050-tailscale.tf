resource "tailscale_tailnet_key" "primary_server" {
  reusable      = true
  ephemeral     = false
  preauthorized = true
  description   = "Key for Digital Ocean Primary K3S Server"
}

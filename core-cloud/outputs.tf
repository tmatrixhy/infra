output "droplet_ip" {
  description = "The public IP address of the DigitalOcean droplet."
  value       = digitalocean_droplet.primary_server.ipv4_address
}

output "dns_record_name" {
  description = "The DNS record name generated for Cloudflare."
  value       = local.subdomain_name
}

output "dns_full_record_name" {
  description = "The full domain record name generated for Cloudflare."
  value       = local.full_domain_name
}

output "tailscale_auth_key" {
  value       = tailscale_tailnet_key.primary_server.key
  description = "Tailscale authentication key for primary k3s server"
  sensitive   = true
}

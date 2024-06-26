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

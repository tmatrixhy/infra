resource "random_id" "dns_name" {
  byte_length = 8
}

locals {
  subdomain_name   = var.cloudflare_subdomain != "" ? var.cloudflare_subdomain : random_id.dns_name.hex
  full_domain_name = "${local.subdomain_name}.${var.static_domain}"
}

resource "cloudflare_record" "primarydomain" {
  depends_on = [ digitalocean_droplet.primary_server ]
  zone_id = var.cloudflare_zone_id
  name    = local.subdomain_name
  value   = digitalocean_droplet.primary_server.ipv4_address
  type    = "A"
  ttl     = 1
  proxied = var.cloudflare_domain_proxy
}

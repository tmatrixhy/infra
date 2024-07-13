resource "random_id" "key" {
  #
  # random hash
  #

  byte_length = 8
}

locals {
  #
  # create full domain name
  #

  subdomain_name   = var.cloudflare_subdomain != "" ? var.cloudflare_subdomain : random_id.key.hex
  full_domain_name = "${local.subdomain_name}.${var.static_domain}"
}

resource "cloudflare_record" "primarydomain" {
  #
  # point cloudflare managed domain to droplet IP address
  # eg <hash>.<domain.com> -> xxx.xxx.xxx.xxx
  #

  depends_on = [ digitalocean_droplet.primary_server ]
  zone_id = data.hcp_vault_secrets_secret.cloudflare_zone_id.secret_value
  name    = local.subdomain_name
  value   = digitalocean_droplet.primary_server.ipv4_address
  type    = "A"
  ttl     = 1
  proxied = var.cloudflare_domain_proxy
}

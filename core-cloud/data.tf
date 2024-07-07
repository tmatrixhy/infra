data "hcp_vault_secrets_secret" "digitalocean" {
  app_name    = var.HCP_APP_NAME
  secret_name = "digitalocean_token"
}

data "hcp_vault_secrets_secret" "cloudflare" {
  app_name    = var.HCP_APP_NAME
  secret_name = "cloudflare_token"
}

data "hcp_vault_secrets_secret" "cloudflare_zone_id" {
  app_name    = var.HCP_APP_NAME
  secret_name = "cloudflare_zone_id"
}

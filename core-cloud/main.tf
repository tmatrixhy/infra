terraform {
    required_providers {
        helm = {
            source = "hashicorp/helm"
            version = ">= 2.0.0"
        }

        kubernetes = {
            source = "hashicorp/kubernetes"
            version = ">= 2.0.0"
        }
        digitalocean = {
          source  = "digitalocean/digitalocean"
          version = "~> 2.0"
        }
        cloudflare = {
          source  = "cloudflare/cloudflare"
          version = "~> 4.0"
        }
        hcp = {
          source  = "hashicorp/hcp"
          version = "~> 0.94.0"
        }
        tailscale = {
          source = "tailscale/tailscale"
          version = "0.16.1"
        }
    }
    required_version = ">= 1.0"
}

provider "kubernetes" {
    config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "digitalocean" {
  token = data.hcp_vault_secrets_secret.digitalocean.secret_value
}

provider "cloudflare" {
  api_token = data.hcp_vault_secrets_secret.cloudflare.secret_value
}

provider "tailscale" {
  api_key = data.hcp_vault_secrets_secret.tailscale.secret_value
}

provider "hcp" {
  client_id = var.HCP_CLIENT_ID
  client_secret = var.HCP_CLIENT_SECRET
}

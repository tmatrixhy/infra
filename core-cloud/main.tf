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
  token = var.digitalocean_token
}

provider "cloudflare" {
  #email     = var.cloudflare_email
  api_token = var.cloudflare_api_token
}

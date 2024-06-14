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

module "infra" {
    source = "./module-infra"
}

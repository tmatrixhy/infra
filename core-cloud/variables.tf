variable "HCP_CLIENT_ID" {
  description = "HCP Service Principal Client ID"
  type        = string
  default     = "$HCP_CLIENT_ID"
}

variable "HCP_CLIENT_SECRET" {
  description = "HCP Service Principal Client Secret"
  type        = string
  default     = "$HCP_CLIENT_SECRET"
}

variable "HCP_APP_NAME" {
  description = "HCP Vault Secrets application name"
  type        = string
  default     = "$HCP_APP_NAME"
}

variable "droplet_name" {
  description = "Name of the droplet -- No Spaces"
  type        = string
}

variable "droplet_size" {
  description = "The slug identifier for the size that you wish to select for this Droplet."
  type        = string
}

variable "droplet_image" {
  description = "base image to use for droplet - can be an integer or string EG: 158062325 or docker-20-04"
  type        = any
}

variable "droplet_region" {
  description = "region close to you for deployment"
  type        = string
}

variable "droplet_vpc" {
  description = "VPC ID if you want it"
  type        = string
  default     = ""
}

variable "cloudflare_subdomain" {
  description = "Subdomain to be added for dns record"
  type        = string
  default     = ""
}

variable "cloudflare_domain_proxy" {
  description = "Whether to proxy all traffic through Cloudflare"
  type        = bool
  default     = false
}

variable "static_domain" {
  description = "The static domain to append to the DNS record name."
  type        = string
  default     = "example.com"
}

variable "alias_for_droplet_ssh" {
  description = "Update the ~/.bashrc file with an alias to SSH to droplet"
  type        = string
}

variable "ssh_private_key_path" {
  description = "The directory to save the SSH key pair."
  type        = string
}

variable "bootstrap_script" {
  description = "The script to bootstrap the droplet instance"
  type        = string
}

variable "additional_droplet_ssh_keys" {
  description = "A list of additional SSH key fingerprints to add to the droplet."
  type        = list(string)
  default     = []
}

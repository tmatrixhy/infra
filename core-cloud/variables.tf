variable "digitalocean_token" {
  description = "The token for DigitalOcean API."
  type        = string
}

variable "droplet_ssh_keys" {
  description = "A list of SSH key fingerprints to add to the droplet."
  type        = list(string)
  default     = []
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

variable "cloudflare_email" {
  description = "The email associated with your Cloudflare account."
  type        = string
}

variable "cloudflare_api_token" {
  description = "The API token for Cloudflare."
  type        = string
}

variable "cloudflare_zone_id" {
  description = "The Zone ID for Cloudflare."
  type        = string
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

variable "update_bashrc" {
  description = "Whether to update the ~/.bashrc file with the new alias."
  type        = bool
  default     = false
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key file for accessing the droplet."
  type        = string
}

variable "bootstrap_script" {
  description = "The script to bootstrap the droplet instance"
  type        = string
}

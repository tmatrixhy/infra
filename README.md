# infra

This repository contains various infrastructure "<span style="color:red">experiments</span>".

## `./core-cloud`

This folder provides IaC (Infra-as-Code) to 
1. Create a Digital Ocean droplet  
2. map the public IPv4 address from `1` to a dns entry for a known host in cloudflare

Requirements: 

* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [Digital Ocean Account](https://m.do.co/c/05f6cbbc106b)
* [Cloudflare](https://www.cloudflare.com/) managed DNS record

Usage:

* create a `private.tfvars` file following the template in `./core-cloud/cloud.tfvars.sample`

```
cd ./core-cloud
terraform init
terraform apply --var-file=<your-private-var-file> 
```

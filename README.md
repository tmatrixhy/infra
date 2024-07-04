# infra

This repository contains various infrastructure "<span style="color:red">experiments</span>".

## `./core-cloud`

This folder provides IaC (Infra-as-Code) to 
1. Create a Digital Ocean droplet  
2. Maps the public IPv4 address from `1` to a dns entry for a known host in cloudflare
3. Bootstrap's the droplet with a provided bash script, example in `./droplet-bootstrap.sh`.
4. Bootstrap's your local `~/.bashrc` with an alias `do-root` to ssh to the droplet as root.

**Properly read and configure your variables file. A sample is provided in `./core-cloud/cloud.tfvars.sample`**

Requirements: 

* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [Digital Ocean Account](https://m.do.co/c/05f6cbbc106b)
* [Cloudflare](https://www.cloudflare.com/) managed DNS record

Installation / Usage:

* create a `private.tfvars` file following the template in `./core-cloud/cloud.tfvars.sample`

```
cd ./core-cloud
terraform init
terraform apply --var-file=<your-private-var-file> 
```

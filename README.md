# infra

This repository contains various infrastructure "<span style="color:red">experiments</span>".

- [infra](#infra)
  - [`./core-cloud`](#core-cloud)
    - [Requirements:](#requirements)
    - [Installation / Usage:](#installation--usage)


## `./core-cloud`

This folder provides IaC (Infra-as-Code) to 
1. Generate an SSH key.
2. Create a Digital Ocean droplet  
3. Maps the public IPv4 address from `2` to a dns entry for a known host in cloudflare
4. <span style="color:green">(optional)</span> Bootstrap's the droplet with a provided bash script, example in `./droplet-bootstrap.sh`.
5. <span style="color:green">(optional)</span> Bootstrap's your local `~/.bashrc` with an alias to ssh to the droplet as root using the auto-generated SSH key in `1`.

**Properly read and configure your variables file. A sample is provided in `./core-cloud/cloud.tfvars.sample`**


### Requirements: 

* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [Digital Ocean Account](https://m.do.co/c/05f6cbbc106b)
* [Cloudflare](https://www.cloudflare.com/) managed DNS record

### Installation / Usage:

* create a `private.tfvars` file following the template in `./core-cloud/cloud.tfvars.sample`

```
cd ./core-cloud
terraform init
terraform apply --var-file=<your-private-var-file> && source ~/.bashrc
```

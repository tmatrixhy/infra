# infra

This repository contains various infrastructure "<span style="color:red">experiments</span>".

- [infra](#infra)
  - [`./core-cloud`](#core-cloud)
    - [Requirements:](#requirements)
    - [Installation / Usage:](#installation--usage)
    - [Uninstall / Delete:](#uninstall--delete)


## `./core-cloud`

This folder provides IaC (Infra-as-Code) to 
1. Generate an SSH key.
2. Create a Digital Ocean droplet
3. Maps the public IPv4 address from `2` to a dns entry for a known host in cloudflare
4. <span style="color:green">(optional)</span> Bootstrap's the droplet with a provided bash script, example in `./droplet-bootstrap.sh`.
5. <span style="color:green">(optional)</span> Bootstrap's your local `~/.bashrc` with an alias to ssh to the droplet as root using the auto-generated SSH key in `1`.

**Properly read and configure your variables files. Samples are provided in `./core-cloud/cloud.tfvars.sample` & `./core-cloud/.env.sample`**


### Requirements: 

* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [Hashicorp Secrets Vault](https://www.hashicorp.com/products/vault)
* [Digital Ocean Account](https://m.do.co/c/05f6cbbc106b)
* [Cloudflare](https://www.cloudflare.com/) managed DNS record

### Installation / Usage:

1. Create the following: Hashicorp account -> org -> project -> vault secrets app (example name: `primary-cluster`).
2. Load the following secret `key`s with the appropriate values in the app from `1`: `cloudflare_token` `cloudflare_zone_id` & `digitalocean_token`
3. [Create a project level service principal](https://developer.hashicorp.com/hcp/docs/hcp/admin/iam/service-principals#project-level-service-principals-1) for the vault secrets app you created and load the values in a .env file as shown in `./core-cloud/.env.sample`. 
4. Create a `private.tfvars` file following the template in `./core-cloud/cloud.tfvars.sample`.

```
cd ./core-cloud
terraform init
source <your-.env-file> && terraform apply --var-file=<your-private-var-file> && source ~/.bashrc
```

### Uninstall / Delete:

```
cd ./core-cloud
source <your-.env-file> && terraform destroy --var-file=<your-private-var-file>
```

# infra

This repository contains various infrastructure "<span style="color:red">experiments</span>".

- [infra](#infra)
  - [`./core-cloud`](#core-cloud)
    - [Requirements:](#requirements)
    - [Installation / Usage:](#installation--usage)
    - [Uninstall / Delete:](#uninstall--delete)
    - [WSL \& Tailscale](#wsl--tailscale)


## `./core-cloud`

This folder provides IaC (Infra-as-Code) to 
1. Generate an SSH key.
2. Create a Digital Ocean droplet
3. Maps the public IPv4 address from `2` to a dns entry for a known host in cloudflare
4. <span style="color:green">(optional)</span> Bootstrap's the droplet with `tailscale` for private VPN.
5. <span style="color:green">(optional)</span> Bootstrap's the droplet with a provided bash script, example in `./droplet-bootstrap.sh`.
6. <span style="color:green">(optional)</span> Bootstrap's your local `~/.bashrc` with an alias to ssh to the droplet as root using the auto-generated SSH key in `1`.

**Properly read and configure your variables files. Samples are provided in `./core-cloud/cloud.tfvars.sample` & `./core-cloud/.env.sample`**


### Requirements: 

* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) - IAC
* [Hashicorp Vault Secrets](https://www.hashicorp.com/products/vault) - Secure Secrets Storage
* [Tailscale](https://tailscale.com/) - Virtual Private LAN
* [Digital Ocean Account](https://m.do.co/c/05f6cbbc106b) - Cloud Servers
* [Cloudflare](https://www.cloudflare.com/) - Managed DNS record

### Installation / Usage:

1. Create the following: Hashicorp account -> org -> project -> vault secrets app (example name: `primary-cluster`).
2. Load the following secret `key`s with the appropriate values in the app from `1`: 
   1. `cloudflare_token`    - https://developers.cloudflare.com/fundamentals/api/get-started/create-token/
   2. `cloudflare_zone_id`  - https://developers.cloudflare.com/fundamentals/setup/find-account-and-zone-ids/
   3. `digitalocean_token`  - https://docs.digitalocean.com/reference/api/create-personal-access-token/
   4. `tailscale_api_key`   - https://tailscale.com/kb/1101/api
3. [Create a project level service principal](https://developer.hashicorp.com/hcp/docs/hcp/admin/iam/service-principals#project-level-service-principals-1) for the vault secrets app you created and load the values in a `.env` file as shown in `./core-cloud/.env.sample`. 
4. Create a `private.tfvars` file following the template in `./core-cloud/cloud.tfvars.sample`.

```
cd ./core-cloud
terraform init
source <your-.env-file> && terraform apply --var-file=<your-private-var-file> && source ~/.bashrc
# or configure the Makefile appropriately
```

### Uninstall / Delete:

```
cd ./core-cloud
source <your-.env-file> && terraform destroy --var-file=<your-private-var-file>
# or configure the Makefile appropriately
```

### WSL & Tailscale

Tailscale seems to affect WSL if installed locally and DNS resolution fails to work. To resolve this:

From WSL:

```
sudo nano /etc/wsl.conf
```
Ensure these two lines do not exist:
```/etc/wsl.conf
[network]
generateResolvConf = true (or false)
```
Execute the following:
```
sudo rm /etc/resolv.conf
sudo nano /etc/resolv.conf
# add the following line // feel free to add other nameservers such as the cloudflare ns
nameserver 8.8.8.8
```
Save the file, exit the editor, and wsl.

From Powershell:

```
wsl --shutdown
```

Restart WSL and you should be all set.

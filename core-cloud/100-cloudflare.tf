resource "random_id" "dns_name" {
  byte_length = 8
}

locals {
  subdomain_name   = var.cloudflare_subdomain != "" ? var.cloudflare_subdomain : random_id.dns_name.hex
  full_domain_name = "${local.subdomain_name}.${var.static_domain}"
}

resource "cloudflare_record" "primarydomain" {
  depends_on = [ digitalocean_droplet.primary_server ]
  zone_id = var.cloudflare_zone_id
  name    = local.subdomain_name
  value   = digitalocean_droplet.primary_server.ipv4_address
  type    = "A"
  ttl     = 1
  proxied = var.cloudflare_domain_proxy
}

resource "null_resource" "wait_for_instance" {
  depends_on = [ cloudflare_record.primarydomain ]
  provisioner "local-exec" {
    command = "sleep 30"
  }
}

resource "null_resource" "run_remote_commands" {
  depends_on = [null_resource.wait_for_instance]
  count = var.ssh_private_key_path != "" ? 1 : 0

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.ssh_private_key_path)
    host        = local.full_domain_name
  }
  
  provisioner "file" {
    source      = var.bootstrap_script
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "/tmp/bootstrap.sh"
    ]
  }
}

resource "null_resource" "update_bashrc" {
  depends_on = [ local.full_domain_name, 
                cloudflare_record.primarydomain ]
  count = var.update_bashrc ? 1 : 0

  provisioner "local-exec" {
    command = <<EOT
      sed -i '/alias do-root=/d' ~/.bashrc
      echo 'alias do-root="ssh -i ~/.ssh/do-droplet root@${local.full_domain_name}"' >> ~/.bashrc
    EOT
  }
}

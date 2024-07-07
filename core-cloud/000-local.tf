resource "null_resource" "generate_ssh_key" {
  provisioner "local-exec" {
    command = <<EOT
      ssh-keygen -t rsa -b 4096 -f ${var.ssh_private_key_path}/${random_id.key.hex} -N ''
    EOT
  }
}

resource "null_resource" "update_bashrc" {
  depends_on = [ local.full_domain_name, 
                cloudflare_record.primarydomain ]
  count = var.alias_for_droplet_ssh != "" ? 1 : 0

  provisioner "local-exec" {
    command = <<EOT
      sed -i '/alias ${var.alias_for_droplet_ssh}=/d' ~/.bashrc
      echo 'alias ${var.alias_for_droplet_ssh}="ssh -i ${var.ssh_private_key_path}/${random_id.key.hex} root@${local.full_domain_name}"' >> ~/.bashrc
    EOT
  }
}

resource "null_resource" "delete_ssh_key" {
  depends_on = [digitalocean_ssh_key.generated_key]

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      rm -f ${self.triggers.ssh_key_path} ${self.triggers.ssh_key_path}.pub
    EOT
  }

  triggers = {
    ssh_key_path = "${var.ssh_private_key_path}/${random_id.key.hex}"
  }
}

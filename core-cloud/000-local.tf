resource "null_resource" "generate_ssh_key" {
  provisioner "local-exec" {
    command = <<EOT
      ssh-keygen -t rsa -b 2048 -f ${var.ssh_private_key_path}/${random_id.ssh_key_name.hex} -N ''
    EOT
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

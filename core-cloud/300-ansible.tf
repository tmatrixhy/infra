resource "null_resource" "update_ansible_inventory" {
  provisioner "local-exec" {
    command = <<EOT
      # Ensure the hosts file exists
      touch ../ansible/hosts

      # Remove the existing droplet block if it exists
      sed -i '/^\[${var.droplet_name}\]/,/^$/d' ../ansible/hosts

      cat <<EOF >> ../ansible/hosts
[${var.droplet_name}]
${local.full_domain_name} ansible_user=root ansible_ssh_private_key_file=${var.ssh_private_key_path}/${random_id.key.hex}
EOF
    EOT
  }
  
  triggers = {
    always_run = "${timestamp()}"
  }
  
  depends_on = [cloudflare_record.primarydomain]
}

resource "null_resource" "update_ansible_playbook" {
  provisioner "local-exec" {
    command = <<EOT
      # Remove the existing droplet block if it exists
      if grep -q "${var.droplet_name}" ../ansible/playbook.yml; then
        sed -i '/- hosts: ${var.droplet_name}/,/^\s*$/d' ../ansible/playbook.yml
      fi
      
      cat <<EOF >> ../ansible/playbook.yml
- hosts: ${var.droplet_name}
  tasks:
    - name: Echo server name and save to a file
      shell: echo "{{ ansible_host }}" > ~/server_name.txt
EOF
    EOT
  }

  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [null_resource.update_ansible_inventory]
}

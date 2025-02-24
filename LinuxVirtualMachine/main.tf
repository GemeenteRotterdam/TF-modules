resource "azurerm_network_security_group" "example" {
  name                = var.NSG_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.vm_name}-nic-ipconfig"
    subnet_id                     = data.azurerm_subnet.snet.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
  
  depends_on = [azurerm_network_security_group.example]
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.example.id
  depends_on                = [azurerm_network_interface.main]
} 

resource "azurerm_linux_virtual_machine" "example" {
  name                       = var.vm_name
  resource_group_name        = data.azurerm_resource_group.rg.name
  location                   = data.azurerm_resource_group.rg.location
  size                       = var.vm_size
  admin_username             = var.admin_username
  network_interface_ids      = [azurerm_network_interface.main.id]
  secure_boot_enabled        = var.secure_boot_enabled
  //source_image_id            = var.source_image_id
  patch_mode                 = var.patch_mode
  patch_assessment_mode      = var.patch_assessment_mode
  encryption_at_host_enabled = var.encryption_at_host_enabled
  computer_name              = var.vm_name 

   source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "94_gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = data.azurerm_ssh_public_key.ssh.public_key
  }
  os_disk {
    caching                = var.caching_os_disk
    storage_account_type   = var.storage_account_type_os_disk
    disk_size_gb           = var.disk_size_os_disk 
    disk_encryption_set_id = var.disk_encryption_set_id
  }

   lifecycle {
    ignore_changes = [identity, tags]
  }

  tags = var.tags

  depends_on = [azurerm_network_interface_security_group_association.example]
}

# resource "azurerm_virtual_machine_run_command" "domain_join" {
#   name               = "DomainJoin"
#   virtual_machine_id = azurerm_linux_virtual_machine.example.id
#   location           = azurerm_linux_virtual_machine.example.location
#   source {
#   script = <<EOF
  

#   EOF
#   }
#   depends_on = [azurerm_linux_virtual_machine.example]

#   lifecycle {
#     ignore_changes = [tags]
#   }
# }

# resource "azurerm_virtual_machine_extension" "domain_join" {
#   name                  = "DomainJoin"
#   virtual_machine_id    = azurerm_linux_virtual_machine.example.id
#   publisher             = "Microsoft.Azure.Extensions"
#   type                  = "CustomScript"
#   type_handler_version  = "2.1"

#   settings = jsonencode({
#     commandToExecute = <<-EOT
#       sudo dnf upgrade --refresh -y && sudo dnf install -y realmd sssd adcli krb5-workstation samba-common-tools oddjob oddjob-mkhomedir && 
#       echo '${var.domain_join_password}' | sudo realm join --user=${var.domain_join_user} --computer-ou=${var.OU_path} ${var.domain_name} && 
#       sudo systemctl enable sssd && sudo systemctl start sssd && 
#       sudo realm permit --all && sudo authselect select sssd with-mkhomedir --force && 
#       sudo systemctl restart sshd
#     EOT
#   })

#   lifecycle {
#     ignore_changes = [tags]
#   }
# }


# resource "azurerm_virtual_machine_extension" "domain_join" {
#   name                  = "DomainJoin"
#   virtual_machine_id    = azurerm_linux_virtual_machine.example.id
#   publisher             = "Microsoft.Azure.Extensions"
#   type                  = "CustomScript"
#   type_handler_version  = "2.1"

#   settings = jsonencode({
#     commandToExecute = "sudo dnf upgrade --refresh -y && sudo dnf install -y realmd sssd adcli krb5-workstation samba-common-tools oddjob oddjob-mkhomedir && echo ${var.domain_join_password} | sudo realm join --user=${var.domain_join_user} --computer-ou=${var.OU_path} ${var.domain_name} && sudo systemctl enable sssd && sudo systemctl start sssd && sudo realm permit --all && sudo authselect select sssd with-mkhomedir --force && sudo systemctl restart sshd"
#   })

#   lifecycle {
#     ignore_changes = [tags]
#   }
# }




# resource "azurerm_virtual_machine_extension" "domain_join" {
#   name                  = "DomainJoin"
#   virtual_machine_id    = azurerm_linux_virtual_machine.example.id
#   publisher             = "Microsoft.Azure.Extensions"
#   type                  = "CustomScript"
#   type_handler_version  = "2.1"

#   settings = <<SETTINGS
#   {
#   "commandToExecute": "sudo dnf upgrade --refresh -y && sudo dnf install -y realmd sssd adcli krb5-workstation samba-common-tools oddjob oddjob-mkhomedir && echo ${var.domain_join_password} | sudo realm join --user=${var.domain_join_user} --computer-ou=${var.OU_path} ${var.domain_name} && sudo systemctl enable sssd && sudo systemctl start sssd && sudo realm permit --all && sudo authselect select sssd with-mkhomedir --force && sudo systemctl restart sshd"
#   }
#   SETTINGS

#   lifecycle {
#     ignore_changes = [tags]
#   }
# }

#   settings = jsonencode({
#     Name        = "rotterdam.local"
#     User        = "rotterdam\\SA_SRV_TERRAFORM_DJ"
#     Restart     = "true"
#     Options     = 3
#     OUPath      = var.OU_path
#   })

#   protected_settings = jsonencode({
#     Password = "ufpIBoYRXUNjkFo<>"
#   })
#   depends_on = [azurerm_linux_virtual_machine.example]

# resource "azurerm_virtual_machine_run_command" "restart_vm" {
#   name               = "RestartVM"
#   virtual_machine_id = azurerm_linux_virtual_machine.example.id
#   location           = azurerm_linux_virtual_machine.example.location

#   # source {
#   #   # Command to restart the Linux VM
#   #   script = <<EOF
#   #     sudo reboot
#   #   EOF
#   # }

# source {
#     script = <<EOF
#       #!/bin/bash
#       sudo /sbin/reboot
#     EOF
#   }


#   depends_on = [azurerm_virtual_machine_run_command.domain_join]

#   lifecycle {
#     ignore_changes = [tags]
#   }
# }

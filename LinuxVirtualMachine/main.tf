resource "azurerm_network_security_group" "example" {
  name                = "${var.vm_name}-nsg"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })
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

  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_network_security_group.example]
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.example.id
  depends_on                = [azurerm_network_interface.main]
}

resource "azurerm_linux_virtual_machine" "example" {
  name                            = var.vm_name
  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  network_interface_ids           = [azurerm_network_interface.main.id]
  secure_boot_enabled             = var.secure_boot_enabled
  patch_mode                      = var.patch_mode
  patch_assessment_mode           = var.patch_assessment_mode
  encryption_at_host_enabled      = var.encryption_at_host_enabled
  computer_name                   = var.vm_name
  disable_password_authentication = var.disable_password_authentication

  source_image_reference {
    publisher = var.source_image_reference["publisher"]
    offer     = var.source_image_reference["offer"]
    sku       = var.source_image_reference["sku"]
    version   = var.source_image_reference["version"]
  }

  os_disk {
    caching                = var.caching_os_disk
    storage_account_type   = var.storage_account_type_os_disk
    disk_size_gb           = var.disk_size_os_disk
    disk_encryption_set_id = var.disk_encryption_set_id
  }

  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  lifecycle {
    ignore_changes = [identity]
  }

  depends_on = [azurerm_network_interface_security_group_association.example]
}

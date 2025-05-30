resource "azurerm_network_security_group" "example" {
  name                = var.nsg_name
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  tags = merge(data.azurerm_resource_group.resource_group.tags, var.extra_tags, { source = "Terraform" })
}

resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "${var.vm_name}-nic-ipconfig"
    subnet_id                     = data.azurerm_subnet.example.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }

  tags = merge(data.azurerm_resource_group.resource_group.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_network_security_group.example]
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.example.id
  depends_on                = [azurerm_network_interface.main]
}

resource "azurerm_windows_virtual_machine" "main" {
  name                       = var.vm_name
  location                   = data.azurerm_resource_group.resource_group.location
  resource_group_name        = data.azurerm_resource_group.resource_group.name
  size                       = var.vm_size
  admin_username             = var.admin_username
  admin_password             = var.admin_password
  network_interface_ids      = [azurerm_network_interface.main.id]
  license_type               = var.license_type
  secure_boot_enabled        = var.secure_boot_enabled
  vtpm_enabled               = var.vtpm_enabled
  enable_automatic_updates   = var.enable_automatic_updates
  patch_mode                 = var.patch_mode
  encryption_at_host_enabled = var.encryption_at_host_enabled
  computer_name              = var.vm_name
  patch_assessment_mode      = var.patch_assessment_mode

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

  lifecycle {
    ignore_changes = [identity]
  }

  tags = merge(data.azurerm_resource_group.resource_group.tags, var.extra_tags, { "update schedule" = var.tag_update_schedule, source = "Terraform" })

  depends_on = [azurerm_network_interface_security_group_association.example]
}

resource "azurerm_managed_disk" "example" {
  name                   = var.data_disk_name
  location               = data.azurerm_resource_group.resource_group.location
  resource_group_name    = data.azurerm_resource_group.resource_group.name
  storage_account_type   = var.storage_account_type_data_disk
  create_option          = var.managed_disk_create_option
  disk_size_gb           = var.managed_disk_size
  disk_encryption_set_id = var.disk_encryption_set_id

  tags = merge(data.azurerm_resource_group.resource_group.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_windows_virtual_machine.main]
}

resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  managed_disk_id    = azurerm_managed_disk.example.id
  virtual_machine_id = azurerm_windows_virtual_machine.main.id
  lun                = var.lun_data_disk
  caching            = var.caching_data_disk
  depends_on         = [azurerm_managed_disk.example]
}

resource "azurerm_virtual_machine_extension" "disk_setup" {
  name                 = "assign-drive-letter"
  virtual_machine_id   = azurerm_windows_virtual_machine.main.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  depends_on           = [azurerm_virtual_machine_data_disk_attachment.example]

  lifecycle {
    ignore_changes = [tags]
  }

  settings = <<EOT
  {
    "commandToExecute": "powershell -ExecutionPolicy Bypass -Command \"$cdDrive = Get-WmiObject -Query 'SELECT * FROM Win32_Volume WHERE DriveType = 5 AND DriveLetter = \\\"D:\\\"'; if ($cdDrive) { $cdDrive.DriveLetter = \\\"Z:\\\"; $cdDrive.Put(); }; $disk = Get-Disk | Where-Object PartitionStyle -eq 'RAW'; if ($disk) { Initialize-Disk -Number $disk.Number -PartitionStyle GPT -Confirm:$false; $partition = New-Partition -DiskNumber $disk.Number -UseMaximumSize -AssignDriveLetter; Format-Volume -DriveLetter $partition.DriveLetter -FileSystem NTFS -Confirm:$false } else { Write-Output 'No RAW disk found for initialization.' }\""
  }
  EOT
}


# Resource for setting DNS Suffix
resource "azurerm_virtual_machine_run_command" "set_dns_suffix" {
  name               = "SetDNSSuffix"
  virtual_machine_id = azurerm_windows_virtual_machine.main.id
  location           = azurerm_windows_virtual_machine.main.location

  lifecycle {
    ignore_changes = [tags]
  }

  source {
    script = <<EOF
     Set-DnsClient -InterfaceIndex (Get-NetAdapter -InterfaceDescription "Microsoft Hyper-V*").IfIndex -ConnectionSpecificSuffix "rotterdam.local" -UseSuffixWhenRegistering $true; Register-DnsClient
     EOF
  }
  depends_on = [azurerm_virtual_machine_extension.disk_setup]
}

# Resource for Azure Policy for Windows extension
resource "azurerm_virtual_machine_extension" "azure_policy_windows" {
  name                       = "AzurePolicyforWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.main.id
  publisher                  = "Microsoft.GuestConfiguration"
  type                       = "ConfigurationforWindows"
  type_handler_version       = "1.29"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  depends_on                 = [azurerm_virtual_machine_run_command.set_dns_suffix]

  lifecycle {
    ignore_changes = [tags]
  }
}

# Resource for Monitoring Dependency Agent extension
resource "azurerm_virtual_machine_extension" "monitoring_dependency_agent" {
  name                       = "Microsoft.Azure.Monitoring.DependencyAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.main.id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentWindows"
  type_handler_version       = "9.10"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  depends_on                 = [azurerm_virtual_machine_extension.azure_policy_windows]

  lifecycle {
    ignore_changes = [tags]
  }
}

# Resource for Microsoft Defender Agent Extension
resource "azurerm_virtual_machine_extension" "mde_windows" {
  name                       = "MDE.Windows"
  virtual_machine_id         = azurerm_windows_virtual_machine.main.id
  publisher                  = "Microsoft.Azure.AzureDefenderForSQL"
  type                       = "AdvancedThreatProtection.Windows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  lifecycle {
    ignore_changes = [tags, settings]
  }

  settings = jsonencode({
    autoUpdate        = true
    azureResourceId   = azurerm_windows_virtual_machine.main.id
    forceReOnboarding = false
    vNextEnabled      = true
  })

  depends_on = [azurerm_virtual_machine_extension.monitoring_dependency_agent]
}

# Resource for Azure Monitor Windows Agent extension
resource "azurerm_virtual_machine_extension" "azure_monitor_windows_agent" {
  name                       = "AzureMonitorWindowsAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.main.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  depends_on                 = [azurerm_virtual_machine_extension.mde_windows]

  lifecycle {
    ignore_changes = [tags]
  }
}

# Resource to join domain
resource "azurerm_virtual_machine_extension" "domain_join" {
  name                 = "domainJoin"
  virtual_machine_id    = azurerm_windows_virtual_machine.main.id
  publisher             = "Microsoft.Compute"
  type                  = "JsonADDomainExtension"
  type_handler_version = "1.3"
  auto_upgrade_minor_version = true

  lifecycle {
    ignore_changes = [tags]
  }

  settings = jsonencode({
    Name        = "rotterdam.local"
    User        = "rotterdam\\SA_SRV_TERRAFORM_DJ"
    Restart     = "true"
    Options     = 3
    OUPath      = var.OU_path
  })

  protected_settings = jsonencode({
    Password = "ufpIBoYRXUNjkFo<>"
  })
  depends_on = [azurerm_virtual_machine_extension.azure_monitor_windows_agent]
}

resource "azurerm_virtual_machine_run_command" "set_timezone_vm" {
  name               = "SetTimeZoneOnVm"
  virtual_machine_id = azurerm_windows_virtual_machine.main.id
  location           = azurerm_windows_virtual_machine.main.location
  source {
    # Command to set timezone on vm
    script = <<EOF
    Set-TimeZone -Id "W. Europe Standard Time"
  EOF
  }
  depends_on = [azurerm_virtual_machine_extension.azure_monitor_windows_agent] //[azurerm_virtual_machine_extension.domain_join]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_mssql_virtual_machine" "example" {
  virtual_machine_id = azurerm_windows_virtual_machine.main.id
  sql_license_type   = "PAYG"
  depends_on         = [azurerm_virtual_machine_run_command.set_timezone_vm]
  # sql_instance {
  #   collation = 
  # }
  tags = merge(data.azurerm_resource_group.resource_group.tags, var.extra_tags, { "update schedule" = var.tag_update_schedule, source = "Terraform" })
}

resource "azurerm_virtual_machine_run_command" "restart_vm" {
  name               = "RestartVM"
  virtual_machine_id = azurerm_windows_virtual_machine.main.id
  location           = azurerm_windows_virtual_machine.main.location
  source {
    # Command to restart the Windows VM
    script = <<EOF
    Restart-Computer -Force
  EOF
  }
  depends_on = [azurerm_mssql_virtual_machine.example]

  lifecycle {
    ignore_changes = [tags]
  }
}

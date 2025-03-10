resource "azurerm_network_security_group" "example" {
  name                = var.NSG_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })
  
  depends_on = [data.azurerm_subnet.example]
}

resource "azurerm_network_interface" "main-1" {
  name                = "${var.vm_name1}-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.vm_name1}-nic-ipconfig"
    subnet_id                     = data.azurerm_subnet.example.id
    private_ip_address_allocation = var.private_ip_address_allocation1
  }

  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })
  
  depends_on = [azurerm_network_security_group.example]
}

resource "azurerm_network_interface_security_group_association" "example-1" {
  network_interface_id      = azurerm_network_interface.main-1.id
  network_security_group_id = azurerm_network_security_group.example.id
  depends_on                = [azurerm_network_interface.main-1]
}

resource "azurerm_windows_virtual_machine" "main-1" {
  name                       = var.vm_name1
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  size                       = var.vm_size1
  admin_username             = var.admin_username
  admin_password             = var.admin_password
  network_interface_ids      = [azurerm_network_interface.main-1.id]
  license_type               = var.license_type1
  secure_boot_enabled        = var.secure_boot_enabled1
  vtpm_enabled               = var.vtpm_enabled1
  enable_automatic_updates   = var.enable_automatic_updates1
  patch_mode                 = var.patch_mode1
  encryption_at_host_enabled = var.encryption_at_host_enabled1
  computer_name              = var.vm_name1
  patch_assessment_mode      = var.patch_assessment_mode1
  source_image_id            = var.source_image_id1

  os_disk {
    caching                = var.caching_os_disk1
    storage_account_type   = var.storage_account_type_os_disk1
    disk_size_gb           = var.disk_size_os_disk1
    disk_encryption_set_id = var.disk_encryption_set_id
  }

  lifecycle {
    ignore_changes = [identity]
  }

  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { "update schedule" = var.tag_update_schedule, source = "Terraform" })

  depends_on = [azurerm_network_interface_security_group_association.example-1]
}

resource "azurerm_managed_disk" "disk1" {
  name                          = var.data_disk_name1
  location                      = data.azurerm_resource_group.rg.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  storage_account_type          = var.storage_account_type_data_disk1
  create_option                 = var.managed_disk_create_option1
  disk_size_gb                  = var.managed_disk_size1
  disk_encryption_set_id        = var.disk_encryption_set_id
  
 tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_windows_virtual_machine.main-1]
}

resource "azurerm_virtual_machine_data_disk_attachment" "example1" {
  managed_disk_id    = azurerm_managed_disk.disk1.id
  virtual_machine_id = azurerm_windows_virtual_machine.main-1.id
  lun                = var.lun_data_disk1
  caching            = var.caching_data_disk1
  depends_on         = [azurerm_managed_disk.disk1]
}

resource "azurerm_managed_disk" "disk2" {
  name                          = var.data_disk_name2
  location                      = data.azurerm_resource_group.rg.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  storage_account_type          = var.storage_account_type_data_disk2
  create_option                 = var.managed_disk_create_option2
  disk_size_gb                  = var.managed_disk_size2
  disk_encryption_set_id        = var.disk_encryption_set_id
  
  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_windows_virtual_machine.main-1]
}

resource "azurerm_virtual_machine_data_disk_attachment" "example2" {
  managed_disk_id    = azurerm_managed_disk.disk2.id
  virtual_machine_id = azurerm_windows_virtual_machine.main-1.id
  lun                = var.lun_data_disk2
  caching            = var.caching_data_disk2
  depends_on         = [azurerm_managed_disk.disk2]
}

resource "azurerm_managed_disk" "disk3" {
  name                          = var.data_disk_name3
  location                      = data.azurerm_resource_group.rg.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  storage_account_type          = var.storage_account_type_data_disk3
  create_option                 = var.managed_disk_create_option3
  disk_size_gb                  = var.managed_disk_size3
  disk_encryption_set_id        = var.disk_encryption_set_id
  
  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_windows_virtual_machine.main-1]
}

resource "azurerm_virtual_machine_data_disk_attachment" "example3" {
  managed_disk_id    = azurerm_managed_disk.disk3.id
  virtual_machine_id = azurerm_windows_virtual_machine.main-1.id
  lun                = var.lun_data_disk3
  caching            = var.caching_data_disk3
  depends_on         = [azurerm_managed_disk.disk3]
}

resource "azurerm_managed_disk" "disk4" {
  name                          = var.data_disk_name4
  location                      = data.azurerm_resource_group.rg.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  storage_account_type          = var.storage_account_type_data_disk4
  create_option                 = var.managed_disk_create_option4
  disk_size_gb                  = var.managed_disk_size4
  disk_encryption_set_id        = var.disk_encryption_set_id
  
  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_windows_virtual_machine.main-1]
}

resource "azurerm_virtual_machine_data_disk_attachment" "example4" {
  managed_disk_id    = azurerm_managed_disk.disk4.id
  virtual_machine_id = azurerm_windows_virtual_machine.main-1.id
  lun                = var.lun_data_disk4
  caching            = var.caching_data_disk4
  depends_on         = [azurerm_managed_disk.disk4]
}

resource "azurerm_network_interface" "main-2" {
  name                = "${var.vm_name2}-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.vm_name2}-nic-ipconfig"
    subnet_id                     = data.azurerm_subnet.example.id
    private_ip_address_allocation = var.private_ip_address_allocation2
  }

  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })
  
  depends_on = [azurerm_network_security_group.example]
}

resource "azurerm_network_interface_security_group_association" "example-2" {
  network_interface_id      = azurerm_network_interface.main-2.id
  network_security_group_id = azurerm_network_security_group.example.id
  depends_on                = [azurerm_network_interface.main-2]
}

resource "azurerm_windows_virtual_machine" "main-2" {
  name                       = var.vm_name2
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  size                       = var.vm_size2
  admin_username             = var.admin_username
  admin_password             = var.admin_password
  network_interface_ids      = [azurerm_network_interface.main-2.id]
  license_type               = var.license_type2
  secure_boot_enabled        = var.secure_boot_enabled2
  vtpm_enabled               = var.vtpm_enabled2
  enable_automatic_updates   = var.enable_automatic_updates2
  patch_mode                 = var.patch_mode2
  encryption_at_host_enabled = var.encryption_at_host_enabled2
  computer_name              = var.vm_name2
  patch_assessment_mode      = var.patch_assessment_mode2
  source_image_id            = var.source_image_id2

  os_disk {
    caching                = var.caching_os_disk2
    storage_account_type   = var.storage_account_type_os_disk2
    disk_size_gb           = var.disk_size_os_disk2
    disk_encryption_set_id = var.disk_encryption_set_id
  }

  lifecycle {
    ignore_changes = [identity]
  }

  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { "update schedule" = var.tag_update_schedule, source = "Terraform" })

  depends_on = [azurerm_network_interface_security_group_association.example-2]
}

resource "azurerm_managed_disk" "disk5" {
  name                          = var.data_disk_name5
  location                      = data.azurerm_resource_group.rg.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  storage_account_type          = var.storage_account_type_data_disk5
  create_option                 = var.managed_disk_create_option5
  disk_size_gb                  = var.managed_disk_size5
  disk_encryption_set_id        = var.disk_encryption_set_id
  
  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_windows_virtual_machine.main-2]
}

resource "azurerm_virtual_machine_data_disk_attachment" "example5" {
  managed_disk_id    = azurerm_managed_disk.disk5.id
  virtual_machine_id = azurerm_windows_virtual_machine.main-2.id
  lun                = var.lun_data_disk5
  caching            = var.caching_data_disk5
  depends_on         = [azurerm_managed_disk.disk5]
}

resource "azurerm_managed_disk" "disk6" {
  name                          = var.data_disk_name6
  location                      = data.azurerm_resource_group.rg.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  storage_account_type          = var.storage_account_type_data_disk6
  create_option                 = var.managed_disk_create_option6
  disk_size_gb                  = var.managed_disk_size6
  disk_encryption_set_id        = var.disk_encryption_set_id
  
  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_windows_virtual_machine.main-2]
}

resource "azurerm_virtual_machine_data_disk_attachment" "example6" {
  managed_disk_id    = azurerm_managed_disk.disk6.id
  virtual_machine_id = azurerm_windows_virtual_machine.main-2.id
  lun                = var.lun_data_disk6
  caching            = var.caching_data_disk6
  depends_on         = [azurerm_managed_disk.disk6]
}

resource "azurerm_managed_disk" "disk7" {
  name                          = var.data_disk_name7
  location                      = data.azurerm_resource_group.rg.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  storage_account_type          = var.storage_account_type_data_disk7
  create_option                 = var.managed_disk_create_option7
  disk_size_gb                  = var.managed_disk_size7
  disk_encryption_set_id        = var.disk_encryption_set_id
  
  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_windows_virtual_machine.main-2]
}

resource "azurerm_virtual_machine_data_disk_attachment" "example7" {
  managed_disk_id    = azurerm_managed_disk.disk7.id
  virtual_machine_id = azurerm_windows_virtual_machine.main-2.id
  lun                = var.lun_data_disk7
  caching            = var.caching_data_disk7
  depends_on         = [azurerm_managed_disk.disk7]
}

resource "azurerm_managed_disk" "disk8" {
  name                          = var.data_disk_name8
  location                      = data.azurerm_resource_group.rg.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  storage_account_type          = var.storage_account_type_data_disk8
  create_option                 = var.managed_disk_create_option8
  disk_size_gb                  = var.managed_disk_size8
  disk_encryption_set_id        = var.disk_encryption_set_id
  
  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_windows_virtual_machine.main-2]
}

resource "azurerm_virtual_machine_data_disk_attachment" "example8" {
  managed_disk_id    = azurerm_managed_disk.disk8.id
  virtual_machine_id = azurerm_windows_virtual_machine.main-2.id
  lun                = var.lun_data_disk8
  caching            = var.caching_data_disk8
  depends_on         = [azurerm_managed_disk.disk8]
}

module "storage_account" {
  source = "../StorageAccount"

  resource_group_name                    = data.azurerm_resource_group.rg.name         
  subnet_name                            = data.azurerm_subnet.example.name                       
  subnet_rg                              = data.azurerm_subnet.example.resource_group_name               
  subnet_vnet                            = data.azurerm_virtual_network.example.name         

 // Resources die worden aangemaakt
  keyvault_name                          = var.keyvault_name                              
  identity_name                          = var.identity_name
  private_endpoint_name_for_kv           = var.private_endpoint_name_for_kv               
  private_dns_zone_name_kv               = var.private_dns_zone_name_kv
  private_dns_zone_id_kv                 = var.private_dns_zone_id_kv
  keyvault_key_name                      = var.keyvault_key_name                          
  storage_account_name                   = var.storage_account_name                       
  private_endpoint_name_for_sa           = var.private_endpoint_name_for_sa               
  private_dns_zone_name_sa               = var.private_dns_zone_name_kv
  private_dns_zone_id_sa                 = var.private_dns_zone_id_sa              
}

resource "azurerm_storage_share" "example" {
  name                 = var.storage_share_name
  storage_account_id   = module.storage_account.storage_account_id
  quota                = var.storage_share_quota
  depends_on           = [module.storage_account]
}

resource "azurerm_virtual_machine_extension" "disk_setup1" {
  name                      = "assign-drive-letter"
  virtual_machine_id        = azurerm_windows_virtual_machine.main-1.id
  publisher                 = "Microsoft.Compute"
  type                      = "CustomScriptExtension"
  type_handler_version      = "1.10"
  depends_on                = [azurerm_virtual_machine_data_disk_attachment.example4]

  lifecycle {
    ignore_changes = [tags]
  }

  settings = <<EOT
  {
    "commandToExecute": "powershell -ExecutionPolicy Bypass -Command \"$cdDrive = Get-WmiObject -Query 'SELECT * FROM Win32_Volume WHERE DriveType = 5 AND DriveLetter = \\\"D:\\\"'; if ($cdDrive) { $cdDrive.DriveLetter = \\\"Z:\\\"; $cdDrive.Put(); }; $disk = Get-Disk | Where-Object PartitionStyle -eq 'RAW'; if ($disk) { Initialize-Disk -Number $disk.Number -PartitionStyle GPT -Confirm:$false; $partition = New-Partition -DiskNumber $disk.Number -UseMaximumSize -AssignDriveLetter; Format-Volume -DriveLetter $partition.DriveLetter -FileSystem NTFS -Confirm:$false } else { Write-Output 'No RAW disk found for initialization.' }\""
  }
  EOT
}

resource "azurerm_virtual_machine_extension" "disk_setup2" {
  name                      = "assign-drive-letter"
  virtual_machine_id        = azurerm_windows_virtual_machine.main-2.id
  publisher                 = "Microsoft.Compute"
  type                      = "CustomScriptExtension"
  type_handler_version      = "1.10"
  depends_on                = [azurerm_virtual_machine_data_disk_attachment.example8]

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
resource "azurerm_virtual_machine_run_command" "set_dns_suffix1" {
  name               = "SetDNSSuffix"
  virtual_machine_id = azurerm_windows_virtual_machine.main-1.id
  location           = azurerm_windows_virtual_machine.main-1.location

  lifecycle {
    ignore_changes = [tags]
  }
  
  source {
    script = <<EOF
     Set-DnsClient -InterfaceIndex (Get-NetAdapter -InterfaceDescription "Microsoft Hyper-V*").IfIndex -ConnectionSpecificSuffix "rotterdam.local" -UseSuffixWhenRegistering $true; Register-DnsClient
     EOF
  }
  depends_on = [azurerm_virtual_machine_extension.disk_setup1]
}

# Resource for setting DNS Suffix
resource "azurerm_virtual_machine_run_command" "set_dns_suffix2" {
  name               = "SetDNSSuffix"
  virtual_machine_id = azurerm_windows_virtual_machine.main-2.id
  location           = azurerm_windows_virtual_machine.main-2.location

  lifecycle {
    ignore_changes = [tags]
  }
  
  source {
    script = <<EOF
     Set-DnsClient -InterfaceIndex (Get-NetAdapter -InterfaceDescription "Microsoft Hyper-V*").IfIndex -ConnectionSpecificSuffix "rotterdam.local" -UseSuffixWhenRegistering $true; Register-DnsClient
     EOF
  }
  depends_on = [azurerm_virtual_machine_extension.disk_setup2]
}

# Resource for Azure Policy for Windows extension
resource "azurerm_virtual_machine_extension" "azure_policy_windows1" {
  name                 = "AzurePolicyforWindows"
  virtual_machine_id    = azurerm_windows_virtual_machine.main-1.id
  publisher             = "Microsoft.GuestConfiguration"
  type                  = "ConfigurationforWindows"
  type_handler_version = "1.29"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled = true
  depends_on = [azurerm_virtual_machine_run_command.set_dns_suffix1]

  lifecycle {
    ignore_changes = [tags]
  }
}

# Resource for Azure Policy for Windows extension
resource "azurerm_virtual_machine_extension" "azure_policy_windows2" {
  name                 = "AzurePolicyforWindows"
  virtual_machine_id    = azurerm_windows_virtual_machine.main-2.id
  publisher             = "Microsoft.GuestConfiguration"
  type                  = "ConfigurationforWindows"
  type_handler_version = "1.29"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled = true
  depends_on = [azurerm_virtual_machine_run_command.set_dns_suffix2]

  lifecycle {
    ignore_changes = [tags]
  }
}

# Resource for Monitoring Dependency Agent extension
resource "azurerm_virtual_machine_extension" "monitoring_dependency_agent1" {
  name                 = "Microsoft.Azure.Monitoring.DependencyAgent"
  virtual_machine_id    = azurerm_windows_virtual_machine.main-1.id
  publisher             = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                  = "DependencyAgentWindows"
  type_handler_version = "9.10"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled = true
  depends_on = [azurerm_virtual_machine_extension.azure_policy_windows1]

  lifecycle {
    ignore_changes = [tags]
  }
}

# Resource for Monitoring Dependency Agent extension
resource "azurerm_virtual_machine_extension" "monitoring_dependency_agent2" {
  name                 = "Microsoft.Azure.Monitoring.DependencyAgent"
  virtual_machine_id    = azurerm_windows_virtual_machine.main-2.id
  publisher             = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                  = "DependencyAgentWindows"
  type_handler_version = "9.10"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled = true
  depends_on = [azurerm_virtual_machine_extension.azure_policy_windows2]

  lifecycle {
    ignore_changes = [tags]
  }
}

# Resource for Microsoft Defender Agent Extension
resource "azurerm_virtual_machine_extension" "mde_windows1" {
  name                       = "MDE.Windows"
  virtual_machine_id         = azurerm_windows_virtual_machine.main-1.id
  publisher                  = "Microsoft.Azure.AzureDefenderForServers"
  type                       = "MDE.Windows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  lifecycle {
    ignore_changes = [tags, settings]
  }

  settings                   = jsonencode({
    autoUpdate        = true
    azureResourceId   = azurerm_windows_virtual_machine.main-1.id
    forceReOnboarding = false
    vNextEnabled      = true
  })

  depends_on                 = [azurerm_virtual_machine_extension.monitoring_dependency_agent1]
}

# Resource for Microsoft Defender Agent Extension
resource "azurerm_virtual_machine_extension" "mde_windows2" {
  name                       = "MDE.Windows"
  virtual_machine_id         = azurerm_windows_virtual_machine.main-2.id
  publisher                  = "Microsoft.Azure.AzureDefenderForServers"
  type                       = "MDE.Windows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  lifecycle {
    ignore_changes = [tags, settings]
  }

  settings                   = jsonencode({
    autoUpdate        = true
    azureResourceId   = azurerm_windows_virtual_machine.main-2.id
    forceReOnboarding = false
    vNextEnabled      = true
  })

  depends_on                 = [azurerm_virtual_machine_extension.monitoring_dependency_agent2]
}

# Resource for Azure Monitor Windows Agent extension
resource "azurerm_virtual_machine_extension" "azure_monitor_windows_agent1" {
  name                 = "AzureMonitorWindowsAgent"
  virtual_machine_id    = azurerm_windows_virtual_machine.main-1.id
  publisher             = "Microsoft.Azure.Monitor"
  type                  = "AzureMonitorWindowsAgent"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled = true
  depends_on = [azurerm_virtual_machine_extension.mde_windows1]

  lifecycle {
    ignore_changes = [tags]
  }
}

# Resource for Azure Monitor Windows Agent extension
resource "azurerm_virtual_machine_extension" "azure_monitor_windows_agent2" {
  name                 = "AzureMonitorWindowsAgent"
  virtual_machine_id    = azurerm_windows_virtual_machine.main-2.id
  publisher             = "Microsoft.Azure.Monitor"
  type                  = "AzureMonitorWindowsAgent"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled = true
  depends_on = [azurerm_virtual_machine_extension.mde_windows2]

  lifecycle {
    ignore_changes = [tags]
  }
}

# Resource to join domain
resource "azurerm_virtual_machine_extension" "domain_join1" {
  name                 = "domainJoin"
  virtual_machine_id    = azurerm_windows_virtual_machine.main-1.id
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
  depends_on = [azurerm_virtual_machine_extension.azure_monitor_windows_agent1]
}

# Resource to join domain
resource "azurerm_virtual_machine_extension" "domain_join2" {
  name                 = "domainJoin"
  virtual_machine_id    = azurerm_windows_virtual_machine.main-2.id
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
  depends_on = [azurerm_virtual_machine_extension.azure_monitor_windows_agent2]
}

resource "azurerm_virtual_machine_run_command" "set_timezone_vm1" {
  name               = "SetTimeZoneOnVm"
  virtual_machine_id = azurerm_windows_virtual_machine.main-1.id
  location           = azurerm_windows_virtual_machine.main-1.location
  source {
  # Command to set timezone on vm
  script = <<EOF
    Set-TimeZone -Id "W. Europe Standard Time"
  EOF
  }
  depends_on = [azurerm_virtual_machine_extension.domain_join1]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_virtual_machine_run_command" "set_timezone_vm2" {
  name               = "SetTimeZoneOnVm"
  virtual_machine_id = azurerm_windows_virtual_machine.main-2.id
  location           = azurerm_windows_virtual_machine.main-2.location
  source {
  # Command to set timezone on vm
  script = <<EOF
    Set-TimeZone -Id "W. Europe Standard Time"
  EOF
  }
  depends_on = [azurerm_virtual_machine_extension.domain_join2]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_virtual_machine_run_command" "restart_vm1" {
  name               = "RestartVM"
  virtual_machine_id = azurerm_windows_virtual_machine.main-1.id
  location           = azurerm_windows_virtual_machine.main-1.location
  source {
  # Command to restart the Windows VM
  script = <<EOF
    Restart-Computer -Force
  EOF
  }
  depends_on = [azurerm_virtual_machine_run_command.set_timezone_vm1]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_virtual_machine_run_command" "restart_vm2" {
  name               = "RestartVM"
  virtual_machine_id = azurerm_windows_virtual_machine.main-2.id
  location           = azurerm_windows_virtual_machine.main-2.location
  source {
  # Command to restart the Windows VM
  script = <<EOF
    Restart-Computer -Force
  EOF
  }
  depends_on = [azurerm_virtual_machine_run_command.set_timezone_vm2]

  lifecycle {
    ignore_changes = [tags]
  }
}




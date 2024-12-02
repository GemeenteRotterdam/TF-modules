data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_subnet" "snet" {
  name                 = var.subnet_name
  resource_group_name  = var.subnet_rg
  virtual_network_name = var.subnet_vnet
}

//data "azurerm_key_vault_secret" "admin_username" {
//  name         = var.secret_username_name
//  key_vault_id = var.key_vault_id_secret_username
//}

//data "azurerm_key_vault_secret" "admin_password" {
//  name         = var.secret_password_name
//  key_vault_id = var.key_vault_id_secret_password
//}

data "azurerm_disk_encryption_set" "disk_encryption" {
  name                = var.disk_encryption_set_name
  resource_group_name = var.disk_encryption_set_rg
}

resource "azurerm_network_security_group" "example" {
  name                = var.NSG_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = {
    "terraform"    = "Yes"
    "change number" = var.tag_changenumber
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

  tags = {
    "terraform"    = "Yes"
    "change number" = var.tag_changenumber
  }
  
  depends_on = [azurerm_network_security_group.example]
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.example.id
  depends_on                = [azurerm_network_interface.main]
}                                               

resource "azurerm_windows_virtual_machine" "main" {
  name                       = var.vm_name
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  size                       = var.vm_size
  admin_username             = "vmadmintest"
  admin_password             = "Wachtwoord123!"
  network_interface_ids      = [azurerm_network_interface.main.id]
  license_type               = var.license_type
  secure_boot_enabled        = var.secure_boot_enabled
  vtpm_enabled               = var.vtpm_enabled
  enable_automatic_updates   = var.enable_automatic_updates
  patch_mode                 = var.patch_mode
  encryption_at_host_enabled = var.encryption_at_host_enabled
  computer_name              = var.vm_name
  patch_assessment_mode      = var.patch_assessment_mode
  source_image_id            = var.source_image_id

  os_disk {
    caching                = var.caching_os_disk
    storage_account_type   = var.storage_account_type_os_disk
    disk_encryption_set_id = data.azurerm_disk_encryption_set.disk_encryption.id
  }

  tags = {
    "terraform"    = "Yes"
    "change number" = var.tag_changenumber
  }

  depends_on = [azurerm_network_interface_security_group_association.example]
}

resource "azurerm_managed_disk" "example" {
  name                          = var.data_disk_name
  location                      = data.azurerm_resource_group.rg.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  storage_account_type          = var.storage_account_type_data_disk
  create_option                 = var.managed_disk_create_option
  disk_size_gb                  = var.managed_disk_size
  disk_encryption_set_id        = data.azurerm_disk_encryption_set.disk_encryption.id
  
  tags = {
    "terraform"    = "Yes"
    "change number" = var.tag_changenumber
  }

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
  name                      = "assign-drive-letter"
  virtual_machine_id        = azurerm_windows_virtual_machine.main.id
  publisher                 = "Microsoft.Compute"
  type                      = "CustomScriptExtension"
  type_handler_version      = "1.10"
  depends_on                = [azurerm_virtual_machine_data_disk_attachment.example]

  settings = <<EOT
  {
  "commandToExecute": "powershell -ExecutionPolicy Bypass -Command \"$disk = Get-Disk | Where-Object PartitionStyle -eq 'RAW'; if ($disk) { Initialize-Disk -Number $disk.Number -PartitionStyle GPT -Confirm:$false; $partition = New-Partition -DiskNumber $disk.Number -UseMaximumSize -AssignDriveLetter; Format-Volume -DriveLetter $partition.DriveLetter -FileSystem NTFS -Confirm:$false } else { Write-Output 'No RAW disk found for initialization.' }\""
  }
  EOT
}

# Resource for setting DNS Suffix
resource "azurerm_virtual_machine_run_command" "set_dns_suffix" {
  name               = "SetDNSSuffix"
  virtual_machine_id = azurerm_windows_virtual_machine.main.id
  location           = azurerm_windows_virtual_machine.main.location
  
  source {
    script = <<EOF
     Set-DnsClient -InterfaceIndex (Get-NetAdapter -InterfaceDescription "Microsoft Hyper-V*").IfIndex -ConnectionSpecificSuffix "rotterdam.local" -UseSuffixWhenRegistering $true; Register-DnsClient
     EOF
  }
  depends_on = [azurerm_virtual_machine_extension.disk_setup]
}

# Resource for Azure Policy for Windows extension
resource "azurerm_virtual_machine_extension" "azure_policy_windows" {
  name                 = "AzurePolicyforWindows"
  virtual_machine_id    = azurerm_windows_virtual_machine.main.id
  publisher             = "Microsoft.GuestConfiguration"
  type                  = "ConfigurationforWindows"
  type_handler_version = "1.29"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled = true
  depends_on = [azurerm_virtual_machine_run_command.set_dns_suffix]
}

# Resource for Monitoring Dependency Agent extension
resource "azurerm_virtual_machine_extension" "monitoring_dependency_agent" {
  name                 = "Microsoft.Azure.Monitoring.DependencyAgent"
  virtual_machine_id    = azurerm_windows_virtual_machine.main.id
  publisher             = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                  = "DependencyAgentWindows"
  type_handler_version = "9.10"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled = true
  depends_on = [azurerm_virtual_machine_extension.azure_policy_windows]
}

# Resource for Microsoft Defender Agent Extension
resource "azurerm_virtual_machine_extension" "mde_windows" {
  name                       = "MDE.Windows"
  virtual_machine_id         = azurerm_windows_virtual_machine.main.id
  publisher                  = "Microsoft.Azure.AzureDefenderForServers"
  type                       = "MDE.Windows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  settings                   = jsonencode({
    autoUpdate        = true
    azureResourceId   = azurerm_windows_virtual_machine.main.id
    forceReOnboarding = false
    vNextEnabled      = true
  })

  depends_on                 = [azurerm_virtual_machine_extension.monitoring_dependency_agent]
}

# Resource for Azure Monitor Windows Agent extension
resource "azurerm_virtual_machine_extension" "azure_monitor_windows_agent" {
  name                 = "AzureMonitorWindowsAgent"
  virtual_machine_id    = azurerm_windows_virtual_machine.main.id
  publisher             = "Microsoft.Azure.Monitor"
  type                  = "AzureMonitorWindowsAgent"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled = true
  depends_on = [azurerm_virtual_machine_extension.mde_windows]
}

# Resource to join domain
resource "azurerm_virtual_machine_extension" "domain_join" {
  name                 = "domainJoin"
  virtual_machine_id    = azurerm_windows_virtual_machine.main.id
  publisher             = "Microsoft.Compute"
  type                  = "JsonADDomainExtension"
  type_handler_version = "1.3"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    Name        = "rotterdam.local"
    User        = "rotterdam\\SA_SRV_TERRAFORM_DJ"
    Restart     = "true"
    Options     = 3
    OUPath      = "OU=${var.OU_path},OU=Servers,DC=rotterdam,DC=local"
    Description = var.OU_description
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
  depends_on = [azurerm_virtual_machine_extension.domain_join]
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
  depends_on = [azurerm_virtual_machine_run_command.set_timezone_vm]
}







variable "azure_region" {
  type        = string
  description = "Location/Region where network config is required"
}

variable "rgName" {
  type        = string
  description = "Resource group name for the hub"
}

variable "admin_password" {
  type        = string
  description = "Admin Password for the VM"
}

variable "subnet_id" {
  type        = string
  description = "Subnet id where VMSS has to be placed"
}

resource "azurerm_public_ip" "vmss_pip" {
  name                = "vmss_pip"
  location            = var.azure_region
  resource_group_name = var.rgName
  allocation_method   = "Static"

  tags = {
    "Environment" = "azurelab_hubspoke"
    "Owner"       = "SM"
  }
}

resource "azurerm_lb" "vmss_lb" {
  name                = "vmss_lb"
  location            = var.azure_region
  resource_group_name = var.rgName

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.vmss_pip.id
  }

  tags = {
    "Environment" = "azurelab_hubspoke"
    "Owner"       = "SM"
  }
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  resource_group_name = var.rgName
  loadbalancer_id     = azurerm_lb.vmss_lb.id
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_nat_pool" "lbnatpool" {
  resource_group_name            = var.rgName
  name                           = "RDP"
  loadbalancer_id                = azurerm_lb.vmss_lb.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_probe" "lbprobe" {
  resource_group_name = var.rgName
  loadbalancer_id     = azurerm_lb.vmss_lb.id
  name                = "http-probe"
  protocol            = "Http"
  request_path        = "/"
  port                = 80
}

resource "azurerm_virtual_machine_scale_set" "azurelab-vmss" {
  name                = "azurelab-vmss"
  location            = var.azure_region
  resource_group_name = var.rgName

  # automatic rolling upgrade
  automatic_os_upgrade = true
  upgrade_policy_mode  = "Rolling"

  rolling_upgrade_policy {
    max_batch_instance_percent              = 20
    max_unhealthy_instance_percent          = 20
    max_unhealthy_upgraded_instance_percent = 5
    pause_time_between_batches              = "PT0S"
  }

  # required when using rolling upgrade policy
  health_probe_id = azurerm_lb_probe.lbprobe.id

  sku {
    name     = "Standard_B2s"
    tier     = "Basic"
    capacity = 2
  }

  storage_profile_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun               = 0
    caching           = "ReadWrite"
    create_option     = "Empty"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = 32
  }

  os_profile {
    computer_name_prefix = "testvm"
    admin_username       = "demouser"
    admin_password       = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name                                   = "TestIPConfiguration"
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      load_balancer_inbound_nat_rules_ids    = [azurerm_lb_nat_pool.lbnatpool.id]
    }
  }

  tags = {
    "Environment" = "azurelab_hubspoke"
    "Owner"       = "SM"
  }
}
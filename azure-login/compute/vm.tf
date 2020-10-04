

resource "azurerm_network_interface" "tf_nic" {
  count               = var.vmCount
  name                = "${var.vmSuffix}-controller_nic-${count.index}"
  location            = var.tf_sample_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "controller_nic_config"
    subnet_id                     = var.subnetId
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "tf_controller" {
  count                 = var.vmCount
  name                  = "tf-vm-${var.vmSuffix}-${count.index}"
  location              = var.tf_sample_location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.tf_nic[count.index].id]
  vm_size               = "Standard_B1ls"

  storage_os_disk {
    name              = "${var.vmSuffix}_myOsDisk_${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = "32"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "tf-${var.vmSuffix}-controller-${count.index}"
    admin_username = "azureuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("~/.ssh/azure_key.pub")
      path     = "/home/azureuser/.ssh/authorized_keys"
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}
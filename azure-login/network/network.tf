
#Create a virtual network
resource "azurerm_virtual_network" "tf_main_vnet" {
  name                = "tf_vnet_web"
  location            = var.tf_sample_location
  address_space       = ["10.0.0.0/16"]
  resource_group_name = var.rg_name
}

#Create a virtual network
resource "azurerm_virtual_network" "tf_peer_vnet" {
  name                = "tf_vnet_db"
  location            = var.tf_sample_location
  address_space       = ["10.1.0.0/16"]
  resource_group_name = var.rg_name
}

#Create a virtual network for jump server
resource "azurerm_virtual_network" "tf_jump_vnet" {
  name                = "tf_vnet_jump"
  location            = var.tf_sample_location
  address_space       = ["10.2.0.0/16"]
  resource_group_name = var.rg_name
}
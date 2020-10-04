local {
  cidr_block = "10.0.0.0/16"
  subnet_count = 4
}
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

#Create a Subnet
resource "azurerm_subnet" "tf_subnet_a" {
  name                 = "tf-web-subnet-a"
  address_prefixes     = ["10.0.0.0/24"]
  virtual_network_name = azurerm_virtual_network.tf_main_vnet.name
  resource_group_name  = var.rg_name
}
#Create a Subnet
resource "azurerm_subnet" "tf_subnet_b" {
  name                 = "tf-web-subnet-b"
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.tf_main_vnet.name
  resource_group_name  = var.rg_name
}

#Create an AppService Subnet
resource "azurerm_subnet" "tf_appservice_subnet" {
  name                 = "tf-main-ase-subnet"
  address_prefixes     = ["10.0.3.0/24"]
  virtual_network_name = azurerm_virtual_network.tf_main_vnet.name
  resource_group_name  = var.rg_name
}

#Create an AppService Subnet
resource "azurerm_subnet" "tf_appgateway_subnet" {
  name                 = "tf-main-gateway-subnet"
  address_prefixes     = ["10.0.4.0/24"]
  virtual_network_name = azurerm_virtual_network.tf_main_vnet.name
  resource_group_name  = var.rg_name
}

## Peer subnets
#Create a Subnet
resource "azurerm_subnet" "tf_peer_subnet_a" {
  name                 = "tf-db-subnet-a"
  address_prefixes     = ["10.1.0.0/24"]
  virtual_network_name = azurerm_virtual_network.tf_peer_vnet.name
  resource_group_name  = var.rg_name
}
#Create a Subnet
resource "azurerm_subnet" "tf_peer_subnet_b" {
  name                 = "tf-db-subnet-b"
  address_prefixes     = ["10.1.1.0/24"]
  virtual_network_name = azurerm_virtual_network.tf_peer_vnet.name
  resource_group_name  = var.rg_name
}

#Create an AppService Subnet
resource "azurerm_subnet" "tf_peer_appservice_subnet" {
  name                 = "tf-ase-peer-subnet"
  address_prefixes     = ["10.1.3.0/24"]
  virtual_network_name = azurerm_virtual_network.tf_peer_vnet.name
  resource_group_name  = var.rg_name
}

#Create an Application Gateway Subnet
resource "azurerm_subnet" "tf_peer_appgateway_subnet" {
  name                 = "tf-peer-gateway-subnet"
  address_prefixes     = ["10.1.4.0/24"]
  virtual_network_name = azurerm_virtual_network.tf_peer_vnet.name
  resource_group_name  = var.rg_name
}

#Create a subnet for jumpserver vnet
resource "azurerm_subnet" "tf_bastion_subnet" {
  name                 = "jump-server-subnet"
  address_prefixes     = ["10.2.2.0/24"]
  virtual_network_name = azurerm_virtual_network.tf_jump_vnet.name
  resource_group_name  = var.rg_name
}

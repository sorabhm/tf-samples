#Create a hub Subnet
resource "azurerm_subnet" "azurelab_subnet_a" {
  name                 = "hub-subnet-a"
  address_prefixes     = ["10.10.0.0/24"]
  virtual_network_name = azurerm_virtual_network.azurelab_hub_vnet.name
  resource_group_name  = var.rgName_hub
}
#Create a hub Subnet
resource "azurerm_subnet" "azurelab_subnet_b" {
  name                 = "hub-subnet-b"
  address_prefixes     = ["10.10.1.0/24"]
  virtual_network_name = azurerm_virtual_network.azurelab_hub_vnet.name
  resource_group_name  = var.rgName_hub
}

## Peer subnets
#Create a spoke1 Subnet
resource "azurerm_subnet" "azurelab_spoke1_subnet_a" {
  name                 = "spoke1-subnet-a"
  address_prefixes     = ["10.11.0.0/24"]
  virtual_network_name = azurerm_virtual_network.azurelab_spoke1_vnet.name
  resource_group_name  = var.rgName_spoke1
}
#Create a spoke1 Subnet
resource "azurerm_subnet" "azurelab_spoke1_subnet_b" {
  name                 = "spoke1-subnet-b"
  address_prefixes     = ["10.11.1.0/24"]
  virtual_network_name = azurerm_virtual_network.azurelab_spoke1_vnet.name
  resource_group_name  = var.rgName_spoke1
}


## Peer subnets
#Create a spoke2 Subnet
resource "azurerm_subnet" "azurelab_spoke2_subnet_a" {
  name                 = "spoke2-subnet-a"
  address_prefixes     = ["10.12.0.0/24"]
  virtual_network_name = azurerm_virtual_network.azurelab_spoke2_vnet.name
  resource_group_name  = var.rgName_spoke2
}
#Create a spoke2 Subnet
resource "azurerm_subnet" "azurelab_spoke2_subnet_b" {
  name                 = "spoke2-subnet-b"
  address_prefixes     = ["10.12.1.0/24"]
  virtual_network_name = azurerm_virtual_network.azurelab_spoke2_vnet.name
  resource_group_name  = var.rgName_spoke2
}


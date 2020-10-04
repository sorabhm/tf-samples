variable "azure_region" {
  type        = string
  description = "Location/Region where network config is required"
}

variable "rgName_hub" {
  type        = string
  description = "Resource group name for the hub"
}

variable "rgName_spoke1" {
  type        = string
  description = "resource group name for spoke1"
}

variable "rgName_spoke2" {
  type        = string
  description = "resource group name for spoke2"
}

#Create a virtual network
resource "azurerm_virtual_network" "azurelab_hub_vnet" {
  name                = "hub_vnet"
  location            = var.azure_region
  address_space       = ["10.10.0.0/16"]
  resource_group_name = var.rgName_hub

  tags = {
    "Environment" = "azurelab_hubspoke"
    "Owner"       = "SM"
  }
}

#Create a virtual network
resource "azurerm_virtual_network" "azurelab_spoke1_vnet" {
  name                = "spoke1_vnet"
  location            = var.azure_region
  address_space       = ["10.11.0.0/16"]
  resource_group_name = var.rgName_spoke1

  tags = {
    "Environment" = "azurelab_hubspoke"
    "Owner"       = "SM"
  }
}

#Create a virtual network
resource "azurerm_virtual_network" "azurelab_spoke2_vnet" {
  name                = "spoke2_vnet"
  location            = var.azure_region
  address_space       = ["10.12.0.0/16"]
  resource_group_name = var.rgName_spoke2

  tags = {
    "Environment" = "azurelab_hubspoke"
    "Owner"       = "SM"
  }
}
#Creating VNet Peering - Hub to Spoke1
resource "azurerm_virtual_network_peering" "peer_hub_to_spoke1" {
  name                      = "peerhubtospoke1"
  resource_group_name       = var.rgName_hub
  virtual_network_name      = azurerm_virtual_network.azurelab_hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.azurelab_spoke1_vnet.id
}

#Creating Vnet peering
resource "azurerm_virtual_network_peering" "peer_spoke1_to_hub" {
  name                      = "peerspoke1tohub"
  resource_group_name       = var.rgName_spoke1
  virtual_network_name      = azurerm_virtual_network.azurelab_spoke1_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.azurelab_hub_vnet.id
}

#Creating VNet Peering - Hub to Spoke2
resource "azurerm_virtual_network_peering" "peer_hub_to_spoke2" {
  name                      = "peerhubtospoke2"
  resource_group_name       = var.rgName_hub
  virtual_network_name      = azurerm_virtual_network.azurelab_hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.azurelab_spoke2_vnet.id
}

#Creating Vnet peering
resource "azurerm_virtual_network_peering" "peer_spoke2_to_hub" {
  name                      = "peerspoke2tohub"
  resource_group_name       = var.rgName_spoke2
  virtual_network_name      = azurerm_virtual_network.azurelab_spoke2_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.azurelab_hub_vnet.id
}
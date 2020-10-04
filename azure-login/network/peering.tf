#Creating VNet Peering
resource "azurerm_virtual_network_peering" "tf_peer_1" {
  name                      = "peer1to2"
  resource_group_name       = var.rg_name
  virtual_network_name      = azurerm_virtual_network.tf_main_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.tf_peer_vnet.id
}

#Creating Vnet peering
resource "azurerm_virtual_network_peering" "tf_peer_2" {
  name                      = "peer2to1"
  resource_group_name       = var.rg_name
  virtual_network_name      = azurerm_virtual_network.tf_peer_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.tf_main_vnet.id
}

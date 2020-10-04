
#Create a NSG and association for Main Subnet A without rules
resource "azurerm_network_security_group" "tf_main_subnet_a_access_sg" {
  name                = "az_main_subnet_a_access_nsg"
  resource_group_name = var.rg_name
  location            = var.tf_sample_location
}

resource "azurerm_subnet_network_security_group_association" "vneta_main_subnet_a_nsg" {
  subnet_id                 = azurerm_subnet.tf_subnet_a.id
  network_security_group_id = azurerm_network_security_group.tf_main_subnet_a_access_sg.id
}

#Create a NSG and association for Main Subnet B without rules
resource "azurerm_network_security_group" "tf_main_subnet_b_access_sg" {
  name                = "az_main_subnet_b_access_nsg"
  resource_group_name = var.rg_name
  location            = var.tf_sample_location
}

resource "azurerm_subnet_network_security_group_association" "vneta_main_subnet_b_nsg" {
  subnet_id                 = azurerm_subnet.tf_subnet_b.id
  network_security_group_id = azurerm_network_security_group.tf_main_subnet_b_access_sg.id
}

#Create a NSG and association for Peer Subnet A without rules
resource "azurerm_network_security_group" "tf_peer_subnet_a_access_sg" {
  name                = "az_peer_subnet_a_access_nsg"
  resource_group_name = var.rg_name
  location            = var.tf_sample_location
}

resource "azurerm_subnet_network_security_group_association" "vnetdb_peer_subnet_a_nsg" {
  subnet_id                 = azurerm_subnet.tf_peer_subnet_a.id
  network_security_group_id = azurerm_network_security_group.tf_peer_subnet_a_access_sg.id
}

#Create a NSG and association for Peer Subnet B without rules
resource "azurerm_network_security_group" "tf_peer_subnet_b_access_sg" {
  name                = "az_peer_subnet_b_access_nsg"
  resource_group_name = var.rg_name
  location            = var.tf_sample_location
}

resource "azurerm_subnet_network_security_group_association" "vnetdb_peer_subnet_b_nsg" {
  subnet_id                 = azurerm_subnet.tf_peer_subnet_b.id
  network_security_group_id = azurerm_network_security_group.tf_peer_subnet_b_access_sg.id
}

#Create a NSG and association for Main Gateway Subnet without rules
resource "azurerm_network_security_group" "tf_main_gateway_subnet_access_sg" {
  name                = "az_main_gateway_subnet_access_nsg"
  resource_group_name = var.rg_name
  location            = var.tf_sample_location
}

#Create a NSG and association for Peer Gateway Subnet without rules
resource "azurerm_network_security_group" "tf_peer_gateway_subnet_access_sg" {
  name                = "az_peer_gateway_subnet_access_nsg"
  resource_group_name = var.rg_name
  location            = var.tf_sample_location
}


#Create a NSG for Bastion subnet and rules
resource "azurerm_network_security_group" "tf_bastion_subnet_access_sg" {
  name                = "az_bastion_access_nsg"
  resource_group_name = var.rg_name
  location            = var.tf_sample_location
  security_rule {
    name                       = "AllowHttpsInbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowGatewayManager"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSshOutbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_ranges         = ["22", "3389"]
    destination_port_ranges    = ["22", "3389"]
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AllowAzureCloudOutbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "443"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "AzureCloud"
  }
}

resource "azurerm_subnet_network_security_group_association" "jump_vnet_bastion_nsg" {
  subnet_id                 = azurerm_subnet.tf_bastion_subnet.id
  network_security_group_id = azurerm_network_security_group.tf_bastion_subnet_access_sg.id
}


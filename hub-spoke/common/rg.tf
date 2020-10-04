variable "azure_region" {
  type        = string
  description = "Region of the resource group"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

resource "azurerm_resource_group" "azurelab_06_rg" {
  name     = var.rg_name
  location = var.azure_region
  tags = {
    "Environment" = "azurelab_hubspoke"
    "Owner"       = "SM"
  }
}

output "output_rg_name" {
  value = azurerm_resource_group.azurelab_06_rg.name
}
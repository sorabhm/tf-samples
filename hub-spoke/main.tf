
provider "azurerm" {
  version = "=2.16.0"
  features {}
}

variable "azure_region" {
  type        = string
  description = "Location of all resources"
  default     = "southeastasia"
}

module "azurelab_hub_rg" {
  source       = "./common"
  rg_name      = "azurelab_hub_rg"
  azure_region = var.azure_region
}

module "azurelab_spoke1_rg" {
  source       = "./common"
  rg_name      = "azurelab_spoke1_rg"
  azure_region = var.azure_region
}

module "azurelab_spoke2_rg" {
  source       = "./common"
  rg_name      = "azurelab_spoke2_rg"
  azure_region = var.azure_region
}

module "lab_network" {
  source        = "./network"
  rgName_hub    = module.azurelab_hub_rg.output_rg_name
  rgName_spoke1 = module.azurelab_spoke1_rg.output_rg_name
  rgName_spoke2 = module.azurelab_spoke2_rg.output_rg_name
  azure_region  = var.azure_region
}


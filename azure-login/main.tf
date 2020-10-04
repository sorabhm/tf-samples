
provider "azurerm" {
  version = "=2.16.0"
  subscription_id = "d58ec9e1-3ea3-488c-be32-86b0c7dc5a1d"
  tenant_id       = "7170525b-ad36-4401-aa29-563e052040e2"
  features {}
}
variable "tf_sample_location" {
  type        = string
  description = "Location of all resources"
  default     = "southeastasia"
}

resource "azurerm_resource_group" "tf_sample_rg" {
  name     = "azurelabs_vmdemo_rg"
  location = var.tf_sample_location
  tags = {
    "Environment" = "demo"
    "Owner"       = "SM"
  }
}

module "network" {
  source = "./network"

  rg_name            = azurerm_resource_group.tf_sample_rg.name
  tf_sample_location = var.tf_sample_location
}


# module "vm_networka_subneta" {
#   source             = "./compute"
#   rg_name            = azurerm_resource_group.tf_sample_rg.name
#   tf_sample_location = var.tf_sample_location
#   subnetId           = module.network.tf_subneta_id
#   vmSuffix           = "web-one"
#   vmCount            = 2
# }

data "azurerm_client_config" "current" {
}


resource "azurerm_key_vault" "azurelab_kv" {
  name                        = "azurelabskeyvault4681"
  location                    = var.tf_sample_location
  resource_group_name         = azurerm_resource_group.tf_sample_rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = true
  purge_protection_enabled    = false


  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "3aab07ff-7581-4cf8-8073-005e7f1bf390"

    key_permissions = [
      "get","list","delete","create","decrypt","encrypt","wrapKey","unwrapKey",
    ]

    secret_permissions = [
      "get","list","delete","set","recover","backup","restore",
    ]

    storage_permissions = [
      "get",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  tags = {
    "Environment" = "demo"
    "Owner"       = "SM"
  }
}

#Storage account
resource "azurerm_storage_account" "azurelabs_storage_one" {
  name                     = "azlabstorage4681"
  resource_group_name      = azurerm_resource_group.tf_sample_rg.name
  location                 = var.tf_sample_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  tags = {
    "Environment" = "demo"
    "Owner"       = "SM"
  }
}
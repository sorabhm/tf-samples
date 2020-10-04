provider "azurerm" {
    version = "=2.16.0"
    features {}
}
variable "azure_region" {
    type = string
    description = "Location of all resources"
    default = "southeastasia"
}
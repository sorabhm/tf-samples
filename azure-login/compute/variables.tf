variable "rg_name" {
  type        = string
  description = "Resource group name where network is required to be setup"
}

variable "tf_sample_location" {
  type        = string
  description = "Location/Region where network config is required"
}

variable "subnetId" {
  type        = string
  description = "Id of the subnet for NSG rule"
}

variable "vmSuffix" {
  type        = string
  description = "random suffix for multiple vms to be created"
}

variable "vmCount" {
  type        = number
  description = "count of vms to be created"
  default     = 1
}
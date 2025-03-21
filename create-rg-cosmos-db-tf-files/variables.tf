variable "resource_group_location" {
  type        = string
  default     = "eastus2"
  description = "Location of the resource group."
}

variable "prefix" {
  type = string
  default = "cosmos-db-aci"
  description = "Prefix of the resource name"
}
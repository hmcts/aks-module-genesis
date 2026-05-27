variable "enable_debug" {
  default = "false"
}

# Common inputs for multiple resources
variable "tags" {
  description = "A map of individual tags. Some default tags will also be applied"
  type        = map(string)
  default     = {}
}

variable "purge_protection_enabled" {
  description = "Enable purge protection for the Key Vault. Once enabled, Azure does not allow it to be disabled."
  type        = bool
  default     = true
}

variable "location" {
  default = "uksouth"
}

variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "public_ip_names" {
  description = "A list of names of public IP addresses that are required."
  default     = []
}

variable "project" {
  description = "Name of project"
  default     = ""
}

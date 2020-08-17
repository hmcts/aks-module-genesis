variable "enable_debug" {
  default = "false"
}

# Common inputs for multiple resources
variable "tags" {
  description = "A map of individual tags. Some default tags will also be applied"
  type        = map(string)
  default     = {}
}

variable "location" {
  default = "UK South"
}

variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "features" {
  type = list(string)
  default = [
    "storage_account",
    "key_vault",
    "container_registry"
  ]
}
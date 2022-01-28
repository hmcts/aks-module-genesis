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
  default = "uksouth"
}

variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "public_ip_names" {
  description = "A list of names of public IP addresses that are required."
  default = []
}

variable "project" {
  description = "Name of project"
  default = "cft"
}
variable "location" {
  type    = string
  default = "eastus"
}
variable "prefix" {
  type    = string
  default = "ubuntuvm"
}

variable "ssh-source-address" {
  type    = string
  default = "*"
}
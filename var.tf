variable "location" {
  type    = string
  default = "eastus"
}
variable "prefix" {
  type    = string
  default = "ubuntuvm"
}

variable "vmuser" {
  type    = string
  default = "ubuntu_user"
}

variable "ssh-source-address" {
  type    = string
  default = "*"
}
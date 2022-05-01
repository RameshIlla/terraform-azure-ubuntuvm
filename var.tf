variable "location"{
    type =  string
    default = "Singapore"
}
variable "prefix"{
    type = string
    default="demoprefix"
}
variable "ssh-source-address" {
    type=string
    default="*"
}
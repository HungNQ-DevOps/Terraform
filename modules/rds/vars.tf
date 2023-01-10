### RDS
variable "username" {
  type = string
  default = "admin"
  sensitive = true
}

variable "password" {
  type = string
  default = "admin2022"
  sensitive = true
}
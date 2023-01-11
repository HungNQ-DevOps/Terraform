### RDS
variable "owner" {
  type = string
}

variable "username" {
  type = string
  sensitive = true
}

variable "password" {
  type = string
  sensitive = true
}

### ec2

variable "instance" {
  type = map(string)
  default = {
    "ami" = "ami-06bb3ee01d992f30d"
    "type" = "t1.micro"
  }
}
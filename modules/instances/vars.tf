### EC2

variable "instance_type" {
  type = string
  description = "Instance type of the EC2"
  default = "t2.micro"
}

variable "ami_id" {
  type = string
  default = "ami-0574da719dca65348"
}

### RDS

variable "username" {
  type = string
  default = "admin"
  # sensitive = true
}

variable "password" {
  type = string
  default = "admin2022"
  # sensitive = true
}

### VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

### Subnet
variable "public_subnet" {
  default = {
    subnet_name = "public_subnet_demo_terraform"
    cidr        = "10.0.1.0/24"
  }
}

variable "private_subnet" {
  default = {
    subnet_name = "private_subnet_demo_terraform"
    cidr_01 = "10.0.2.0/24"
    cidr_02 = "10.0.3.0/24"
  }
}

variable "region" {
  type = string
}
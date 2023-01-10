resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "default_1a" {
  availability_zone = "us-west-1a"
}

resource "aws_default_subnet" "default_1b" {
  availability_zone = "us-west-1b"
}


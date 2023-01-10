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

resource "aws_db_subnet_group" "setup_iam_auth_database" {
  name = "setup_iam_auth_database"
  subnet_ids = [
    aws_default_subnet.default_1a.id,
    aws_default_subnet.default_1b.id
  ]
}
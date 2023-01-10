resource "aws_security_group" "public_web" {
  name = "public_web"
  vpc_id = aws_vpc.demo_terraform.id
  # allow http
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # allow https
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# allow ssh
resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  vpc_id = aws_vpc.demo_terraform.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# rds security group only access from web server
resource "aws_security_group" "access_db_only_web" {
  name = "access_db_only_web"
  # vpc only
  vpc_id = aws_vpc.demo_terraform.id
  ingress {
    from_port = "3306"
    to_port = "3306"
    protocol = "tcp"
    security_groups = [
      aws_security_group.allow_ssh.id,
      aws_security_group.public_web.id
    ]
  }
}
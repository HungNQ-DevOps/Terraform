# --- rds security group allows to access from all IPv4 address ---

resource "aws_security_group" "access_db_public_allIPv4" {
  name = "access_db_public_allIPv4"
  vpc_id = aws_default_vpc.default.id
  ingress {
    from_port = "3306"
    to_port = "3306"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "access_from_only_bastion_host" {
  name = "access_from_only_bastion_host"
  vpc_id = aws_default_vpc.default.id
  ingress {
    from_port = "3306"
    to_port = "3306"
    protocol = "tcp"
    security_groups = [aws_security_group.allow_ssh_bastion_host.id]
  }
}

# --- rds security group allows to access from all IPv4 address ---

resource "aws_security_group" "allow_ssh_bastion_host" {
  name = "allow_ssh_bastion_host"
  vpc_id = aws_default_vpc.default.id

  # allow ssh
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

  tags = {
    "Owner" = var.owner
  }
}
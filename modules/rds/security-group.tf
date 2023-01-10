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
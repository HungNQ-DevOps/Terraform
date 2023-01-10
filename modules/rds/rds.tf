resource "aws_db_instance" "rds" {
  db_name = "access_db_public_allIPv4"
  allocated_storage = "5"
  engine = "mysql"
  engine_version = "8.0.28"
  instance_class = "db.t3.micro"
  username = var.username
  password = var.password
  skip_final_snapshot  = true
  ### security groups
  db_subnet_group_name = aws_db_subnet_group.setup_iam_auth_database.id
  vpc_security_group_ids = [aws_security_group.access_db_public_allIPv4.id]
  ### Parameter Group configuration
  parameter_group_name = "default.mysql8.0"
}
resource "aws_db_instance" "demo_terraform" {
  db_name = "demo_terraform_sql"
  allocated_storage = "5"
  engine = "mysql"
  engine_version = "8.0.28"
  instance_class = "db.t3.micro"
  username = var.username
  password = var.password
  skip_final_snapshot  = true
  ### security groups
  db_subnet_group_name = aws_db_subnet_group.demo_terraform.id
  vpc_security_group_ids = [aws_security_group.access_db_only_web.id]
  ### Parameter Group configuration
  parameter_group_name = aws_db_parameter_group.enableGenaralLog.name
}

resource "aws_db_parameter_group" "enableGenaralLog" {
  name = "mysql-query-log-enable"
  family = "mysql8.0"

  parameter {
    name = "general_log"
    value = "1"
    apply_method = "immediate"
  }

  parameter {
    name = "slow_query_log"
    value = "1"
    apply_method = "immediate"
  }

  parameter {
    name = "log_output"
    value = "FILE"
    apply_method = "immediate"
  }

  lifecycle {
    create_before_destroy = true
  }
}
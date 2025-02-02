resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-rds-sg"
  description = "Security group for RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }
}

resource "aws_db_subnet_group" "core_db_subnet" {
  name       = "${var.environment}-core-db-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "core_db" {
  allocated_storage    = 100
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.m5.large"
  username             = var.db_credentials.username
  password             = var.db_credentials.password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.core_db_subnet.name
}
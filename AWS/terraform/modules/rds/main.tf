
resource "aws_db_instance" "techdiversa_db" {
  identifier              = "techdiversa-db"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "15"
  instance_class          = "db.t3.micro"
  db_name                 = "techdb"
  username                = var.db_user
  password                = var.db_pass
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [var.db_sg_id]
  skip_final_snapshot     = true
  backup_retention_period = 7
  multi_az                = false
  storage_encrypted       = true
  publicly_accessible     = false
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "techdiversa-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "techdiversa-db-subnet-group"
  }
}

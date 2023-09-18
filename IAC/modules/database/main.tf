resource "aws_secretsmanager_secret" "db-secret-phong" {
  name = "db-secret-phong"
}

resource "random_password" "password_db" {
  length           = 16
  special          = true
  override_special = false
}
locals {
  secrets = jsonencode({
    host       = aws_db_instance.database.address
    identifier = "${var.postgres_identifier}-db-instance"
    dbname     = var.postgres_name
    username   = var.postgres_user_name
    password   = random_password.password_db.result
    port       = var.postgres_port
  })
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id     = aws_secretsmanager_secret.db-secret-phong.id
  secret_string = local.secrets
}




resource "aws_db_instance" "database" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "14.7"
  instance_class         = "db.t3.micro"
  identifier             = var.postgres_name
  username               = var.postgres_user_name
  password               = random_password.password_db.result
  publicly_accessible    = false
  parameter_group_name   = "default.postgres14"
  db_subnet_group_name   = var.vpc.database_subnet_group
  vpc_security_group_ids = [var.sg]
  skip_final_snapshot    = true
  storage_encrypted      = true
  kms_key_id             = var.kms-aws-key
}


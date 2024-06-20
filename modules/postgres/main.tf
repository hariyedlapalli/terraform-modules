resource "aws_db_instance" "default" {
  count                = length(var.instances)

  allocated_storage    = var.instances[count.index].allocated_storage
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = var.instances[count.index].engine_version
  instance_class       = var.instances[count.index].instance_class
  name                 = var.instances[count.index].db_name
  username             = var.instances[count.index].db_username
  password             = var.instances[count.index].db_password
  parameter_group_name = "default.postgres9.6"
  db_subnet_group_name = var.instances[count.index].subnet_group_name
  vpc_security_group_ids = var.instances[count.index].vpc_security_group_ids

  tags = {
    Name = var.instances[count.index].name
  }
}
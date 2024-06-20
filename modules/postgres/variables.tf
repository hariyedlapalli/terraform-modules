variable "instances" {
  description = "A list of PostgreSQL instance configurations"
  type = list(object({
    allocated_storage    = number
    engine_version       = string
    instance_class       = string
    db_name              = string
    db_username          = string
    db_password          = string
    subnet_group_name    = string
    vpc_security_group_ids = list(string)
    name                 = string
  }))
}
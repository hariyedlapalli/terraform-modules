variable "postgresql_instances" {
  description = "List of PostgreSQL instance configurations"
  type = list(object({
    name                = string
    location            = string
    administrator_login = string
    administrator_password = string
    sku_name            = string
    version             = string
    storage_mb          = number
    backup_retention_days = number
    geo_redundant_backup = string
    auto_grow_enabled   = string
  }))
}

variable "postgresql_databases" {
  description = "Map of instance names to lists of database names to create in each instance"
  type = map(list(string))
}
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group, which contains the resources"
}
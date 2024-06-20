resource "azurerm_postgresql_server" "example" {
  count               = length(var.postgresql_instances)
  name                = var.postgresql_instances[count.index].name
  location            = var.postgresql_instances[count.index].location
  resource_group_name = var.resource_group_name

  administrator_login          = var.postgresql_instances[count.index].administrator_login
  administrator_login_password = var.postgresql_instances[count.index].administrator_password

  sku_name   = var.postgresql_instances[count.index].sku_name
  version    = var.postgresql_instances[count.index].version
  storage_mb = var.postgresql_instances[count.index].storage_mb

  backup_retention_days = var.postgresql_instances[count.index].backup_retention_days
  #geo_redundant_backup  = var.postgresql_instances[count.index].geo_redundant_backup
  auto_grow_enabled     = var.postgresql_instances[count.index].auto_grow_enabled

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}
/*resource "azurerm_postgresql_database" "example" {
  for_each            = { for inst, dbs in var.postgresql_databases : inst => dbs if contains(keys(var.postgresql_databases), inst) }
  count               = length(each.value)
  name                = each.value[count.index]
  resource_group_name = var.resource_group_name
  server_name         = each.key
  charset             = "UTF8"
  collation           = "English_United States.1252"
}*/
resource "azurerm_postgresql_database" "example" {
  for_each = toset(flatten([
    for inst, dbs in var.postgresql_databases : [
      for db in dbs : {
        server_name = inst
        db_name     = db
      }
    ]
  ]))

  name                = each.value.db_name
  resource_group_name = var.resource_group_name
  server_name         = each.value.server_name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
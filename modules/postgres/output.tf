output "postgresql_server_ids" {
  value = { for instance in azurerm_postgresql_server.example : instance.name => instance.id }
}

output "postgresql_database_ids" {
  value = { for db in azurerm_postgresql_database.example : db.name => db.id }
}
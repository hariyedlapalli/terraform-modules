/*resource "azurerm_resource_group" "myrg" { #this is the refrence it will be managed by terraform to store your logs
  name = "${local.resource_name_prefix}-${var.resource_group_name}"
  #sap-dev-rg-default
  location = var.resource_group_location
  tags     = local.common_tags
}*/
#var.resource_group_name
#var.resource_group_location
#var.vnet_name
resource "azurerm_virtual_network" "vnet" {
  name = "${local.resource_name_prefix}-${var.vnet_name}"
  #this vnet need to be part of your resource group and resource group location
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

  tags = local.common_tags

}
resource "azurerm_subnet" "web_subnet" {
  name                 = "${local.resource_name_prefix}-${var.web_subnet_name}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.web_subnet_address
}
locals {
  owners               = var.business_devision
  environment          = var.environment
  resource_name_prefix = "${var.business_devision}-${var.environment}"
  #sap-dev
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}
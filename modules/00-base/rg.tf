


data "azurerm_resource_group" "this" {
  name = "rg-${local.naming_convention}"
  //  location = var.region_zone

}

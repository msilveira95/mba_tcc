resource "azurerm_data_factory" "adfdev" {
  name                = "datafactory-apd"
  resource_group_name = "rg_mateus_apd_terraform"
  location            = "eastus2"
}

output "datafactory_id" {
  value = "${azurerm_data_factory.adfdev.id}"
}
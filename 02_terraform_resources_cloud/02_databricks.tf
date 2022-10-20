resource "azurerm_databricks_workspace" "adbdev" {
  name                = "databricks-apd"
  resource_group_name = "rg_mateus_apd_terraform"
  location            = "eastus2"
  sku                 = "standard"

  tags = {
    Environment = "Dev"
  }
}

output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.adbdev.workspace_url}/"
}

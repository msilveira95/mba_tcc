output "databricks_token" {
  value     = "dapibc34eee019dd96c409171bd617716bff-3" #Token Databricks criado manualmente
  sensitive = true
}

#Criando cluster databricks
resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = "apd_cluster"
  spark_version           = "10.4.x-scala2.12"
  node_type_id            = "Standard_DS3_v2" #Tipo de maquina
  driver_node_type_id     = "Standard_DS3_v2"
  autotermination_minutes = 10
  autoscale {
    min_workers = 1
    max_workers = 2
  }
}

#Criando linked service do Databricks com Data Factory
resource "azurerm_data_factory_linked_service_azure_databricks" "adb_adf_linked" {
  name                = "adb_linked_service"
  data_factory_id     = "/subscriptions/c135d4f9-b3a9-452e-bfa4-9898321cbaff/resourceGroups/rg_mateus_apd_terraform/providers/Microsoft.DataFactory/factories/datafactory-apd"
  description         = "ADB Linked Service via Access Token"
  existing_cluster_id = databricks_cluster.shared_autoscaling.id

  access_token = "SomeDatabricksAccessToken"
  adb_domain   = "https://adb-4072040278127018.18.azuredatabricks.net/?o=4072040278127018#"
}

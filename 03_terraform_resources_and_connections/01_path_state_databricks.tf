terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }

    databricks = {
      source = "databricks/databricks"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg_mateus_apd_terraform"
    storage_account_name = "adlmateusapdterraform"
    container_name       = "infra"
    key                  = "03_terraform_resources_and_connections/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "databricks" {
  host  = "https://adb-4072040278127018.18.azuredatabricks.net/?o=4072040278127018#" #URL databricks
  token = "dapibc34eee019dd96c409171bd617716bff-3"
}

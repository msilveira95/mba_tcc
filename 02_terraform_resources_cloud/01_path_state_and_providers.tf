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
    key                  = "02_terraform_resources_cloud/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
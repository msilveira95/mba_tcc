# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

#Criando um RG no Azure
resource "azurerm_resource_group" "rg" {
  name     = "rg_mateus_apd_terraform"
  location = "eastus2"

  tags = {
    Environment = "Terraform Getting Started"
    Team        = "Data Engineers"
  }
}

#Criando Data Lake Gen 2
resource "azurerm_storage_account" "storageacc" {
  name                     = "adlmateusapdterraform"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    managed-by = "terraform"
  }
}

#Criando permissões
resource "azurerm_role_definition" "example" {
  name  = "rule-for-terraform"
  scope = "/subscriptions/c135d4f9-b3a9-452e-bfa4-9898321cbaff" #id da assinatura

  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/delete",
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/write",
      "Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action"
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/subscriptions/c135d4f9-b3a9-452e-bfa4-9898321cbaff" #id da assinatura
  ]
}

#Permissão ao meu user para data lake gen 2
resource "azurerm_role_assignment" "role_adl" {
  scope              = "/subscriptions/c135d4f9-b3a9-452e-bfa4-9898321cbaff" #id da assinatura
  role_definition_id = azurerm_role_definition.example.role_definition_resource_id
  principal_id       = "644f092b-496b-49d9-8c34-a7ecaf46ad5f" #id do usuário
}

#Aguarda 5 minutos para permissões sincronizarem 
resource "null_resource" "previous" {}

resource "time_sleep" "wait_5_minutes" {
  depends_on = [null_resource.previous]

  create_duration = "300s"
}

resource "null_resource" "next" {
  depends_on = [time_sleep.wait_5_minutes]
}

#Criando container no data lake
resource "azurerm_storage_data_lake_gen2_filesystem" "raw" {
  name               = "raw"
  storage_account_id = azurerm_storage_account.storageacc.id
  lifecycle {
    prevent_destroy = true
  }
}

#Criando container no data lake
resource "azurerm_storage_data_lake_gen2_filesystem" "infra" {
  name               = "infra"
  storage_account_id = azurerm_storage_account.storageacc.id
  lifecycle {
    prevent_destroy = true
  }
}
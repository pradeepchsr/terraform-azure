terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.93.0"
    }
  }

  backend "azurerm" {
      resource_group_name  = "terraform-account-storage"
      storage_account_name = "pradeeptfbackend"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }
}



provider "azurerm" {
  features {}
}

 terraform {
    required_providers {
     azurerm = {
       source = "hashicorp/azurerm"
       version = "3.10"
     }
   }
 }

  provider "azurerm" {
    subscription_id = "93763fc6-a0b9-4c16-a3a2-9b8433de3914"
    tenant_id = "e40e040b-6b5f-48d1-9d70-bfc99ff628ac"
   features {}
 }

#State File on Storage account
terraform {
  backend "azurerm" {
    resource_group_name  = "DY-DO-NOT-DELETE"
    storage_account_name = "storageaccoutntfstate"
    container_name       = "windowstfstate"
    key                  = "prod.terraform.tfstate"
  }
}
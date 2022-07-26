# Create resource group
resource "azurerm_resource_group" "rg1" {
  name     =  "mav-rg1"
  location = "eastus2"
}

#Get Password from KeyVault
data "azurerm_key_vault" "keyvault" {
  name                = "kayvaultstorepass"
  resource_group_name = "DY-DO-NOT-DELETE"
}

data "azurerm_key_vault_secret" "keyvaultsecret" {
  name         = "windowspassword"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

#Network resources
module "network-config" {
    source = "./module/network"
    resource_group = azurerm_resource_group.rg1.name
    location = azurerm_resource_group.rg1.location
    vnet_address = ["12.0.0.0/16"]
    web_subnet_address = ["12.0.1.0/24"]
    app_subnet_address = ["12.0.2.0/24"]
    db_subnet_address = ["12.0.3.0/24"]
depends_on = [
  azurerm_resource_group.rg1
]
}

#Create VM
module "vm" {
  source = "./module/vm"
  resource_group = azurerm_resource_group.rg1.name
  location = azurerm_resource_group.rg1.location
  vmsize = "Standard_F2"
  webvmname = "webserver001"
  websubnet_id = module.network-config.app_subnet_id
  webvmusername = "webadminuser1"
  webvmpassword = data.azurerm_key_vault_secret.keyvaultsecret.value
  appvmname = "appserver001" 
  appsubnet_id = module.network-config.app_subnet_id
  appvmusername = "appadminuser1"
  appvmpassword = data.azurerm_key_vault_secret.keyvaultsecret.value
  dbvmname = "dbserver001"
  dbsubnet_id = module.network-config.db_subnet_id
  dbvmusername = "dbadminuser1"
  dbvmpassword = data.azurerm_key_vault_secret.keyvaultsecret.value  
  depends_on = [
    module.network-config
  ]
}
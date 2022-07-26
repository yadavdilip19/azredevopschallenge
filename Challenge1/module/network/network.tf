resource "azurerm_virtual_network" "vnet" {
  name                = "vnet1"
  resource_group_name = var.resource_group
  location            = var.location
  address_space       = var.vnet_address
}

resource "azurerm_subnet" "web-subnet" {
  name                 = "web-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group
  address_prefixes     = var.web_subnet_address
}

resource "azurerm_subnet" "app-subnet" {
  name                 = "app-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group
  address_prefixes     = var.app_subnet_address
}

resource "azurerm_subnet" "db-subnet" {
  name                 = "db-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group
  address_prefixes     = var.db_subnet_address
}


################# NSG Rule
resource "azurerm_network_security_group" "web-nsg" {
  name                = "web-nsg"
  location            = var.location
  resource_group_name = var.resource_group
  
  security_rule {
    name                       = "acesss-rule-1"
    priority                   = 500
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "12.0.2.0/24"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
                }
  
  security_rule {
    name                       = "access-rule-2"
    priority                   = 501
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_address_prefix      = "12.0.3.0/24"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
                }
}

resource "azurerm_network_security_group" "app-nsg" {
  name                = "app-nsg"
  location            = var.location
  resource_group_name = var.resource_group
  
  security_rule {
    name                       = "acesss-rule-1"
    priority                   = 500
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "12.0.1.0/24"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
                }
  
  security_rule {
    name                       = "access-rule-2"
    priority                   = 501
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "12.0.1.0/24"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
                }
}
resource "azurerm_network_security_group" "db-nsg" {
    name = "db-nsg"
    location = var.location
    resource_group_name = var.resource_group

    security_rule {
        name = "access-rule-1"
        priority = 500
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_address_prefix = "12.0.2.0/24"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "*"
    }
    
    security_rule {
        name = "access-rule-2"
        priority = 501
        direction = "Outbound"
        access = "Allow"
        protocol = "Tcp"
        source_address_prefix = "12.0.2.0/24"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "*"
    }
    
    security_rule {
        name = "access-rule-3"
        priority = 502
        direction = "Outbound"
        access = "Deny"
        protocol = "Tcp"
        source_address_prefix = "12.0.1.0/24"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "*"
    }
}

resource "azurerm_subnet_network_security_group_association" "web-nsg-subnet" {
  subnet_id                 = var.web_subnet_id
  network_security_group_id = azurerm_network_security_group.web-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "app-nsg-subnet" {
  subnet_id                 = var.app_subnet_id
  network_security_group_id = azurerm_network_security_group.app-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "db-nsg-subnet" {
  subnet_id                 = var.db_subnet_id
  network_security_group_id = azurerm_network_security_group.db-nsg.id
}



################# Output
output "network_name" {
  value = azurerm_virtual_network.vnet.name
  description = "Name of the Virtual network"
}

output "web_subnet_id" {
  value = azurerm_subnet.web-subnet.id
  description = "Id of websubnet in the network"
}

output "app_subnet_id" {
  value = azurerm_subnet.app-subnet.id
  description = "Id of appsubnet in the network"
}

output "db_subnet_id" {
  value = azurerm_subnet.db-subnet.id
  description = "Id of dbsubnet in the network"
}

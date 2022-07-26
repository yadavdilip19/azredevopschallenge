############ Web VM Confiuration
resource "azurerm_network_interface" "webnic-1" {
  name                = "webnic1"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.websubnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "webvm1" {
  name                = var.webvmname
  resource_group_name = var.resource_group
  location            = var.location
  size                = var.vmsize
  admin_username      = var.webvmusername
  admin_password      = var.webvmpassword
  network_interface_ids = [
    azurerm_network_interface.webnic-1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

############ Application VM Configuration
resource "azurerm_network_interface" "appnic-1" {
  name                = "appnic1"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.appsubnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "appvm1" {
  name                = var.appvmname
  resource_group_name = var.resource_group
  location            = var.location
  size                = var.vmsize
  admin_username      = var.appvmusername
  admin_password      = var.appvmpassword
  network_interface_ids = [
    azurerm_network_interface.appnic-1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

############ Database VM Configuration
resource "azurerm_network_interface" "dbnic-1" {
  name                = "dbnic1"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.dbsubnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "dbvm1" {
  name                = var.dbvmname
  resource_group_name = var.resource_group
  location            = var.location
  size                = var.vmsize
  admin_username      = var.dbvmusername
  admin_password      = var.dbvmpassword
  network_interface_ids = [
    azurerm_network_interface.dbnic-1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

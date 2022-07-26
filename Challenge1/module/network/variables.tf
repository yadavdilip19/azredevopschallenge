variable "resource_group" {
    description = "This specifies the resource group of the virtual network"
    type = string
}   

variable "location" {
    description = "This specifies the location of the virtual network" 
    default = "eastus"
    type = string
}

variable "vnet_address" {
    description = "This specifies the address space of the virtual network"
    type = list
}

variable "web_subnet_address" {
    description = "This specifies the address space of the web subnet"
    type = list
}

variable "app_subnet_address" {
    description = "This specifies the address space of the app subnet"
    type = list
}

variable "db_subnet_address" {
    description = "This specifies the address space of the db subnet"
    type = list
}

variable "web_subnet_id" {
    description = "This specifies the address space of the web subnet"
    type = string
}

variable "app_subnet_id" {
    description = "This specifies the address space of the app subnet"
    type = string
}

variable "db_subnet_id" {
    description = "This specifies the address space of the db subnet"
    type = string
}
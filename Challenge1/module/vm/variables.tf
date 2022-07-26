variable "resource_group" {
    description = "This specifies the resource group of the Windows VM"
    type = string
}   

variable "location" {
    description = "This specifies the location of the Windows VM" 
    default = "eastus2"
    type = string
}

variable "vmsize" {
    description = "This specifies the size of Windows VM" 
    type = string
}

############ Web VM Config
variable "websubnet_id" {
    description = "This specifies the id of websubnet" 
    type = string
}

variable "webvmname" {
    description = "This specifies the Name of Web Windows VM" 
    type = string
}

variable "webvmusername" {
    description = "This specifies the username of Web Windows VM" 
    type = string
}

variable "webvmpassword" {
    description = "This specifies the password of Web Windows VM" 
    type = string
}

############ App VM Config
variable "appsubnet_id" {
    description = "This specifies the id of websubnet" 
    type = string
}

variable "appvmname" {
    description = "This specifies the Name of Web Windows VM" 
    type = string
}

variable "appvmusername" {
    description = "This specifies the username of Web Windows VM" 
    type = string
}

variable "appvmpassword" {
    description = "This specifies the password of Web Windows VM" 
    type = string
}

############ DB VM Config
variable "dbsubnet_id" {
    description = "This specifies the id of websubnet" 
    type = string
}

variable "dbvmname" {
    description = "This specifies the Name of Web Windows VM" 
    type = string
}

variable "dbvmusername" {
    description = "This specifies the username of Web Windows VM" 
    type = string
}

variable "dbvmpassword" {
    description = "This specifies the password of Web Windows VM" 
    type = string
}